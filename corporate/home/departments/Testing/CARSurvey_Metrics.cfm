<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Survey - Metrics">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif URL.Year neq "All">
<b>Year</b>: Viewing responses from <cfoutput><b>#URL.Year#</b></cfoutput><br>
<cfelse>
<b>Year</b>: Showing all responses since 9/12/2014<br>
</cfif>
<u>View Year</u>: 

<cfoutput>
	<cfloop index=i from=2014 to=#curyear#>
		<cfif url.year eq i>
			<b>#i#</b>
		<cfelse>
			<a href="CARSurvey_Metrics.cfm?Year=#i#">#i#</a>
		</cfif>

		&nbsp;<cfif i neq curyear>: </cfif>
	</cfloop>
	<br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="numSurveys" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE ID <> 1
AND
<cfif URL.Year neq "All">
	(Posted >= TO_DATE('#url.year#-01-01', 'yyyy-mm-dd')
	AND Posted <= TO_DATE('#url.year#-12-31', 'yyyy-mm-dd'))
<cfelse>
	1=1
</cfif>
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numQuestions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Questions
WHERE Status IS NULL
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Users.ID = CARSurvey_Answers.USERID
AND
<cfif URL.Year neq "All">
	(CARSurvey_Users.Posted >= TO_DATE('#url.year#-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('#url.year#-12-31', 'yyyy-mm-dd'))
<cfelse>
	1=1
</cfif>
</cfquery>

Total Surveys Submitted: <cfoutput query="numSurveys">#count#</cfoutput><br>
<cfoutput>
<u>Average Score</u>: #numberformat(OverallMetrics.avgAnswer, "9.99")# out of 5<br>
<u>Standard Deviation</u>: #numberformat(OverallMetrics.stdDevAnswer, "9.99")#<br><br>
</cfoutput>

Note: N/A responses are not counted.<br><br>

<table border=1 width=800>
<cfloop index="i" from="1" to="#numQuestions.count#">
	<CFQUERY BLOCKFACTOR="100" name="Metrics" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT SUM(CARSurvey_Answers.Answer) as sumAnswer, Count(*) as Total,
	Avg(CARSurvey_Answers.Answer) as avgAnswer,
	STDDEV(CARSurvey_Answers.Answer) as stddevAnswer
	FROM CARSurvey_Answers, CARSurvey_Users
	WHERE qID = #i#
	AND CARSurvey_Answers.Answer <> 0
	AND CARSurvey_Users.ID = CARSurvey_Answers.USERID
	AND
	<cfif URL.Year neq "All">
		(CARSurvey_Users.Posted >= TO_DATE('#url.year#-01-01', 'yyyy-mm-dd')
		AND CARSurvey_Users.Posted <= TO_DATE('#url.year#-12-31', 'yyyy-mm-dd'))
	<cfelse>
		1=1
	</cfif>
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="Chart" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT COUNT(Answer) as RatingQuantity, qID, Answer as Rating
	FROM CARSurvey_Answers, CARSurvey_Users
	WHERE qID = #i#
	AND Answer <> 0
	AND CARSurvey_Users.ID = CARSurvey_Answers.USERID
	AND
	<cfif URL.Year neq "All">
		(CARSurvey_Users.Posted >= TO_DATE('#url.year#-01-01', 'yyyy-mm-dd')
		AND CARSurvey_Users.Posted <= TO_DATE('#url.year#-12-31', 'yyyy-mm-dd'))
	<cfelse>
		1=1
	</cfif>
	GROUP BY CARSurvey_Answers.qID, Answer
	ORDER BY RatingQuantity DESC
	</cfquery>

	<tr>
		<td colspan=2 align=left>
			<cfoutput>
				<b>Question #i#</b><br>
			</cfoutput>

			<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Question
			FROM CARSurvey_Questions
			WHERE ID = #i#
			</cfquery>

			<cfoutput query="Questions">
			#question#
			</cfoutput><br><Br>
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
			Total Responses with N/A: <cfset NA = numSurveys.count-total>#NA#<br><br>
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
		SELECT COUNT(CARSurvey_Answers.Answer) as RatingQuantity, qID, CARSurvey_Answers.Answer as Rating
		FROM CARSurvey_Answers, CARSurvey_Users
		WHERE qID = #i#
		AND Answer <> 0
		AND CARSurvey_Users.ID = CARSurvey_Answers.USERID
		AND
		<cfif URL.Year neq "All">
			(CARSurvey_Users.Posted >= TO_DATE('#url.year#-01-01', 'yyyy-mm-dd')
			AND CARSurvey_Users.Posted <= TO_DATE('#url.year#-12-31', 'yyyy-mm-dd'))
		<cfelse>
			1=1
		</cfif>
		GROUP BY CARSurvey_Answers.qID, Answer
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

<!--- 2014-current --->
<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_All" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_All" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
</cfquery>

<!--- 2015-current --->
<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_1" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND CARSurvey_Users.Posted > TO_DATE('2014-12-31', 'yyyy-mm-dd')
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_1" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND Posted > TO_DATE('2014-12-31', 'yyyy-mm-dd')
</cfquery>

<!--- 2016-current --->
<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND CARSurvey_Users.Posted > TO_DATE('2015-12-31', 'yyyy-mm-dd')
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND Posted > TO_DATE('2015-12-31', 'yyyy-mm-dd')
</cfquery>

<!--- 2017-current --->
<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_3" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND CARSurvey_Users.Posted > TO_DATE('2016-12-31', 'yyyy-mm-dd')
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_3" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND Posted > TO_DATE('2016-12-31', 'yyyy-mm-dd')
</cfquery>

<cfoutput>
<b>Average Scores</b><br>
2014-current: #numberformat(OverallMetrics_All.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_All.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_all.count#)<Br>
2015-current: #numberformat(OverallMetrics_1.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_1.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_1.count#)<Br>
2016-current: #numberformat(OverallMetrics_2.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2.count#)<Br>
2017-current: #numberformat(OverallMetrics_3.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_3.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_3.count#)<Br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2014" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND
	(CARSurvey_Users.Posted >= TO_DATE('2014-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2014-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2014" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND
	(CARSurvey_Users.Posted >= TO_DATE('2014-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2014-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2015" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND
	(CARSurvey_Users.Posted >= TO_DATE('2015-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2015-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2015" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND
	(CARSurvey_Users.Posted >= TO_DATE('2015-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2015-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2016" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND
	(CARSurvey_Users.Posted >= TO_DATE('2016-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2016-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2016" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND
	(CARSurvey_Users.Posted >= TO_DATE('2016-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2016-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="OverallMetrics_2017" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer, STDDEV(CARSurvey_Answers.Answer) as stdDevAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Answers.UserID = CARSurvey_Users.ID 
AND
	(CARSurvey_Users.Posted >= TO_DATE('2017-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2017-12-31', 'yyyy-mm-dd'))
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="numSurveyResponses_2017" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as count
FROM CARSurvey_Users
WHERE Responded = 'Yes'
AND
	(CARSurvey_Users.Posted >= TO_DATE('2017-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('2017-12-31', 'yyyy-mm-dd'))
</cfquery>

<cfoutput>
<b>Average Scores</b><br>
2014: #numberformat(OverallMetrics_2014.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2014.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2014.count#)<Br>
2015: #numberformat(OverallMetrics_2015.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2015.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2015.count#)<Br>
2016: #numberformat(OverallMetrics_2016.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2016.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2016.count#)<Br>
2017: #numberformat(OverallMetrics_2017.avgAnswer, "9.99")# (Std Dev: #numberformat(OverallMetrics_2017.StdDevAnswer, "9.99")#) (Surveys: #numSurveyResponses_2017.count#)<Br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->

<!---
<hr><br><br>

<CFQUERY BLOCKFACTOR="100" name="Metrics" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT COUNT(Answer) as RatingQuantity, qID, Answer as Rating
FROM CARSurvey_Answers
GROUP BY qID, Answer
ORDER BY qID
</cfquery>

<table border=1>
<tr>
<th>Question Number</th>
<th>Score</th>
<th>Quantity</th>
</tr>
<cfoutput query="Metrics">
<tr>
<td>#qID#</td>
<td>#Rating#</td>
<td>#RatingQuantity#</td>
</tr>
</cfoutput>
</table>
--->