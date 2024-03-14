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

You have been assigned the Non-Conformance Appeal Decision from the #AuditType2# Technical Audit <B>#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#</B>.<Br><br>

Please follow the link below to view the audit details and report.<br /><Br>

<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br><br>

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

Your Appeal Decision of the Non-Conformances should be completed by the end of business on #dateformat(DueDate, "mm/dd/yyyy")#.<br /><br />

Thanks in advance for your participation.<br /><br />

Regards,<br />
Signature Here<br /><br>
</cfoutput>