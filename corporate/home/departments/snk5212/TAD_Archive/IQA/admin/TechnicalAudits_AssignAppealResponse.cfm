<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Assign Appeal Response">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.9 Assign Appeal Response<br /><br />
</cfoutput>
</div>

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

<cfif isDefined("Form.AppealResponseEmail") AND isDefined("Form.Submit")>

<cfmail 
	to="#FORM.AppealResponseEmail#" 
    cc="#Request.TechnicalAuditMailbox#"
    from="#Request.TechnicalAuditMailbox#"
    replyto="#replyTo#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Non-Conformance Appeal Response Assignment"
    query="Audit"
    type="HTML">
    
    <cfset DueDate = #dateformat(Form.DueDate, "mm/dd/yyyy")#>
    
    <cfset AssignEmail = "#Form.AppealResponseEmail#">
	<cfinclude template="#IQADir#TechnicalAudits_EmailText_AssignAppealResponse.cfm">
</cfmail>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = "Appeal Response Assignment Letter Sent to #FORM.AppealResponseEmail#: #dateformat(curdate, "mm/dd/yyyy")#<br />
    Due Date: #dateformat(Form.DueDate, "mm/dd/yyyy")#<br />
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#<br><br>">

<CFQUERY BLOCKFACTOR="100" NAME="HistoryUpdate" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	TechnicalAudits_AuditSchedule
SET
	AppealResponseDueDate = #CreateODBCDate(Form.DueDate)#,
    AppealResponseAssignDate = #CreateODBCDate(curDate)#,
    AppealResponseAssign = 'Yes',
    AppealResponseEmail = '#form.AppealResponseEmail#',
    Flag_CurrentStep = 'Engineering Manager Review Completed',
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">

<cfelse>

<!--- select Engineering Manager's info --->
<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT employee_email as AppealResponseEmail
    
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 

WHERE Person_ID = '#url.Person_ID#'
</CFQUERY>

<Cfoutput query="Audit">
<b>Email Details</b><br>
<u>To</u>: #qEmpLookup.AppealResponseEmail#<br>
<u>From/CC</u>: Technical Audit Manager/Technical Auditor Mailbox<br>
<u>Subject</u>: Internal Technical Audits - Non-Conformance Appeal Response Assignment<br><br>

<Cfset DueDate = DateAdd('d', 14, curdate)>

<cfset AssignEmail = "#qEmpLookup.AppealResponseEmail#">
<cfinclude template="#IQADir#TechnicalAudits_EmailText_AssignAppealResponse.cfm">

<cfFORM ACTION="#CGI.Script_Name#?#CGI.Query_String#" METHOD="POST" NAME="Email">

<b>Change Due Date</b>: 
    <div style="position:relative; z-index:3">
    <cfinput type="datefield" name="DueDate" required="yes" value="#dateformat(DueDate, 'mm/dd/yyyy')#" message="Please include the due date" validate="date">
    </div>
    
    <br /><br /><br />

	<input type="hidden" name="AppealResponseEmail" value="#qEmpLookup.AppealResponseEmail#">    
    <input type="submit" name="submit" align="absmiddle" border="0" value="Send Appeal Response Assignment Email" />
</cfform>
</Cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->