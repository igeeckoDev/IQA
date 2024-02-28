<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Review Form">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<cflock scope="session" timeout="6">
	<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE
		DAPReviewForm_Users
	SET
		ReviewerName = '#Form.ReviewerName#',
		DAFileNumber = '#Form.DAFileNumber#',
		ProjectNumber = '#Form.ProjectNumber#',
		ProgramAudited = '#Form.ProgramAudited#',
		MultiplePrograms = '#Form.MultiplePrograms#',
		AuditType = '#Form.AuditType#',
		AuditorName = '#Form.AuditorName#',
		AuditorEmail = '#Form.AuditorEmail#',
		AuditorManagerEmail = '#Form.AuditorManagerEmail#',
		Confirm = 'Yes',
		RequiresReview = <cfif Form.9_Answer eq 1>'Yes'<cfelse>'No'</cfif>,
		ResultsSent = <cfif Form.9_Answer eq 0>'Yes'<cfelse>'No'</cfif>,
		ResultsSentDate = <cfif Form.9_Answer eq 0>#postDate#<cfelse>null</cfif>,
		DAPScopeReviews = '#Form.DAPScopeReviews#',
		DAPScopeReviews_Comments = '#Form.DAPScopeReviews_Comments#'
	WHERE
		ID = #URL.ID#
	</CFQUERY>
</cflock>

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

<cfif form.9_Answer eq 1>
	<cfmail
		to="Cheryl.Adams@ul.com"
		replyto="Cheryl.Adams@ul.com, #Form.ReviewerName#"
		from="DAP_Review_Team@ul.com"
		bcc="Christopher.J.Nicastro@ul.com"
		subject="DAP/CTF/CBTL Audit Project Review – Project #Form.ProjectNumber# - DAP Manager Review Comments Required"
		type="HTML">
	Please review the Lead Auditor Project Review and add comments via the <a href="http://usnbkiqas100p/depts/snk5212/IQA/admin/global_login.cfm">IQA Website</a><br><br>

	In order to complete this Project Review, "DAP Manager Review Comments" are required before the Lead Auditor and Manager are notified.<br><br>

	The review results can be viewed by following this link:<br>
	<a href="http://usnbkiqas100p/departments/snk5212/IQA/DAPReviewForm_Details.cfm?ID=#URL.ID#">DAP/CTF/CBTL Audit Project Review - #Form.ProjectNumber#</a><br><br>

	Details:<br>
	Project Number: #Form.ProjectNumber#<br>
	DA File Number: #Form.DAFileNumber#<br>
	Lead Auditor: #Form.AuditorName#<br>
	Reviewer: #Form.PostedBy#
	</cfmail>
<cfelse>
	<cfmail
		to="Cheryl.Adams@ul.com"
		replyto="Cheryl.Adams@ul.com, #Form.ReviewerName#"
		from="DAP_Review_Team@ul.com"
		bcc="Christopher.J.Nicastro@ul.com"
		subject="DAP/CTF/CBTL Audit Project Review – Project #Form.ProjectNumber#"
		type="HTML">
	The Quality Engineering, Performance Management group has a team of Reviewers who conducts periodic reviews of DAP, CTF and CBTL audit projects in order to help enhance the performance of Lead Auditors and to facilitate a consistent, high quality experience for our clients.<br><br>

	A review was recently completed of a project on which you served as Lead Auditor.  The review results can be viewed by following this link:<br>
	<a href="http://usnbkiqas100p/departments/snk5212/IQA/DAPReviewForm_Details.cfm?ID=#URL.ID#">DAP/CTF/CBTL Audit Project Review - #Form.ProjectNumber#</a><br><br>

	Please look at the project review closely.  Some good items/practices are highlighted.  Nice job!  Please note any suggestions identified.<br><br>

	Feel free to contact the Reviewer noted on the project review if you have questions.<br><br>

	Thanks for your service as a Lead Auditor!
	</cfmail>
</cfif>

<cflocation url="#IQADir#DAPReviewForm_Details.cfm?ID=#URL.ID#" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->