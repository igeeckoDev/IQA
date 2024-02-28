<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Assign Non-Conformance Input">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
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

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<cfif isDefined("Form.Email") AND isDefined("Form.Submit")>

<cfmail 
	to="#FORM.Email#" 
    cc="#ReplyTo#"
    replyTo="#ReplyTo#"
    from="#Request.TechnicalAuditMailbox#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Non-Conformance Input Assignment"
    query="Audit"
    type="HTML">
    
    <cfset DueDate = #dateformat(AppealResponseDueDate, "mm/dd/yyyy")#>
    
	<cfinclude template="TechnicalAudits_EmailText_AssignNonConformanceInput.cfm">
</cfmail>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = "Non-Conformance Input Assignment Letter Sent to #FORM.Email#: #dateformat(curdate, "mm/dd/yyyy")#<br />
    Due Date: #dateformat(Form.DueDate, "mm/dd/yyyy")#<br />
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#<br><br>">

<CFQUERY BLOCKFACTOR="100" NAME="HistoryUpdate" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	TechnicalAudits_AuditSchedule
SET
	NCEnteredDueDate = #CreateODBCDate(Form.DueDate)#,
    NCEnteredAssignDate = #CreateODBCDate(curDate)#,
    NCEnteredAssign = 'Yes',
    NCEnteredAssignEmail = '#form.Email#',
    Flag_CurrentStep = 'Non-Conformance Input Assigned',    
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">

<cfelse>

<!--- select Engineering Manager's info --->
<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT employee_email as Email
    
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 

WHERE Person_ID = '#url.Person_ID#'
</CFQUERY>

<Cfoutput query="Audit">
<b>Email Details</b><br>
<u>To</u>: #qEmpLookup.Email#<br>
<u>From/CC</u>: Technical Audit Manager/Technical Audit Mailbox<br>
<u>Subject</u>: Internal Technical Audits - Non-Conformance Input Assignment<br><br>

<cfinclude template="TechnicalAudits_EmailText_AssignNonConformanceInput.cfm">

<cfFORM ACTION="#CGI.Script_Name#?#CGI.Query_String#" METHOD="POST" NAME="Email">

<Cfset DueDate = DateAdd('d', 14, curdate)>

<b>Change Due Date</b>: 
    <div style="position:relative; z-index:3">
    	<cfinput type="datefield" name="DueDate" required="yes" value="#dateformat(DueDate, 'mm/dd/yyyy')#" message="Please include the due date" validate="date">
    </div>
    
    <br /><br /><br />

	<input type="hidden" name="Email" value="#qEmpLookup.Email#">    
    <input type="submit" name="submit" align="absmiddle" border="0" value="Send Non-Conformance Input Assignment Email" />
</cfform>
</Cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->