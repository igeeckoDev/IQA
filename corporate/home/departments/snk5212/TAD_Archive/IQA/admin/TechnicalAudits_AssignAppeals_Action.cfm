<!--- select Engineering Manager's info --->
<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT first_n_middle, 
	last_name, 
    employee_email as Email, 
    employee_number, 
    Location_Code as Location, 
    Department_Number as Department
    
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 

WHERE Person_ID = '#url.Person_ID#'
</CFQUERY>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="qEmpLookup">
    <!--- insert auditor into audit schedule table --->
    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    AppealAssignName = '#first_n_middle# #last_name#',
    AppealAssignEmail = '#Email#',
    AppealAssignDate = #createODBCDate(curDate)#,
    AppealAssign = 'Yes',
    <Cfset DueDate = DateAdd('d', 14, curdate)>
    AppealAssignDueDate = #createODBCDate(DueDate)#,
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />
    	Appeals Assigned<br />
        Name: #first_n_middle# #last_name#<Br />
        Email: #Email#<br>
        Appeal Due Date: #dateformat(DueDate, 'mm/dd/yyyy')#<br>
        Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
        Date: #curdate# #curTime#" CFSQLTYPE="CF_SQL_CLOB">
   
    WHERE 
    ID = #URL.ID# 
    AND Year_ = #URL.Year#
    </cfquery>
</cfoutput>

<CFQUERY Datasource="UL06046" NAME="Audit" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	<cfset ReplyTo = "#Audit.TAM#">
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
    <cfset AssignTaskTo = "Technical Audit Manager">
</cfif>

<!--- To:AppealAssignEmail --->
<cfmail
	to="#replyTo#"
    from="#Request.TechnicalAuditMailbox#"
    Subject="Internal Technical Audits of #ProjectNumber# (#AuditType2#) - Appeal Assignment"
    query="Audit"
    type="html">
    
    <cfinclude template="TechnicalAudits_EmailText_AssignAppeals.cfm">
    
</cfmail>

<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">