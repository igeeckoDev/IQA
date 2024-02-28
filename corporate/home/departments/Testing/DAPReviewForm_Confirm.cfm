<CFQUERY Name="RequiresReview" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ANSWER
FROM DAPReviewForm_Answers
WHERE USERID = #URL.ID#
AND qID = 9
</cfquery>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
	DAPReviewForm_Users
SET
	Confirm = 'Yes',
	RequiresReview = <cfif RequiresReview.Answer eq 1>'Yes'<cfelse>'No'</cfif>,
	ResultsSent = <cfif RequiresReview.Answer eq 0>'Yes'<cfelse>'No'</cfif>,
	ResultsSentDate = <cfif RequiresReview.Answer eq 0>#postDate#<cfelse>null</cfif>
WHERE
	ID = #URL.ID#
</CFQUERY>

<CFQUERY Name="Details" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPReviewForm_Users
WHERE ID = #URL.ID#
</cfquery>


<cfif RequiresReview.Answer eq 1>
	<cfmail
		to="Cheryl.Adams@ul.com"
		replyto="Cheryl.Adams@ul.com, #Details.ReviewerName#"
		from="DAP_Review_Team@ul.com"
		bcc="Christopher.J.Nicastro@ul.com"
		subject="DAP/CTF/CBTL Audit Project Review – Project #Details.ProjectNumber# - DAP Manager Review Comments Required"
		type="HTML">
	Please review the Lead Auditor Project Review and add comments via the <a href="http://usnbkiqas100p/departments/snk5212/IQA/admin/global_login.cfm">IQA Website</a><br><br>

	In order to complete this Project Review, "DAP Manager Review Comments" are required before the Lead Auditor and Manager are notified.<br><br>

	The review results can be viewed by following this link:<br>
	<a href="http://usnbkiqas100p/departments/snk5212/IQA/DAPReviewForm_Details.cfm?ID=#URL.ID#">DAP/CTF/CBTL Audit Project Review - #Details.ProjectNumber#</a><br><br>

	Details:<br>
	Project Number: #Details.ProjectNumber#<br>
	DA File Number: #Details.DAFileNumber#<br>
	Lead Auditor: #Details.AuditorName#<br>
	Reviewer: #Details.PostedBy#
	</cfmail>
<cfelse>
	<cfmail
		to="Cheryl.Adams@ul.com"
		replyto="Cheryl.Adams@ul.com, #Details.ReviewerName#"
		from="DAP_Review_Team@ul.com"
		bcc="Christopher.J.Nicastro@ul.com"
		subject="DAP/CTF/CBTL Audit Project Review – Project #Details.ProjectNumber#"
		type="HTML">
	The Quality Engineering, Performance Management group has a team of Reviewers who conducts periodic reviews of DAP, CTF and CBTL audit projects in order to help enhance the performance of Lead Auditors and to facilitate a consistent, high quality experience for our clients.<br><br>

	A review was recently completed of a project on which you served as Lead Auditor.  The review results can be viewed by following this link:<br>
	<a href="http://usnbkiqas100p/departments/snk5212/IQA/DAPReviewForm_Details.cfm?ID=#URL.ID#">DAP/CTF/CBTL Audit Project Review - #Details.ProjectNumber#</a><br><br>

	Please look at the project review closely.  Some good items/practices are highlighted.  Nice job!  Please note any suggestions identified.<br><br>

	Feel free to contact the Reviewer noted on the project review if you have questions.<br><br>

	Thanks for your service as a Lead Auditor!
	</cfmail>
</cfif>

<cflocation url="#IQADir#DAPReviewForm_Details.cfm?ID=#URL.ID#" addtoken="no">