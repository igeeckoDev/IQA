<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subtitle = "<a href='Activity_Coverage_Menu.cfm'>Audit Activity, Coverage and Schedule Attainment</a> - #URL.AuditedBy# Schedule Attainment Metrics">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<table border=1 width=750 style="border-collapse: collapse;">
<tr>
	<th>Year</th>
	<th>Audits Scheduled</th>
	<th>Audits Completed</th>
	<th>Audits Remaining</th>
	<th>Audits Cancelled</th>
	<th>Audits Rescheduled in the same Year</th>
	<th>Audits Reschedule for the following Year</th>
</tr>

<cfloop index=i from=2008 to=#curyear#>
	<CFQUERY BLOCKFACTOR="100" name="Total" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = '#URL.AuditedBy#'
	AND (Status IS NULL OR Status = 'Deleted')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfoutput>
	<tr>
		<!--- Year and Audits Scheduled --->
		<td align=center><a href="Metrics_new_Detail.cfm?Year=#Total.Year_#&AuditedBy=#URL.AuditedBy#">#Total.Year_#</a></td>
		<td align=center>#Total.Count#</td>
		<cfset TotalAudits = #Total.Count#>

	<CFQUERY BLOCKFACTOR="100" name="Completed" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = '#URL.AuditedBy#'
	AND Status IS NULL
	AND Report IS NOT NULL
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Completed --->
		<td align=center>#Completed.Count#</td>

	<CFQUERY BLOCKFACTOR="100" name="Remaining" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = '#URL.AuditedBy#'
	AND (Status IS NULL)
	AND Report IS NULL
	<cfif URL.AuditedBy NEQ "IQA">
	AND AuditType = 'Quality System'
	</cfif>
	AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Remaining --->
		<td align=center>
			<cfif isDefined("Remaining.Count") AND len(Remaining.Count)>
				#Remaining.Count#
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="Cancelled" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = '#URL.AuditedBy#'
	AND Status = 'Deleted'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Cancelled --->
		<td align=center>
			<cfif isDefined("Cancelled.Count") AND len(Cancelled.Count)>
				<cfset avgCancelled = (Cancelled.Count / Total.Count) * 100>
				#Cancelled.Count# (#numberformat(avgCancelled, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="RescheduledInYear" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = '#URL.AuditedBy#'
	AND (Status IS NULL)
	AND RescheduleStatus = 'Rescheduled'
	AND RescheduleNextyear = 'No'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Rescheduled within the year --->
		<td align=center>
			<cfif isDefined("RescheduledInYear.Count") AND len(RescheduledInYear.Count)>
				<cfset avgRescheduledInYear = (RescheduledInYear.Count / Total.Count) * 100>
				#RescheduledInYear.Count# (#numberformat(avgRescheduledInYear, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="RescheduledNextYear" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = '#URL.AuditedBy#'
	AND (Status IS NULL)
	AND RescheduleStatus = 'Rescheduled'
	AND RescheduleNextyear = 'Yes'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Rescheduled next year --->
		<td align=center>
			<cfif isDefined("RescheduledNextYear.Count") AND len(RescheduledNextYear.Count)>
				<cfset avgRescheduledNextYear = (RescheduledNextYear.Count / Total.Count) * 100>
				#RescheduledNextYear.Count# (#numberformat(avgRescheduledNextYear, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>
	</tr>
	</cfoutput>
</cfloop>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->