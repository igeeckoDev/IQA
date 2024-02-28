<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Survey - Metrics">
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
	<cfif URL.Year neq "All">
		AND AuditYear = #URL.Year#
	</cfif>
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveySent" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
<cfif URL.Year neq "All">
	WHERE AuditYear = #URL.Year#
</cfif>
</cfquery>

<cfif numSurveySent.Count EQ 0>

<cfoutput>
	No Audits have been completed for #URL.Year#<br><br>
</cfoutput>

	<cfoutput>
	Select Year:
	<cfif url.year eq "All">
		<b>All</b>
	<cfelse>
		<a href="AuditSurvey_Metrics.cfm?Year=All">All</a>
	</cfif> :
		<cfloop index=i from=2014 to=#curyear#>
			<cfif url.year eq i>
				<b>#i#</b>
			<cfelse>
				<a href="AuditSurvey_Metrics.cfm?Year=#i#">#i#</a>
			</cfif>
			&nbsp;<cfif i neq curyear>: </cfif>
		</cfloop>
	</cfoutput>

<cfelse>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
<cfif URL.Year neq "All">
	AND AuditSurvey_Users.AuditYear = #URL.Year#
</cfif>
</cfquery>

<cfoutput>
Select Year:
<cfif url.year eq "All">
	<b>All</b>
<cfelse>
	<a href="AuditSurvey_Metrics.cfm?Year=All">All</a>
</cfif> :
	<cfloop index=i from=2014 to=#curyear#>
		<cfif url.year eq i>
			<b>#i#</b>
		<cfelse>
			<a href="AuditSurvey_Metrics.cfm?Year=#i#">#i#</a>
		</cfif>
		&nbsp;<cfif i neq curyear>: </cfif>
	</cfloop>
	<br><br>

<b>Survey Data: <cfif URL.Year eq "All">All Years (2014-#curYear#)<cfelse>#URL.Year#</cfif></b><br>
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
	SELECT SUM(AuditSurvey_Answers.Answer) as sumAnswer, Count(AuditSurvey_Answers.Answer) as Total, Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stddevAnswer
	FROM AuditSurvey_Answers, AuditSurvey_Users
	WHERE AuditSurvey_Answers.qID = #i#
	AND AuditSurvey_Answers.Answer <> 0
	AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
	<cfif URL.Year neq "All">
		AND AuditSurvey_Users.AuditYear = #URL.Year#
	</cfif>
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="Chart" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT COUNT(AuditSurvey_Answers.Answer) as RatingQuantity, AuditSurvey_Answers.qID, AuditSurvey_Answers.Answer as Rating
	FROM AuditSurvey_Answers, AuditSurvey_Users
	WHERE AuditSurvey_Answers.qID = #i#
	AND AuditSurvey_Answers.Answer <> 0
	AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
	<cfif URL.Year neq "All">
		AND AuditSurvey_Users.AuditYear = #URL.Year#
	</cfif>
	GROUP BY AuditSurvey_Answers.qID, AuditSurvey_Answers.Answer
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
		SELECT COUNT(AuditSurvey_Answers.Answer) as RatingQuantity, AuditSurvey_Answers.qID, AuditSurvey_Answers.Answer as Rating
		FROM AuditSurvey_Answers, AuditSurvey_Users
		WHERE AuditSurvey_Answers.qID = #i#
		AND AuditSurvey_Answers.Answer <> 0
		AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
		<cfif URL.Year neq "All">
			AND AuditSurvey_Users.AuditYear = #URL.Year#
		</cfif>
		GROUP BY AuditSurvey_Answers.qID, AuditSurvey_Answers.Answer
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
<br><br>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_All" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_All" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_1" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear > 2014
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_1" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear > 2014
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear > 2015
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear > 2015
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_3" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear > 2016
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_3" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear > 2016
</cfquery>

<cfoutput>
<b>Average Scores</b><br>
2014-current: #numberformat(OverallMetrics_All.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_All.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_all.count#)<Br>
2015-current: #numberformat(OverallMetrics_1.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_1.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_1.count#)<Br>
2016-current: #numberformat(OverallMetrics_2.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2.count#)<Br>
2017-current: #numberformat(OverallMetrics_3.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_3.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_3.count#)<Br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2014" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear = 2014
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2014" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear = 2014
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2015" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear = 2015
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2015" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear = 2015
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2016" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear = 2016
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2016" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear = 2016
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2017" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer, STDDEV(AuditSurvey_Answers.Answer) as stdDevAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID 
AND AuditSurvey_Users.AuditYear = 2017
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2017" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM AuditSurvey_Users
WHERE Responded = 'Yes'
AND AuditYear = 2017
</cfquery>

<cfoutput>
<b>Average Scores</b><br>
2014: #numberformat(OverallMetrics_2014.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2014.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2014.count#)<Br>
2015: #numberformat(OverallMetrics_2015.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2015.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2015.count#)<Br>
2016: #numberformat(OverallMetrics_2016.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2016.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2016.count#)<Br>
2017: #numberformat(OverallMetrics_2017.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2017.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2017.count#)<Br><br>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->