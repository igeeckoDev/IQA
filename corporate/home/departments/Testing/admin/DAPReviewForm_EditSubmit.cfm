<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<cfoutput>
<!--- how many questions? --->
<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046">
SELECT
	*
FROM
	DAPReviewForm_Questions
WHERE
	Status IS NULL
ORDER BY
	ID
</CFQUERY>

    <cfloop query="numQuestions">
        <cfif isDefined("#ID#_Answer")>
            <CFQUERY Name="getID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID
            FROM DAPReviewForm_Answers
			WHERE qID = #ID#
			AND USERID = #URL.ID#
            </CFQUERY>

            <cfif isDefined("#ID#_Notes")>
        		<cfif len(Evaluate("Form.#ID#_Notes"))>
                	<cfset Notes = "#Evaluate("Form.#ID#_Notes")#">
                <cfelse>
                	<cfset Notes = "None Listed">
                </cfif>
        	</cfif>

			<CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE DAPReviewForm_Answers
			SET ANSWER = '#Evaluate("Form.#ID#_Answer")#',
			Notes = '#Notes#'
			WHERE ID = #getID.ID#
        	</CFQUERY>
		</cfif>
    </cfloop>
</cfoutput>

<cflock scope="session" timeout="6">
	<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE
		DAPReviewForm_Users
	SET
		<cfif Form.SendEmail eq 1>
		ResultsSentDate = #postDate#,
		ResultsSent = 'Yes',
		Confirm = 'Yes',
		<cfelseif Form.SendEmail eq 0>
		ResultsSentDate = null,
		ResultsSent = 'No',
		</cfif>
		ReviewerName = '#Form.ReviewerName#',
		DAFileNumber = '#Form.DAFileNumber#',
		ProjectNumber = '#Form.ProjectNumber#',
		ProgramAudited = '#Form.ProgramAudited#',
		AuditType = '#Form.AuditType#',
		AuditorName = '#Form.AuditorName#',
		AuditorEmail = '#Form.AuditorEmail#',
		AuditorManagerEmail = '#Form.AuditorManagerEmail#',
		RequiresReviewComments = '#Form.ReviewNotes#',

		RequiresReview = <cfif Form.9_Answer eq 1>'Yes'<cfelse>'No'</cfif>,

		RequiresReview_CompletedDate = #postDate#,
		RequiresReview_CompletedName = '#SESSION.Auth.Name#',
		DAPScopeReviews = '#Form.DAPScopeReviews#',
		DAPScopeReviews_Comments = '#Form.DAPScopeReviews_Comments#'
		
	WHERE
		ID = #URL.ID#
	</CFQUERY>
</cflock>

<cfif Form.SendEmail eq 1>
	<cfif form.9_Answer eq 1>
		<cfmail
			to="Cheryl.Adams@ul.com"
			replyto="Cheryl.Adams@ul.com, #Form.ReviewerName#"
			from="DAP_Review_Team@ul.com"
			subject="DAP/CTF/CBTL Audit Project Review � Project #Form.ProjectNumber#"
			type="HTML">
		The Quality Engineering, Performance Management group has a team of Reviewers who conducts periodic reviews of DAP, CTF and CBTL audit projects in order to help enhance the performance of Lead Auditors and to facilitate a consistent, high quality experience for our clients.<br><br>

		A review was recently completed of a project on which you served as Lead Auditor.  The project details and review results can be seen by following the link below:<br>
		<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/DAPReviewForm_Details.cfm?ID=#URL.ID#">DAP/CTF/CBTL Audit Project Review - #Form.ProjectNumber#</a><br><br>

		Please look at the project review closely.  Some good items/practices are highlighted.  Nice job!  There were also significant concerns identified.  It is important that you understand the concerns.  The Reviewer noted on the project review will contact you to discuss the review.  After the discussion, a plan will be determined for any additional requirements for continuing to serve as a Lead Auditor.<br><br>

		We look forward to working with you.<br><br>
		
		<b>Performance: DAP Performance Manager Comments</b><br>
		#Form.ReviewNotes#
		</cfmail>
	<cfelse>
		<cfmail
			to="Cheryl.Adams@ul.com"
			replyto="Cheryl.Adams@ul.com, #Form.ReviewerName#"
			from="DAP_Review_Team@ul.com"
			subject="DAP/CTF/CBTL Audit Project Review � Project #Form.ProjectNumber#"
			type="HTML">
		The Quality Engineering, Performance Management group has a team of Reviewers who conducts periodic reviews of DAP, CTF and CBTL audit projects in order to help enhance the performance of Lead Auditors and to facilitate a consistent, high quality experience for our clients.<br><br>

		A review was recently completed of a project on which you served as Lead Auditor.  The review results can be viewed by following this link:<br>
		<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/DAPReviewForm_Details.cfm?ID=#URL.ID#">DAP/CTF/CBTL Audit Project Review - #Form.ProjectNumber#</a><br><br>

		Please look at the project review closely.  Some good items/practices are highlighted.  Nice job!  Please note any suggestions identified.<br><br>

		Feel free to contact the Reviewer noted on the project review if you have questions.<br><br>

		Thanks for your service as a Lead Auditor!
		</cfmail>
	</cfif>
</cfif>
	
<cflocation url="#IQADir#DAPReviewForm_Details.cfm?ID=#URL.ID#" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->