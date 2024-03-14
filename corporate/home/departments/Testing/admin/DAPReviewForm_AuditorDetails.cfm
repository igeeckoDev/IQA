<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form - Lead Auditor - #URL.LeadAuditor#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Open blank DAP Review Form</b><br>
<cfoutput>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/getEmpNo.cfm?page=DAPReviewForm">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/getEmpNo.cfm?page=DAPReviewForm</a><br><br>
</cfoutput>
<b>Export Data</b><br>
<a href="DAPReviewForm_Export2.cfm">Export to Excel</a><br><br>

<b>DAP Review Form - Output Table</b> (View all DAP Review Forms)<br>
<a href="DAPReviewForm_OutputTable.cfm">DAP Review Form Output Table</a><br><br>

<cfoutput>
<b>Lead Auditor</b> - #URL.LeadAuditor#<br><br>
</cfoutput>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	DAPReviewForm_Users.ID,
    DAPReviewForm_Users.AuditorName,
    DAPReviewForm_Users.Posted,
    DAPReviewForm_Users.PostedBy,
	DAPReviewForm_Users.AuditorEmail,
    DAPReviewForm_Users.AuditorManagerEmail,
    DAPReviewForm_Users.ReviewerName,
	DAPReviewForm_Users.DAFileNumber,
	DAPReviewForm_Users.ProjectNumber,
	DAPReviewForm_Users.ProgramAudited,
	DAPReviewForm_Users.AuditType,
	DAPReviewForm_Users.DAPScopeReviews,
	DAPReviewForm_Users.DAPScopeReviews_Comments,
	DAPReviewForm_Users.RequiresReview,
	DAPReviewForm_Users.RequiresReviewComments,
	DAPReviewForm_Users.ResultsSent,
	DAPReviewForm_Users.ResultsSentDate,
	DAPReviewForm_Users.RequiresReview_Completed,
	DAPReviewForm_Users.RequiresReview_CompletedDate,
	DAPReviewForm_Users.RequiresReview_CompletedName

FROM DAPReviewForm_Users

WHERE AuditorEmail = '#TRIM(URL.LeadAuditor)#'

ORDER BY ID
</CFQUERY>

<Table border=1 width=800>
<tr>
	<th>View Review Form</th>
	<th>Date Review Form Submitted</th>
	<th>Lead Auditor</th>
	<th>Reviewer</th>
	<th>Program Name</th>
	<th>Assessment Type</th>
	<th>DAP Scope Reviews</th>
	<th>Requires Review by Management</th>
	<th>Manager Review Status</th>
	<th>Review Status</th>
</tr>
<cfoutput query="Output">
<tr>
	<td align="center"><a href="#IQADir#DAPReviewForm_Details.cfm?ID=#ID#">View</a></td>
	<td align="center">#dateformat(posted, "mm/dd/yyyy")#</td>
	<td nowrap><a href="DAPReviewForm_AuditorDetails.cfm?LeadAuditor=#AuditorEmail#">#AuditorName#</a></td>
	<td>#ReviewerName#</td>
	<td align="center">#ProgramAudited#</td>
	<td align="center">#AuditType#</td>
	<td>
		<cfif len(DAPScopeReviews)>
			#DAPScopeReviews#
			<cfif len(DAPScopeReviews_Comments) OR DAPScopeReviews_Comments neq "No Comments">
				<br><br>
				#DAPScopeReviews_Comments#
			</cfif>
		</cfif>
	</td>
	<td align="center">
		<Cfif RequiresReview eq "Yes">
			Yes
		<cfelse>
			No
		</Cfif>
	</td>
	<td align="center">
		<cfif RequiresReview eq "Yes">
			<cfif ResultsSent eq "Yes">
				Review Completed
			<cfelse>
				Review Not Completed
			</cfif>
		<cfelse>
			N/A
		</cfif>
	</td>
	<td align="center">
		<cfif ResultsSent eq "Yes">
			Results Sent (#dateformat(ResultsSentDate, "mm/dd/yyyy")#)
		<cfelse>
			--
		</cfif>
	</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->