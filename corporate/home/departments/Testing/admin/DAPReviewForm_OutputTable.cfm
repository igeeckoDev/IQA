<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form - Output Table">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Open blank DAP Review Form</b><br>
<cfoutput>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/getEmpNo.cfm?page=DAPReviewForm">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/getEmpNo.cfm?page=DAPReviewForm</a><br><br>
</cfoutput>
<b>Export Data</b><br>
<a href="DAPReviewForm_Export2.cfm">Export to Excel</a><br><br>

<b>Filter</b><br>
<u>View All</u><br>
 :: Current Filter: 
	<cfif len(cgi.query_string)>
		<cfoutput>
			<b>#cgi.query_string#</b>
		</cfoutput>
	<cfelse>
		None
	</cfif><br>
 :: <font class="warning">Clear All Statuses</font> - <a href="DAPReviewForm_OutputTable.cfm"><b>View All</b></a><br><br>

<u>Status</u><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?Type=Completed">All Completed</a><Br>
 :: <a href="DAPReviewForm_OutputTable.cfm?Type=Open">All Open</a> (Review Required)<Br>
 :: <a href="DAPReviewForm_OutputTable.cfm?Type=Significant">Reviews With Significant Issues</a><Br><br>

<u>Program Type</u><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?ProgramAudited=CBTL">CBTL</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?ProgramAudited=CTDP">CTDP</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?ProgramAudited=CTF">CTF</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?ProgramAudited=PPP">PPP</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?ProgramAudited=TCP">TCP</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?ProgramAudited=TPTDP">TPTDP</a><br><br>

<u>Assessment Type</u><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?AuditType=Annual">Annual</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?AuditType=Gap">Gap</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?AuditType=Initial">Initial</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?AuditType=Relocation">Relocation</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?AuditType=Scope Expansion">Scope Expansion</a><br>
 :: <a href="DAPReviewForm_OutputTable.cfm?AuditType=Technical">Technical</a><br><br>
 
<CFQUERY Name="Output_PostedBy" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT PostedBy 
FROM DAPReviewForm_Users
WHERE PostedBy <> 'Christopher.J.Nicastro@ul.com'
ORDER BY PostedBy
</cfquery>

<u>Reviewer</u><br>
<cfoutput query="Output_PostedBy">
 :: <a href="DAPReviewForm_OutputTable.cfm?postedBy=#postedBy#">#postedBy#</a><br>
</cfoutput><Br>

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	DAPReviewForm_Users.ID,
	DAPReviewForm_Users.Status,
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
	DAPReviewForm_Users.RequiresReview,
	DAPReviewForm_Users.RequiresReviewComments,
	DAPReviewForm_Users.ResultsSent,
	DAPReviewForm_Users.ResultsSentDate,
	DAPReviewForm_Users.RequiresReview_Completed,
	DAPReviewForm_Users.RequiresReview_CompletedDate,
	DAPReviewForm_Users.RequiresReview_CompletedName,
	DAPReviewForm_Users.DAPScopeReviews,
	DAPReviewForm_Users.DAPScopeReviews_Comments

FROM DAPReviewForm_Users

WHERE ID <> 1
AND Status IS NULL

<cfif isDefined("URL.Type")>
	<cfif URL.Type eq "Completed">
		AND ResultsSent = 'Yes'
	<cfelseif URL.Type eq "Open">
		AND (ResultsSent IS NULL OR ResultsSent = 'No')
	<cfelseif URL.Type eq "Significant">
		AND RequiresReview = 'Yes'
	</cfif>
</cfif>

<cfif isDefined("URL.ProgramAudited")>
AND ProgramAudited = '#URL.ProgramAudited#'
</cfif>

<cfif isDefined("URL.AuditType")>
AND AuditType = '#URL.AuditType#'
</cfif>

<cfif isDefined("URL.PostedBy")>
AND PostedBy = '#URL.PostedBy#'
</cfif>

ORDER BY ID DESC
</CFQUERY>

<Table border=1 width=1200>
<tr>
	<th>View Review Form</th>
	<th>Date Review Form Submitted</th>
	<th>Lead Auditor</th>
	<th>Reviewer</th>
	<th>Program Name</th>
	<th>Assessment Type</th>
	<th>Project Number</th>
	<th>Requires Review by Management</th>
	<th>DAP Manager Review Status</th>
	<th>Email to Lead Auditor Sent?</th>
	
	<cflock scope="SESSION" timeout="10">
		<cfif SESSION.Auth.AccessLevel eq "SU">
			<th>Remove Review</th>
		</cfif>
	</cflock>
	<th>DAP Scope Reviews</th>
</tr>
<cfoutput query="Output">
<tr>
	<td align="center"><a href="#IQADir#DAPReviewForm_Details.cfm?ID=#ID#">View</a></td>
	<td align="center">#dateformat(posted, "mm/dd/yyyy")#</td>
	<td nowrap><a href="DAPReviewForm_AuditorDetails.cfm?LeadAuditor=#AuditorEmail#">#AuditorName#</a></td>
	<td>#ReviewerName#</td>
	<td align="center">#ProgramAudited#</td>
	<td align="center">#AuditType#</td>
	<td>#ProjectNumber#</td>
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
	<cflock scope="SESSION" timeout="10">
		<cfif SESSION.Auth.AccessLevel eq "SU">
			<td><a href="DAPReviewForm_Remove.cfm?ID=#ID#">Remove Review</a></td>
		</cfif>
	</cflock>
	<td nowrap>
		<cfif len(DAPScopeReviews)>
			#DAPScopeReviews#
			<cfif len(DAPScopeReviews_Comments) OR DAPScopeReviews_Comments neq "No Comments">
				<br><br>
				#DAPScopeReviews_Comments#
			</cfif>
		</cfif>
	</td>	
</tr>
</cfoutput>
</table><br><br>

<CFQUERY Name="Output_Removed" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	DAPReviewForm_Users.ID,
	DAPReviewForm_Users.Status,
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
	DAPReviewForm_Users.RequiresReview,
	DAPReviewForm_Users.RequiresReviewComments,
	DAPReviewForm_Users.ResultsSent,
	DAPReviewForm_Users.ResultsSentDate,
	DAPReviewForm_Users.RequiresReview_Completed,
	DAPReviewForm_Users.RequiresReview_CompletedDate,
	DAPReviewForm_Users.RequiresReview_CompletedName,
	DAPReviewForm_Users.DAPScopeReviews,
	DAPReviewForm_Users.DAPScopeReviews_Comments

FROM DAPReviewForm_Users

WHERE Status = 'Removed'
ORDER BY ID DESC
</cfquery>

<font class="warning"><b>Removed Reviews</b></font><br>
<Table border=1 width=800>
<tr>
	<th>View Review Form</th>
	<th>Date Review Form Submitted</th>
	<th>Lead Auditor</th>
	<th>Reviewer</th>
	<th>Program Name</th>
	<th>Assessment Type</th>
	<th>DAP Scope Reviews</th>
	<th>Project Number</th>
	<th>Requires Review by Management</th>
	<th>DAP Manager Review Status</th>
	<th>Email to Lead Auditor Sent?</th>
	
	<cflock scope="SESSION" timeout="10">
		<cfif SESSION.Auth.AccessLevel eq "SU">
			<th>Reinstate Review</th>
		</cfif>
	</cflock>
	
</tr>
<cfoutput query="Output_Removed">
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
	<td>#ProjectNumber#</td>
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
	<cflock scope="SESSION" timeout="10">
		<cfif SESSION.Auth.AccessLevel eq "SU">
			<td><a href="DAPReviewForm_Reinstate.cfm?ID=#ID#">Reinstate Review</a></td>
		</cfif>
	</cflock>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->