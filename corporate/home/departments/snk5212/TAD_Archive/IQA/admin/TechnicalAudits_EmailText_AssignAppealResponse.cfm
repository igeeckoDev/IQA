<cfquery Datasource="UL06046" name="getROM" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	Corporate.IQARegion.TechnicalAudits_ROM as ROM, Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM
FROM
	Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE
	Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
	AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
	AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#Audit.OfficeName#'
</CFQUERY>

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

Dear #AssignEmail#:<br /><br />

<cfif Audit.AuditType2 eq "Full">A Full<cfelseif Audit.AuditType2 eq "In-Process">An In-Process</cfif> Technical audit was recently completed and the engineering manager has appealed one or more of the identified issues.<br /><br />

Click below to open the audit: #varAuditIdentifier#<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

This task has a due date of #dateformat(DueDate, "mm/dd/yyyy")#.<br /><br />

Please click the link to the audit and download the audit report. After completing your comments in the audit report spreadsheet, it can be uploaded using the above link.  IF you have questions or need assistance, please contact any member of the Technical Audit Team.<br /><br />

Thanks for your support of this technical audit.<br /><br />

Regards,<br /><br />

Technical Audit Team<br /><br />

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	#Audit.TAM# (Technical Audit Manager)
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	#Request.TechnicalAuditMailbox# (Technical Audit Manager)
</cfif><br />

#Audit.ROM# (Regional Operations Manager)<br />
#getROM.SQM# (Site Quality Manager)
</cfoutput>