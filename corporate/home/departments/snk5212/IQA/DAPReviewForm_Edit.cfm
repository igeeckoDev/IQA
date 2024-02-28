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
	DAPReviewForm_Users.RequiresReview_CompletedName

FROM DAPReviewForm_Answers, DAPReviewForm_Questions, DAPReviewForm_Users

WHERE DAPReviewForm_Users.ID = #URL.ID#
AND DAPReviewForm_Answers.qID = DAPReviewForm_Questions.ID
AND DAPReviewForm_Answers.UserID = DAPReviewForm_Users.ID
AND DAPReviewForm_Questions.Status IS NULL

ORDER BY qID, aID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<cfform method ="post" id="myform" name="myform" action="DAPReviewForm_EditSubmit.cfm?ID=#URL.ID#">

<cfoutput>
<!---
<b>Review Form Status:</b><br>
<cfif Output.RequiresReview eq "Yes" AND Output.RequiresReview_Completed NEQ "Yes">
	<cflock scope="session" timeout="6">
	   <cfif isDefined("SESSION.Auth.isLoggedIn")>
	       <cfif SESSION.Auth.AccessLevel eq "SU"
	           OR SESSION.Auth.AccessLevel eq "Admin">
					<u>DAP Manager Review Required</u>: Send Email to Lead Auditor and Manager?<br>
					Comments are required to be added
			</cfif>
		</cfif>
	</cflock>
<cfelseif Output.RequiresReview_Completed EQ "Yes">
	<u>DAP Manager Review Completed</u>: Comments Sent to Lead Auditor and Manager<br>
	<cflock scope="session" timeout="6">
	   <cfif isDefined("SESSION.Auth.isLoggedIn")>
	       <cfif SESSION.Auth.AccessLevel eq "SU"
	           OR SESSION.Auth.AccessLevel eq "Admin">
		           <br>
					Note: Form can be edited for editorial purposes only - email will not be sent.
			</cfif>
		</cfif>
	</cflock>
</cfif><br><br>
--->

<hr><br>

<b>Lead Auditor Name</b> (#Output.AuditorName#)<br />
<cfinput type="text" size="60" value="#Output.AuditorName#" name="AuditorName" data-bvalidator="required" data-bvalidator-msg="Lead Auditor Name: Required"><br /><br />

<b>Lead Auditor Email</b> (#Output.AuditorEmail#)<br />
<cfinput type="text" size="60" value="#Output.AuditorEmail#" name="AuditorEmail" data-bvalidator="required" data-bvalidator-msg="Lead Auditor Email: Required"><br /><br />

<b>Lead Auditor's Manager Email</b> (#Output.AuditorManagerEmail#)<br />
<cfinput type="text" size="60" value="#Output.AuditorManagerEmail#" name="AuditorManagerEmail" data-bvalidator="required" data-bvalidator-msg="Lead Auditor Email: Required"><br /><br />

<b>Reviewer Name/Email</b> (#Output.ReviewerName# / #Output.PostedBy#)<br>
<cfinput type="text" size="60" value="#Output.ReviewerName#" name="PostedBy" data-bvalidator="required" data-bvalidator-msg="Reviewer Email: Required"><br />
<cfinput type="text" size="60" value="#Output.PostedBy#" name="ReviewerName" data-bvalidator="required" data-bvalidator-msg="Reviewer Name: Required"><br /><br>

<b>Date Submitted by Reviewer</b><br>
#dateformat(Output.Posted, "mm/dd/yyyy")#<br><br>

<b>DA File Number</b> (#Output.DAFileNumber#)<br />
<cfinput type="text" size="60" value="#Output.DAFileNumber#" name="DAFileNumber" data-bvalidator="required" data-bvalidator-msg="DA File Number: Required"><br /><br />

<b>Project Number</b> (#Output.ProjectNumber#)<br />
<cfinput type="text" size="60" value="#Output.ProjectNumber#" name="ProjectNumber" data-bvalidator="required" data-bvalidator-msg="Project Number: Required"><br /><br />

<b>Program Audited</b> (#Output.ProgramAudited#)<br>
	<cfselect
	    queryposition="below"
	    name="ProgramAudited"
	    data-bvalidator="required"
	    data-bvalidator-msg="Program Audited: Select a Value">
	        <option value="#Output.ProgramAudited#">No Change</option>
	        <option value="CBTL">CBTL</option>
	        <option value="CTDP">CTDP</option>
	        <option value="CTF">CTF</option>
	        <option value="PPP">PPP</option>
	        <option value="TCP">TCP</option>
	        <option value="TPTDP">TPTDP</option>
			<option value="Multiple Programs">Multiple Programs</option>
	</cfselect><br><br>

<b>Multiple Programs</b><br>
If you selected "Multiple Programs" above, please list them here:<Br>
<cftextarea
	name="MultiplePrograms"
    cols="60"
    rows="6">
		<cfif isDefined("MultiplePrograms") AND len(MultiplePrograms)>
			#MultiplePrograms#
		<cfelse>
			No Comments Added
		</cfif>
</cftextarea>
<br /><br />
	
<b>Assessment Type</b> (#Output.AuditType#)<br>
	<cfselect
	    queryposition="below"
	    name="AuditType"
	    data-bvalidator="required"
	    data-bvalidator-msg="Audit Type: Select a Value">
	        <option value="#Output.AuditType#">No Change</option>
	        <option value="Annual">Annual</option>
	        <option value="Gap">Gap</option>
	        <option value="Initial">Initial</option>
	        <option value="Relocation">Relocation</option>
	        <option value="On Site Scope Expansion">On Site Scope Expansion</option>
	        <option value="Technical">Technical</option>
	</cfselect><br><br>
	
<b>DAP Scope Reviews</b> (#Output.DAPScopeReviews#)<br>
<cfselect
    queryposition="below"
    name="DAPScopeReviews"
    data-bvalidator="required"
    data-bvalidator-msg="DAP Scope Reviews: Select a Value">
        <option value="#Output.DAPScopeReviews#">No Change</option>
        <option value="1 scope completed">1 scope completed</option>
        <option value="2 scopes completed">2 scopes completed</option>
</cfselect><br><br>

<b>DAP Scope Reviews Comments</b>:<br />
<cftextarea
	name="DAPScopeReviews_Comments"
    cols="60"
    rows="6">#Output.DAPScopeReviews_Comments#</cftextarea>
<br /><br />
</cfoutput>

<hr><br>

<cfset i = 1>
<cfoutput query="Output">
<b>#i#</b> : #Question#<br>
<u>Current Answer</u>:
	<cfif Answer eq 1>
		<b>Yes</b>
		<cfset textAnswer = "Yes">
		<cfset numAnswer = 1>
	<cfelseif Answer eq 0>
		<b>No</b>
		<cfset textAnswer = "No">
		<cfset numAnswer = 0>
	<cfelseif Answer eq 2>
		<cfset textAnswer = "N/A">
		<cfset numAnswer = 2>	
	</cfif>
<br /><Br />

Yes / No:<br />
<cfselect
    queryposition="below"
    name="#ID#_Answer"
    data-bvalidator="required"
    data-bvalidator-msg="Question #i#: Select a Value">
        <option value="#numAnswer#" selected>#textAnswer#</option>
        <option value="1">Yes</option>
		<option value="0">No</option>
		<cfif i eq 4 
			or i eq 7 
			or i eq 6
			or i eq 8>
			<option value="2">N/A</option>
		</cfif>		
</cfselect>
<br /><br />

Comments:<br />
<cftextarea
	name="#ID#_Notes"
    cols="60"
    rows="6">#Notes#</cftextarea>
<br /><br />

<cfset i = i+1>
</cfoutput>

<!---
<cfoutput>
<b>DAP Manager Review Comments</b> - Add Review Comments - to be included in email to Lead Auditor / Manager:<br>
	<cftextarea
		name="ReviewNotes"
	    cols="60"
	    rows="6">#Output.RequiresReviewComments#</cftextarea>
</cfoutput><br><br>

<cfif Output.RequiresReview_Completed EQ "No" OR NOT LEN(Output.RequiresReview_Completed) or NOT Len(Output.resultsSentDate)>
	Send email to Lead Auditor and Manager to Complete the Review Form?<br>
	If No is selected, comments can be added but an email will not be sent. In order to complete the Review Form, select Yes<br><br>
	Yes (Sends Email) <cfinput type="Radio" Name="SendEmail" Value="1"><br>
	No (No Email Sent)<cfINPUT TYPE="Radio" NAME="SendEmail" value="0" checked><br><br>
<cfelseif Output.RequiresReview_Completed eq "Yes">
	<cfINPUT TYPE="Hidden" NAME="SendEmail" value="N/A" checked>
</cfif>
--->

<input type="submit" value="Confirm Survey Changes"><br /><br />

</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->