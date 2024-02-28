<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subtitle = "<a href='Activity_Coverage_Menu.cfm'>Audit Activity, Coverage and Schedule Attainment</a><br> -
	Viewing <a href='metrics_new.cfm?AuditedBy=#URL.AuditedBy#'>#URL.AuditedBy#</a> Schedule Attainment Metrics for <a href='metrics_new.cfm?AuditedBy=#URL.AuditedBy#&Year=#URL.Year#'>#URL.Year#</a><br>
	&nbsp; &nbsp; - Process and Lab audits conducted, by Site (including Calibration Lab audits)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<table border=1 width=750 style="border-collapse: collapse;">
<tr>
	<th>Office Name</th>
	<th>Audits Scheduled</th>
	<th>Audits Completed</th>
	<th>Audits Remaining</th>
	<th>Audits Cancelled</th>
	<th>Audits Rescheduled in the same Year</th>
	<th>Audits Reschedule for the following Year</th>
</tr>

	<CFQUERY BLOCKFACTOR="100" name="Total" Datasource="Corporate">
	SELECT COUNT(*) as Count, OfficeName
	FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND AuditedBy = '#URL.AuditedBy#'
	AND AuditType2 = 'Local Function'
	AND AuditArea <> 'Certification Body (CB) Audit'
	AND (Status IS NULL OR Status = 'Deleted')
	GROUP BY OfficeName
	ORDER BY OfficeName
	</cfquery>

	<cfoutput>Offices: #Total.RecordCount#</cfoutput><br><br>
	
	<cfoutput query="Total">
	<tr>
		<!--- Audit Type2 and Audits Scheduled --->
		<td align=left>
			#OfficeName#
		</td>
		<td align=center>
			<cfif isDefined("Count") AND len(Count)>
				#Count#
				<cfset TotalAudits = #Count#>
			<cfelse>
				0
				<cfset TotalAudits = 0>
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="Completed" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND AuditedBy = '#URL.AuditedBy#'
	AND AuditType2 = 'Local Function'
	AND AuditArea <> 'Certification Body (CB) Audit'
	AND OfficeName = '#OfficeName#'
	AND Status IS NULL
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Completed --->
		<td align=center>
			<cfif isDefined("Completed.Count") AND len(Completed.Count)>
				#Completed.Count#
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="Remaining" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND AuditedBy = '#URL.AuditedBy#'
	AND AuditType2 = 'Local Function'
	AND AuditArea <> 'Certification Body (CB) Audit'
	AND OfficeName = '#OfficeName#'
	AND (Status IS NULL)
	AND Report IS NULL
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
	WHERE Year_ = #URL.Year#
	AND AuditType2 = 'Local Function'
	AND AuditArea <> 'Certification Body (CB) Audit'
	AND OfficeName = '#OfficeName#'
	AND Status = 'Deleted'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Cancelled --->
		<td align=center>
			<cfif isDefined("Cancelled.Count") AND len(Cancelled.Count)>
				<cfset avgCancelled = (Cancelled.Count / TotalAudits) * 100>
				#Cancelled.Count# (#numberformat(avgCancelled, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="RescheduledInYear" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND AuditedBy = '#URL.AuditedBy#'
	AND AuditType2 = 'Local Function'
	AND AuditArea <> 'Certification Body (CB) Audit'
	AND OfficeName = '#OfficeName#'
	AND (Status IS NULL)
	AND RescheduleStatus = 'Rescheduled'
	AND RescheduleNextyear = 'No'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Rescheduled within the year --->
		<td align=center>
			<cfif isDefined("RescheduledInYear.Count") AND len(RescheduledInYear.Count)>
				<cfset avgRescheduledInYear = (RescheduledInYear.Count / TotalAudits) * 100>
				#RescheduledInYear.Count# (#numberformat(avgRescheduledInYear, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="RescheduledNextYear" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND AuditedBy = '#URL.AuditedBy#'
	AND AuditType2 = 'Local Function'
	AND AuditArea <> 'Certification Body (CB) Audit'
	AND OfficeName = '#OfficeName#'
	AND (Status IS NULL)
	AND RescheduleStatus = 'Rescheduled'
	AND RescheduleNextyear = 'Yes'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Rescheduled next year --->
		<td align=center>
			<cfif isDefined("RescheduledNextYear.Count") AND len(RescheduledNextYear.Count)>
				<cfset avgRescheduledNextYear = (RescheduledNextYear.Count / TotalAudits) * 100>
				#RescheduledNextYear.Count# (#numberformat(avgRescheduledNextYear, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>
	</tr>	
	</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->