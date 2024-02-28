<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Send Non-Conformance Assignment to Engineering Manager">
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

<cfif isDefined("Form.EngManager") AND isDefined("Form.Submit")>

<cfmail 
	to="#FORM.EngManager#" 
    from="#Request.TechnicalAuditMailbox#"
    cc="#ReplyTo#"
    replyto="#ReplyTo#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Audit Non-Conformance Assignment"
    query="Audit"
    type="HTML">
    
    <cfset DueDate = #dateformat(Form.DueDate, "mm/dd/yyyy")#>
    
	<cfinclude template="TechnicalAudits_EmailText_AssignNCs.cfm">
</cfmail>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = 
"Non-Conformance Assignment Letter Sent to #FORM.EngManager# (Engineering Manager): #dateformat(curdate, 'mm/dd/yyyy')#<br />
    Due Date: #dateformat(Form.DueDate, 'mm/dd/yyyy')#<br />
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#">

<CFQUERY BLOCKFACTOR="100" NAME="HistoryUpdate" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	TechnicalAudits_AuditSchedule
SET
	EngManagerDueDate = #CreateODBCDate(Form.DueDate)#,
    EngManagerDate = #CreateODBCDate(curDate)#,
    EngManagerAssign = 'Yes',
    Flag_CurrentStep = 'Non-Conformances Assigned to Engineering Manager',
    
	History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">

<cfelse>

<Cfoutput query="Audit">
<b>Email Details</b><br>
<u>To</u>: #EngManagerEmail#<br>
<u>From/CC</u>: Technical Audit Manager/Technical Audit Mailbox<br>
<u>Subject</u>: Internal Technical Audits - Audit Non-Conformance Assignment<br><br>

<Cfset DueDate = DateAdd('d', 14, curdate)>

<cfinclude template="TechnicalAudits_EmailText_AssignNCs.cfm">

<cfFORM ACTION="#CGI.Script_Name#?#CGI.Query_String#" METHOD="POST" NAME="Email">

<b>Change Due Date</b>: 
    <div style="position:relative; z-index:3">
    	<cfinput type="datefield" name="DueDate" required="yes" value="#dateformat(DueDate, 'mm/dd/yyyy')#" message="Please include the due date" validate="date">
    </div>
    <br /><br /><Br />

	<input type="hidden" name="EngManager" value="#EngManagerEmail#">    
    <input type="submit" name="submit" align="absmiddle" border="0" value="Send NC Assignment Email" />
</cfform>
</Cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->