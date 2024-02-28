<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT employee_email 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_number = '#form.EmpNo#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AuditUpdate" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET
NCEntered = 'Yes',
NCEntered_ReportUpload = 'Yes',
NCEnteredDate = #createODBCDate(curdate)#,
NCEnteredEmail = '#NameLookup.employee_email#',
Flag_CurrentStep = 'Non-Conformance Input Completed'

WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
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

<cfquery Datasource="UL06046" name="get" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
SELECT 
	Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM
FROM 
	Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE 
	Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
	AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
	AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#Audit.OfficeName#'
</CFQUERY>

<cfmail 
	to="#get.SQM#"
    from="#Request.TechnicalAuditMailbox#"
    replyto="#ReplyTo#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#Audit.AuditType2#) - Non-Conformance Items Entered"
    type="html"
    query="Audit">   
    Non-Conformances have been entered for Audit [Audit Identifier]<br /><br />
    
    Please enter SR/CAR Closure information by [SR/CAR Closed Due Dates]<br /><br />
    
    Link Here
</cfmail>

<cflocation url="TechnicalAudits_Reporting_Output.cfm?#CGI.QUERY_STRING#" addtoken="no">