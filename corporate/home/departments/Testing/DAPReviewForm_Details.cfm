<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Output" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	DAPReviewForm_Answers.ID as aID,
	DAPReviewForm_Answers.qID,
    DAPReviewForm_Answers.Answer,
    DAPReviewForm_Answers.Notes,

    DAPReviewForm_Questions.Question,
    DAPReviewForm_Questions.ID,
	DAPReviewForm_Questions.ProgramType,

    DAPReviewForm_Users.AuditorName,
    DAPReviewForm_Users.Posted,
    DAPReviewForm_Users.PostedBy,
	DAPReviewForm_Users.AuditorEmail,
    DAPReviewForm_Users.AuditorManagerEmail,
    DAPReviewForm_Users.ReviewerName,
	DAPReviewForm_Users.DAFileNumber,
	DAPReviewForm_Users.ProjectNumber,
	DAPReviewForm_Users.ProgramAudited,
	DAPReviewForm_Users.MultiplePrograms,
	DAPReviewForm_Users.AuditType,
	DAPReviewForm_Users.DAPScopeReviews,
	DAPReviewForm_Users.DAPScopeReviews_Comments,
	DAPReviewForm_Users.RequiresReview,
	DAPReviewForm_Users.RequiresReviewComments,
	DAPReviewForm_Users.ResultsSent,
	DAPReviewForm_Users.ResultsSentDate,
	DAPReviewForm_Users.RequiresReview_Completed,
	DAPReviewForm_Users.RequiresReview_CompletedDate,
	DAPReviewForm_Users.RequiresReview_CompletedName,
	DAPReviewForm_Users.Confirm

FROM DAPReviewForm_Answers, DAPReviewForm_Questions, DAPReviewForm_Users

WHERE
DAPReviewForm_Users.ID = #URL.ID#
AND DAPReviewForm_Answers.qID = DAPReviewForm_Questions.ID
AND DAPReviewForm_Answers.UserID = DAPReviewForm_Users.ID
AND DAPReviewForm_Questions.Status IS NULL
ORDER BY qID, aID
</CFQUERY>

<cfif len(Output.Confirm)>
	<cfif Output.Confirm eq "No">
		<cfoutput>
			<u>Required Action</u>:<Br>
			<a href="DAPReviewForm_Confirm.cfm?ID=#URL.ID#">Confirm This Review Form</a> - no further changes will be possible<br>
			<a href="DAPReviewForm_Edit.cfm?ID=#URL.ID#">Edit This Review Form</a><br><br>
		</cfoutput>
	</cfif>
</cfif>

<cflock scope="session" timeout="6">
    <cfif isDefined("SESSION.Auth.isLoggedIn")>
        <cfif SESSION.Auth.AccessLevel eq "SU"
            OR SESSION.Auth.AccessLevel eq "Admin">
            <cfoutput>
				<u>Available Actions</u>: (Access: IQA Superuser and DAP Review Management)<Br>
                 :: <a href="#IQADir_Admin#DAPReviewForm_OutputTable.cfm">DAP Review Form Output Table</a><br />
				 :: <a href="#IQADir_Admin#DAPReviewForm_Edit.cfm?ID=#URL.ID#">Edit This Review Form</a> (Editorial, or Review Required)<br /><br />
            </cfoutput>
        </cfif>
    </cfif>
</cflock>

<cfoutput>
<cfif Output.RequiresReview eq "Yes">
	<cfif Output.ResultsSent EQ "No">
	<b>Review Form Status:</b><br>
		<u>DAP Performance Manager Review Required</u>: The Review Form has been sent to the DAP Performance Manager for Review and Comment. The DAP Performance Manager will contact you to discuss the concerns you found during this review.<br><Br>
	<cfelseif Output.ResultsSent EQ "Yes">
	<b>Review Form Status:</b><br>
		<u>DAP Performance Manager Review Completed</u>: Comments Sent to Lead Auditor and Lead Auditor Manager<br><br>
	</cfif>
</cfif>

<cfif Output.RequiresReview eq "No">
	<u>DAP Review Form Completed</u>: Comments sent to Lead Auditor and Lead Auditor Manager<br><br>
</cfif>
</cfoutput>

<hr><br>

<cfoutput>
<b>Lead Auditor Name</b><Br />
#Output.AuditorName#<br /><br />

<b>Lead Auditor Email</b><Br />
#Output.AuditorEmail#<br /><br />

<b>Lead Auditor's Manager Email</b><Br />
#Output.AuditorManagerEmail#<br /><br />

<b>Reviewer Name/Email</b><br>
#Output.ReviewerName# / #Output.PostedBy#<br><br>

<b>Date</b><br>
#dateformat(Output.Posted, "mm/dd/yyyy")#<br><br>

<b>DA File Number</b><br>
#Output.DAFileNumber#<br /><br />

<b>Project Number</b><br>
#Output.ProjectNumber#<br /><br />

<b>Program Audited</b><br>
#Output.ProgramAudited#<br><br>

<cfif Output.MultiplePrograms neq "No Comments Added">
<u>Program Detail</u><br>
#Output.MultiplePrograms#<br><br>
</cfif>

<b>Assessment Type</b><br>
#Output.AuditType#<br><br>

<cfif len(Output.DAPScopeReviews)>
	<b>DAP Scope Reviews</b><br>
	#Output.DAPScopeReviews#<br><br>

	<b>DAP Scope Reviews - Comments</b><br>
	#Output.DAPScopeReviews_Comments#<br><br>
</cfif>

</cfoutput>

<cfset i = 1>
<cfset k = 1>
<cfset previousQuestionID = 0>

<cfoutput query="Output">
	<!--- to handle multiple responses to survey --->
	<cfif previousQuestionID eq qID AND previousQuestionID NEQ 0>
		<cfset i = i - 1>
        <cfset k = k + 1>
    <cfelse>
    	<cfset k = 1>
    </cfif>

<b>#i#</b> #Question#<br /><br />

<cfif i eq 4 AND ProgramAudited EQ "CTF"
	OR i eq 4 AND ProgramAudited EQ "CBTL"
	OR i eq 4 AND ProgramAudited EQ "Multiple Programs"
	
	OR i eq 8 AND ProgramAudited NEQ "CTF"
	AND i eq 8 AND ProgramAudited NEQ "CBTL"
	AND i eq 8 AND ProgramAudited NEQ "Multiple Programs">

	<b>Not Applicable</b><br><br>
<cfelse>
	<u>Answer</u>: <b><cfif Answer eq 1>Yes<cfelseif Answer eq 0>No<cfelse>N/A</cfif></b><br />
</cfif>

	<u>Comments</u>:<br />
	<cfif Notes EQ "No Comments Added">
		#Notes#
	<cfelse>
		<b>#Notes#</b>
	</cfif>
<br /><br />

<hr />
<br />
<cfset i = i+1>
<cfset previousQuestionID = qID>
</cfoutput>

<cflock scope="session" timeout="6">
    <cfif isDefined("SESSION.Auth.isLoggedIn")>

		<cfif SESSION.Auth.AccessLevel eq "SU"
	            OR SESSION.Auth.AccessLevel eq "Admin"
				OR SESSION.Auth.Username eq "Berger"
				OR SESSION.Auth.Username eq "Robsinson">

			<cfif len(Output.RequiresReviewComments)>
				<cfoutput>
				<b>DAP Manager Review Comments</b><br>
				#Output.RequiresReviewComments#
				</cfoutput>
			</cfif>

		</cfif>
	</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->