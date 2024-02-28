<!--- get the audit details for the xGUID selected --->
<cfquery name="History" datasource="Corporate" blockfactor="100">
SELECT
	Year_, ID
FROM
	AuditSchedule
WHERE
	xGUID = #url.xGUID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit History - <a href='auditDetails.cfm?Year=#history.Year_#&ID=#history.ID#'>#history.Year_#-#history.ID#-IQA</a>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset nextYear = #curyear# + 1>

<!--- get the audit details for the xGUID selected --->
<cfquery name="History" datasource="Corporate" blockfactor="100">
SELECT
	Year_, ID, Status, Area, OfficeName, AuditArea, RescheduleNextYear, xGUID, lastYear
FROM
	AuditSchedule
WHERE
	xGUID = #url.xGUID#
</cfquery>

<!--- set auditID to equal the URL value for xGUID --->
<cfset auditID = url.xGUID>

<!--- last year's xGUID incase the audit trail ends before the current year --->
<cfset lastYearxGUID = "">

<!--- find the most recent audit --->
<cfoutput>
	<cfif history.Year_ LTE curYear>
		<cfloop from="#history.year_#" to="#curYear#" index="i">
			<cfquery name="nextYearAudit" datasource="Corporate" blockfactor="100">
			SELECT
				Year_, ID, Status, Area, OfficeName, AuditArea, RescheduleNextYear, xGUID, lastYear
			FROM
				AuditSchedule
			WHERE
				lastYear = #auditID#
			</cfquery>

			<cfif nextYearAudit.recordCount GT 0>
				<cfset auditID = nextYearAudit.xGUID>
				<cfset i = i+1>
			<cfelse>
				<cfset auditID = auditID>
				<cfset i = curYear>
			</cfif>

			<cfset lastYearxGUID = auditID>
		</cfloop>
	<cfelseif history.year_ GT curYear>
		<cfset auditID = history.xGUID>
		<!---
		<cfset NextYearAudit.Year_ = history.Year_>
		<cfset NextYearAudit.ID = history.ID>
		<cfset NextYearAudit.Area = history.Area>
		<cfset NextYearAudit.OfficeName = history.OfficeName>
		<cfset NextYearAudit.AuditArea = history.AuditArea>
		<cfset NextYearAudit.Status = history.Status>
		<cfset NextYearAudit.RescheduleNextYear = history.RescheduleNextYear>
		--->
	</cfif>
</cfoutput><br>

<b>Audit History</b><br><br>

<!--- cut for 2011 for public view --->

<!--- set findID.lastyear to AuditID --->
<cfset FindID.lastYear = auditID>

<cfset previousYear = "">

<!--- loop through the audit schedule to find reference IDs (last year field) and identify the audits using the xGUID field --->
<!--- the loop continues until there is no referring ID in a row --->

<cfloop condition="len(findID.lastYear)">
	<cfquery name="findID" datasource="Corporate" blockfactor="100">
	SELECT
		Year_, ID, Status, Area, OfficeName, AuditArea, RescheduleNextYear, xGUID, lastYear, startDate, EndDate
	FROM
		AuditSchedule
	WHERE
		<cfif previousYear eq 2008 AND History.OfficeName eq "Boulder LES">
			xGUID = 277
		<cfelseif previousYear eq 2008 AND History.OfficeName eq "San Jose, CA">
			xGUID = 394
		<cfelse>
			xGUID = #FindID.lastYear#
		</cfif>
	</cfquery>

	<cfoutput query="findID">
			<!--- Year #Year_# - rowID #xGUID# - ReferalID <cfif len(lastYear)>#lastYear#<cfelse>None</cfif><Br>--->
			<a href="auditdetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a><br>
			#OfficeName# - #Area#
			<cfif Area eq "Laboratories" AND Year_ LTE 2015>
				<br>#AuditArea#
			</cfif>
			<cfif RescheduleNextYear eq "Yes">
				<cfset RescheduleYear = #year_# + 1><Br>(Rescheduled for #RescheduleYear#)
			</cfif>
			<cfif Status is "deleted" OR Status is "Deleted">
				<br>Cancelled
			</cfif>

			<cfif len(startDate) AND len(endDate)>
				<cfset variables.totalWorkingDays = 0>

				<cfloop from="#startdate#" to="#enddate#" index="i">
				<!--- excludes saturday and sunday --->
				    <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
				       <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
				    </cfif>
				</cfloop>

			<br>
			Days on Site - #variables.totalWorkingDays#
			</cfif>
			<br><br>
	</cfoutput>

	<cfset previousYear = FindID.Year_>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->