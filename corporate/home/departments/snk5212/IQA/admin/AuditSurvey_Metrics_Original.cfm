<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditSurvey_Distribution.cfm?Year=#CurYear#'>Audit Survey</a> - Metrics">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!---
<cflock scope="SESSION" timeout="10">
	<cfif SESSION.Auth.AccessLevel eq "IQAAuditor">
		<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
		SELECT ID, Lead, Auditor
		FROM AuditorList
		WHERE Auditor = '#SESSION.Auth.Name#'
		</cfquery>
	</cfif>

	<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT
	UL06046.AuditSurvey_Users.ID, UL06046.AuditSurvey_Users.AuditYear, UL06046.AuditSurvey_Users.AuditId, UL06046.AuditSurvey_Users.SentTo,
	UL06046.AuditSurvey_Users.Responded, UL06046.AuditSurvey_Users.PostedBy, UL06046.AuditSurvey_Users.Posted, UL06046.AuditSurvey_Users.SentDate,
	UL06046.AuditSurvey_Users.GivenName, UL06046.AuditSurvey_Users.GivenEmail, Corporate.AuditSchedule.Month, Corporate.AuditSchedule.OfficeName,
	Corporate.AuditSchedule.Area, Corporate.AuditSchedule.AuditType2, Corporate.AuditSchedule.AuditedBy, Corporate.AuditSchedule.LeadAuditor

	FROM
	UL06046.AuditSurvey_Users, Corporate.AuditSchedule

	WHERE
	UL06046.AuditSurvey_Users.AuditYear = '#URL.Year#'
	<cfif SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes">
		AND Corporate.AuditSchedule.LeadAuditor = '#AuditorProfile.Auditor#'
	</cfif>
	AND UL06046.AuditSurvey_Users.AuditYear = Corporate.AuditSchedule.Year_
	AND UL06046.AuditSurvey_Users.AuditID = Corporate.AuditSchedule.ID
	AND Corporate.AuditSchedule.AuditedBy = 'IQA'
	AND UL06046.AuditSurvey_Users.Responded = 'Yes'
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="numSurveySent" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT
	UL06046.AuditSurvey_Users.ID, UL06046.AuditSurvey_Users.AuditYear, UL06046.AuditSurvey_Users.AuditId, UL06046.AuditSurvey_Users.SentTo,
	UL06046.AuditSurvey_Users.Responded, UL06046.AuditSurvey_Users.PostedBy, UL06046.AuditSurvey_Users.Posted, UL06046.AuditSurvey_Users.SentDate,
	UL06046.AuditSurvey_Users.GivenName, UL06046.AuditSurvey_Users.GivenEmail, Corporate.AuditSchedule.Month, Corporate.AuditSchedule.OfficeName,
	Corporate.AuditSchedule.Area, Corporate.AuditSchedule.AuditType2, Corporate.AuditSchedule.AuditedBy, Corporate.AuditSchedule.LeadAuditor

	FROM
	UL06046.AuditSurvey_Users, Corporate.AuditSchedule

	WHERE
	UL06046.AuditSurvey_Users.AuditYear = '#URL.Year#'
	<cfif SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes">
		AND Corporate.AuditSchedule.LeadAuditor = '#AuditorProfile.Auditor#'
	</cfif>
	AND UL06046.AuditSurvey_Users.AuditYear = Corporate.AuditSchedule.Year_
	AND UL06046.AuditSurvey_Users.AuditID = Corporate.AuditSchedule.ID
	AND Corporate.AuditSchedule.AuditedBy = 'IQA'
	</CFQUERY>
</cflock>
--->

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveySent" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(Answer) as avgAnswer, STDDEV(Answer) as stdDevAnswer
FROM AuditSurvey_Answers
WHERE Answer <> 0
</cfquery>

<cfoutput>
<u>Total Surveys Submitted</u>: #numSurveyResponses.Count#<br>
<u>Total Surveys Sent</u>: #numSurveySent.Count#<br>
<u>Average Score</u>: #numberformat(OverallMetrics.avgAnswer, "9.99")# out of 5<br>
<u>Standard Deviation</u>: #numberformat(OverallMetrics.stdDevAnswer, "9.99")#<br>
<cfset avg = #numSurveyResponses.Count# / #numSurveySent.Count#>
<u>Response Rate</u>: #numSurveyResponses.Count# / #numSurveySent.Count# - #NumberFormat(avg * 100,"999.99")#%<br><br>
</cfoutput>

Note: N/A responses are not counted in the table below.<br><br>

<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Questions
WHERE Status IS NULL
</cfquery>

<table border=1 width=800>
<cfloop index="i" from="1" to="#numQuestions.count#">
	<CFQUERY BLOCKFACTOR="100" name="Metrics" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT SUM(Answer) as sumAnswer, Count(*) as Total, Avg(Answer) as avgAnswer, STDDEV(Answer) as stddevAnswer
	FROM AuditSurvey_Answers
	WHERE qID = #i#
	AND Answer <> 0
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="Chart" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT COUNT(Answer) as RatingQuantity, qID, Answer as Rating
	FROM AuditSurvey_Answers
	WHERE qID = #i#
	AND Answer <> 0
	GROUP BY qID, Answer
	ORDER BY RatingQuantity DESC
	</cfquery>

	<tr>
		<td colspan=2 align=left>
			<cfoutput>
				<b>Question #i#</b><br>
			</cfoutput>

			<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Question
			FROM AuditSurvey_Questions
			WHERE ID = #i#
			</cfquery>

			<cfoutput query="Questions">
			#question#<br><br>

			<cfif i eq 6><b>Note: Question 6 has been removed for 2015</b></cfif>
			</cfoutput>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign=top>
			<cfoutput query="Metrics">
			<u>Details</u><br>
			Average Score: #numberformat(avgAnswer, "9.99")#<br>
			Std Dev: #numberformat(stddevAnswer, "9.99")#<br>
			<!---Sum: #sumAnswer#<br>--->
			Total Responses with Ratings: #total#<br>
			Total Responses with N/A: <cfset NA = numSurveyResponses.Count-total>#NA#<br><br>
			</cfoutput>
		</td>
		<td valign=top>
			<u>Distribution</u><Br>
			<Table border=1>
				<tr>
					<th>Rating</th>
					<th>Quantity</th>
				</tr>
					<cfoutput query="Chart">
					<tr>
						<td>#Rating#</td>
						<td>#RatingQuantity#</td>
					</tr>
					</cfoutput>
				</tr>
			</table>
		</td>
		<td valign=top>
		<u>Chart</u><br><Br>
		<!--- Now populate the array with all "0" - this is to catch empty arrays later --->
		<cfloop from="1" to="5" index="j"> <!--- 1 to 5 rating --->
			<cfset arrGraphData[j] = "0">
				<!--- example:
				arrGraphData[1] = "5" = Rating "1" was used 5 times.
				arrGraphData[2] = "12" = Rating "2" was used 12 times.
				--->
		</cfloop>

		<CFQUERY BLOCKFACTOR="100" name="Chart2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT COUNT(Answer) as RatingQuantity, qID, Answer as Rating
		FROM AuditSurvey_Answers
		WHERE qID = #i#
		AND Answer <> 0
		GROUP BY qID, Answer
		ORDER BY Rating
		</cfquery>

		<cfoutput query="Chart2">
			<cfset arrGraphData[Rating] = "#RatingQuantity#">
		</cfoutput>

		<cfoutput>
			<cfset scaleToValue = #arrayMax(arrGraphData)# + 1>
		</cfoutput>

		<cfchart xAxisTitle="Rating" yAxisTitle="Quantity" format="jpg" scaleto="#scaleToValue#">
			<cfchartseries type="bar" datalabelstyle="value" colorlist="c63c39,34aac9,97be46,7755a0,df6800" paintstyle="raise">
				<cfloop index="k" from="1" to="#arrayLen(arrGraphData)#">
					<cfchartdata item="#k#" value="#arrGraphData[k]#">
				</cfloop>
			</cfchartseries>
		</cfchart>
		</td>
	</tr>
</cfloop>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->