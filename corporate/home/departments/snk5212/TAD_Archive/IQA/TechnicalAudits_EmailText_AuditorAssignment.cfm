<!--- EMAIL ID 3 and 3a --->

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

You have been selected by your Manager to conduct a <cfif AuditType2 eq "Full">Full Technical Audit<cfelseif AuditType2 eq "In-Process">Technical Audit of an active project</cfif> as part of the <cfif AuditType2 eq "Full">Global Internal Technical Audit Program<cfelseif AuditType2 eq "In-Process">In-Process Technical Audit Program</cfif>.<br /><br />

<b>Task Assigned to</b>:<Br />
#AuditorEmail# (Assigned Auditor)<br />
This task has a due date of <b>#dateformat(AuditDueDate, "mm/dd/yyyy")#</b>.<br /><br />

<b>Audit Details</b>:<Br />
Click below to open the audit: #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><Br /><Br />

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

<b>Note</b>: If you have been involved in the assigned project as a trainer, please contact the Technical Audit Manager identified below so that an alternate project can be assigned.<br /><br />

<b>Training</b>: If you have not previously participated in a technical audit, you will need to complete the Oracle based course titled �Conducting Internal Technical Audits� prior to initiating your audit. For additional details on training, please reference <a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-QA-J0413/00-QA-J0413.docx">00-QA-J0413</a> Section 7.6.<br /><br />

For more information about the technical audit database, audit training, OTL, or recording your hours spent, please refere to the Technical Audit Database Job Aid - <a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-QA-J0413/00-QA-J0413.docx">00-QA-J0413</a>.<br /><br />

Should you have any questions, please contact any member of the audit team identified below.<br /><br />

Thanks in advance for your participation in this Internal Technical Audit.<br /><br />

Regards,<br />
Technical Audit Team<br /><br />

<cfif len(Audit.TAM)>
	#Audit.TAM# (Technical Audit Manager)
<cfelse>
	#Request.TechnicalAuditMailbox# (Technical Audit Manager)
</cfif><br />

<cfif AuditType2 eq "Full">
#Audit.ROM# (Regional Operations Manager)
</cfif>
</cfoutput>