<!--- EMAIL ID 11 and 11a --->

<cfoutput>

<cfif len(Audit.TAM)>
	<cfset ReplyTo = "#Audit.TAM#">
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
    <cfset AssignTaskTo = "Technical Audit Manager">
</cfif>

<Cfset DueDate = DateAdd('d', 14, curdate)>

<cfif AuditType2 eq "Full">
	<cfset AuditTypeID = "F">
<cfelse>
	<cfset AuditTypeID = "P">
</cfif>

<cfif RequestType eq "Test">
	<cfset RequestTypeID = "T">
<cfelse>
	<cfset RequestTypeID = "N">
</cfif>

<cfset AuditorLoc = #right(AuditorDept, 3)#>

<cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

Greetings,<br /><Br />

This e-mail is notification that the appeal decision is completed.<br /><br />

You have been assigned the task of inputting the non-conformances into the Technical Audit Database.<br /><br />

<cfif Audit.AudiType2 eq "Full">
Task Assigned To: #Form.Email# (Site Quality Manager)
<cfelseif Audit.AuditType2 eq "In-Process">
Task Assigned To: #ReplyTo# (Technical Audit Manager)
</cfif><br /><br />

Click below to open the audit: #varAuditIdentifier#<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
Link to Audit</a><br><br>

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

This task has a new due date of #dateformat(DueDate, "mm/dd/yyyy")#.
</cfoutput>