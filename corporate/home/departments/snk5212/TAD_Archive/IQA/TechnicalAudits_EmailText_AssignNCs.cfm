<!--- EMAIL ID 6 / 6a --->

<cfoutput>
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

Greetings,<br /><br />

A Technical audit has been completed as noted below. There were nonconformance(s) identified and/or audit item(s) that compliance could not be determined that require your attention.<br /><br />

Task assigned to: #Audit.EngManagerEmail# (Engineering Manager)<br /><br />

Click below to open the audit: #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a>
<br /><br />

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

This task has a due date of #dateformat(DueDate, "mm/dd/yyyy")#<br /><br />

For more information about the technical audit database, audit training, OTL, or recording your hours spent, please refer to the Technical Audit Database Job Aid - <a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-QA-J0413/00-QA-J0413.docx">00-QA-J0413</a>.<Br /><br />

Thanks in advance for your participation in the Global Internal Technical Audit Program.<br /><br />

If you have any questions concerning the above, please contact a member of the Technical Audit Team.<br /><br />

Regards,<br /><br />

Technical Audit Team<br /><br />

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	#Audit.TAM# (Technical Audit Manager)
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	#Request.TechnicalAuditMailbox# (Technical Audit Manager)
</cfif><br />

<cfif Audit.AuditType2 eq "Full">
#Audit.ROM# (Regional Operations Manager)<br />
#getROM.SQM# (Site Quality Manager)
</cfif>
</cfoutput>