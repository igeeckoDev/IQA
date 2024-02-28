<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Send Request to Assign Auditor Email">
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

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.3 Send auditor assignment to the Regional Operations Manager<br /><br />
</cfoutput>
</div>

<cfoutput>
<b>Temporary Audit Number</b><br>
#URL.Year#-#URL.ID#-Technical Audit<br><br>
</cfoutput>

<cfif isDefined("Form.ROM") AND isDefined("Form.Submit")>

<Cfset DueDate = #dateformat(Form.DueDate, "mm/dd/yyyy")#>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="HistoryUpdate" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	TechnicalAudits_AuditSchedule
SET
	AuditorAssignmentDueDate = #CreateODBCDate(DueDate)#,
    AuditorAssignmentRequestDate = #CreateODBCDate(curDate)#,
    Flag_CurrentStep = 'Request to Assign Auditor',
    
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />
    	Request to Assign Auditor Letter Sent to #FORM.ROM# (Regional Operations Manager): #dateformat(curdate, "mm/dd/yyyy")#<br />
    	Due Date: #dateformat(DueDate, 'mm/dd/yyyy')#<br />
    	Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    	Date: #curdate# #curTime#" CFSQLTYPE="CF_SQL_CLOB">
    
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfmail 
	to="#FORM.ROM#"
    from="#Request.TechnicalAuditMailbox#"
    replyto="#ReplyTo#"
    cc="#ReplyTo#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Request to Assign Auditor"
    query="Audit"
    type="HTML">
    
	<Cfset DueDate = #dateformat(AuditorAssignmentDueDate, "mm/dd/yyyy")#>

	<cfinclude template="TechnicalAudits_EmailText_AssignAuditorRequest.cfm">
</cfmail>

	<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">

<cfelse>

<Cfoutput query="Audit">
<b>Email Details</b><br>
<u>To</u>: #ROM#<br>
<u>From/CC</u>: Technical Audit Manager<br>
<u>Subject</u>: Internal Technical Audit (#AuditType2#) - Request to Assign Auditor<br><br>

<Cfset DueDate = DateAdd('d', 14, curdate)>

<cfinclude template="TechnicalAudits_EmailText_AssignAuditorRequest.cfm">

<cfFORM ACTION="#CGI.Script_Name#?#CGI.Query_String#" METHOD="POST" NAME="Email">

<b>Change Due Date</b>: 
    <div style="position:relative; z-index:3">
    	<cfinput type="datefield" name="DueDate" required="yes" value="#dateformat(DueDate, 'mm/dd/yyyy')#" message="Please include the due date" validate="date">
    </div>
    <br /><br /><br />

	<input type="hidden" name="ROM" value="#ROM#">
    <input type="submit" name="submit" align="absmiddle" border="0" value="Send Auditor Request Email" />
</cfform>
</Cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->