<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Metrics">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif URL.Year neq "All">
<b>Year</b>: Viewing responses from <cfoutput><b>#URL.Year#</b></cfoutput><br>
<cfelse>
<b>Year</b>: Showing all responses since 9/12/2014<br>
</cfif>
<u>View Year</u>: <a href="CARSurvey_Metrics.cfm?Year=All">All</a> :: <a href="CARSurvey_Metrics.cfm?Year=2014">2014</a> : <a href="CARSurvey_Metrics.cfm?Year=2015">2015</a> : <a href="CARSurvey_Metrics.cfm?Year=2016">2016</a><br><Br>

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

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->