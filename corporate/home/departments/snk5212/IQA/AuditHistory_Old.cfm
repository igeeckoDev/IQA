<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit History">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset nextYear = #curyear# + 1>

<cfquery name="History" datasource="Corporate" blockfactor="100">
SELECT
	Year_, ID, Month, lastYear, Area, Officename, AuditType2, xGUID, AuditArea
FROM
	AuditSchedule
WHERE
	xGUID = #url.xGUID#
</cfquery>

<cfset auditID = url.xGUID>

<cfoutput>
	<cfif history.Year_ LTE curYear>
		<cfloop from="#history.year_#" to="#curYear#" index="i">
			<cfquery name="nextYearAudit" datasource="Corporate" blockfactor="100">
			SELECT
				xGUID, Year_, ID, Status, Area, OfficeName, RescheduleNextYear, AuditArea
			FROM
				AuditSchedule
			WHERE
				lastYear = #auditID#
			</cfquery>

		<cfset auditID = nextYearAudit.xGUID>
		<cfset i = i+1>
		</cfloop>
	<cfelseif history.year_ GT curYear>
		<cfset auditID = history.xGUID>
		<cfset NextYearAudit.Year_ = history.Year_>
		<cfset NextYearAudit.ID = history.ID>
		<cfset NextYearAudit.Area = history.Area>
		<cfset NextYearAudit.OfficeName = history.OfficeName>
		<cfset NextYearAudit.AuditArea = history.AuditArea>
	</cfif>
</cfoutput><br>

<cfoutput>
	<b>Audit History</b><br><br>

	<!---xGUID = #auditID#--->
	<a href="auditDetails.cfm?year=#nextYearAudit.Year_#&ID=#nextYearAudit.ID#">#nextYearAudit.Year_#-#nextYearAudit.ID#</a><br>
	#NextYearAudit.Area#<br>
	<cfif NextYearAudit.Area eq "Laboratories" AND NextYearAudit.Year_ LTE 2015>
		#NextYearAudit.AuditArea#<br>
	</cfif>
	#NextYearAudit.OfficeName#<br><br>
</cfoutput>

<cfloop from="#curyear#" to="2008" index="j" step="-1">
	<cfquery name="lastYearAudit" datasource="Corporate" blockfactor="100">
	SELECT
		lastYear as xGUIDlastYear, Year_
	FROM
		AuditSchedule
	WHERE
		xGUID = #auditID#
	</cfquery>

	<cfif len(lastYearAudit.xGUIDlastYear)>
		<cfquery name="getAudit" datasource="Corporate" blockfactor="100">
		SELECT
			Year_, ID, Status, Area, OfficeName, RescheduleNextYear, xGUID, AuditArea
		FROM
			AuditSchedule
		WHERE
			xGUID = #lastYearAudit.xGUIDlastYear#
		</cfquery>

		<cfif getAudit.RecordCount GT 0>
			<cfoutput query="getAudit">
				<!--- xGUID = #xGUID# --->
				<a href="auditDetails.cfm?year=#Year_#&ID=#ID#">#Year_#-#ID#</a><br>
				#Area#<br>
				#OfficeName#
				<cfif Area eq "Laboratories" AND Year_ LTE 2015>
					<br>#AuditArea#
				</cfif>
				<cfif RescheduleNextYear eq "Yes">
					<cfset RescheduleYear = #year_# + 1><Br>(Rescheduled for #RescheduleYear#)
				</cfif>
				<cfif Status is "deleted" OR Status is "Deleted">
					<br>Cancelled
				</cfif>
				<br><br>
			</cfoutput>

			<cfset auditID = getAudit.xGUID>
		<cfelse>
			No Audit Found for <cfoutput>#j#</cfoutput><br><br>

			<cfset auditID = auditID>
		</cfif>
	<cfelse>
		No Audit Found for <cfoutput>#j#</cfoutput><br><br>

		<cfset auditID = auditID>
	</cfif>

	<cfif lastYearAudit.Year_ eq getAudit.Year_>
		<cfset j = j>
	<cfelse>
		<cfset j = j-1>
	</cfif>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->