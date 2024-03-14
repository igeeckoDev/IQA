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

You have been selected to conduct a #AuditType2# Technical Audit. Please follow the link below to view the audit details for #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#:<br /><Br>

<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br><br>

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

If you have not previously participated in a technical audit, a teleconference and e-Space session will be arranged to provide an overview of the technical audits, internal auditing principles, and the Internal Technical Audit Summary Report.<br /><br />

Please use Internal Technical Audit Summary Report (<a href="">00-QA-F0040</a>) during your audit.<br /><br />

Your technical audit should be completed by the end of business on #dateformat(AuditDueDate, "mm/dd/yyyy")#.<br /><br />

This timeline is in accordance with the 'Key Process Target Timelines and Escalation' requirements defined in the Internal Technical Audit Procedure (<a href="">link</a>), Section 11. If you have a conflict in meeting this time commitment, please notify #Request.TechnicalAuditManager# as soon as possible to discuss options.<br /><br />

The completed audit record should be sent to [Regional Operations Manager] with a copy to Lenore<Br /><Br />

If you have any questions while conducting these audits, please contact Cannon Sun (?) or #Request.TechnicalAuditManager#.<br /><br />

Thanks in advance for your participation.<br /><br />

Regards,<br />
Signature Here<br /><br>
</cfoutput>