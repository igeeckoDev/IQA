<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Scope/Report/Pathnotes Completion">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<u>Currently Viewing</u>: <strong>#URL.Year#<cfif url.year eq "All"> (2010-#curyear#)</cfif></strong><br>
	<cfloop index=i from=2010 to=#curyear#>
		<a href="AuditCompletion.cfm?Year=#i#">#i#</a> ::
	</cfloop>
		<a href="AuditCompletion.cfm?Year=All">All (2010-#curyear#)</a>
		<br><br>
</cfoutput>

<b>Notes</b><br>
 :: <u>Scope Letters Table</u> - shows audits in process (where the scope letter has already been sent) as well cancelled audits where the scope letter was sent BEFORE the audit was cancelled. Includes "Global Desk Audits" for all years.<br>
 :: <u>Reports Table</u> - includes audits where the report has been completed/published. Does not include 'Global Desk Audits' for 2012 and prior.<br><br>

<b>Scope Letters</b><br>
<CFQUERY BLOCKFACTOR="100" NAME="LeadAuditors" Datasource="Corporate">
SELECT DISTINCT LeadAuditor
From AuditSchedule
WHERE
(Year_ BETWEEN 2010 AND #curYear#)
AND Approved = 'Yes'
AND AuditedBy = 'IQA'
AND LeadAuditor <> 'Denise Echols'
AND ScopeLetterDate IS NOT NULL
ORDER BY LeadAuditor
</cfquery>

<cfset totalAudits = 0>
<cfset totalScopeDays = 0>
<cfset overdueScopeCount = 0>

<cfset overallTotalAudits = 0>
<cfset overallTotalScopeDays = 0>
<cfset overallOverdueScopeCount = 0>

<Table border=1 style="border-collapse: collapse;">
<tr>
	<th>Lead Auditor</th>
	<th>Total Audits as Lead</th>
	<th>Overdue Scope Letters*</th>
	<th>Average Days Scope Letter Sent Before Audit</th>
	<th>On-Time Percentage</th>
</tr>
<cfoutput query="LeadAuditors">
	<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
	SELECT EndDate, StartDate, ReportDate, ScopeLetterDate, CompletionNotes
	FROM AuditSchedule
	WHERE
	<cfif url.Year neq "All">
		Year_ = #URL.Year#
	<cfelse>
		(Year_ BETWEEN 2010 AND #curYear#)
	</cfif>
	AND Approved = 'Yes'
	AND AuditedBy = 'IQA'
	<cfif LeadAuditor eq "Christopher Nicastro">
	AND (LeadAuditor = '#LeadAuditor#' OR LeadMetricsInclude = 'Yes')
	<cfelse>
	AND LeadAuditor = '#LeadAuditor#'
	</cfif>
	AND ScopeLetterDate IS NOT NULL
	</cfquery>

	<cfif Check.RecordCount GT 0>
		<cfloop query="Check">
			<!---Setting up total working days counter.--->
			<cfset variables.totalWorkingDays = -1>

			<!---Looping over our "Date Range" and incrementing our counter where the day is not Sunday or Saturday.--->
			<cfloop from="#ScopeLetterDate#" to="#StartDate#" index="i">
			   <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
			      <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
			   </cfif>
			</cfloop>

			<cfif variables.totalWorkingDays LT 10 AND NOT len(CompletionNotes)>
				<cfset overdueScopeCount = overdueScopeCount + 1>
			</cfif>

			<cfset totalScopeDays = totalScopeDays + variables.totalWorkingDays>
			<cfset totalAudits = totalaudits + 1>
		</cfloop>

		<tr>
			<Td nowrap><a href="auditCompletion_Details.cfm?Auditor=#LeadAuditor#&GlobalDesk=No">#LeadAuditor#</a></td>
			<td align="center">#totalAudits#</td>
			<td align="center">#overdueScopeCount#</td>
			<cfset avgScopeDays = numberformat(totalScopeDays / totalAudits, "99.99")>
			<td align="center">#avgScopeDays#</td>
			<cfset pctOnTime = (totalAudits-overdueScopeCount)/totalAudits>
			<td align="center"><cfif pctOnTime neq 100>#numberformat(pctOnTime * 100, 99.99)#%<cfelse>100%</cfif></td>
		</tr>
	</cfif>

<cfset overallTotalAudits = overallTotalAudits + totalAudits>
<cfset overallTotalScopeDays = overallTotalScopeDays + totalScopeDays>
<cfset overallOverdueScopeCount = overallOverdueScopeCount + overdueScopeCount>

<cfset totalAudits = 0>
<cfset totalScopeDays = 0>
<cfset overdueScopeCount = 0>
</cfoutput>

<cfoutput>
<tr>
	<Th>Total</th>
	<th align="center">#overallTotalAudits#</th>
	<th align="center">#overallOverdueScopeCount#</th>
	<cfset avgScopeDays = numberformat(overallTotalScopeDays / overallTotalAudits, "99.99")>
	<th align="center">#avgScopeDays#</th>
	<cfset pctOnTime = (overallTotalAudits-overallOverdueScopeCount)/overallTotalAudits>
	<th align="center"><cfif pctOnTime neq 100>#numberformat(pctOnTime * 100, 99.99)#%<cfelse>100%</cfif></th>
</tr>
</cfoutput>
</table><br>

* Sent less than 10 days before the Start Date<br><br>

<b>Reports</b><br>
<CFQUERY BLOCKFACTOR="100" NAME="LeadAuditors" Datasource="Corporate">
SELECT DISTINCT LeadAuditor
From AuditSchedule
WHERE
(Year_ BETWEEN 2010 AND #curYear#)
AND Approved = 'Yes'
AND AuditedBy = 'IQA'
AND Report = 'Completed'
AND LeadAuditor <> 'Denise Echols'
AND Status IS NULL
ORDER BY LeadAuditor
</cfquery>

<cfset totalAudits = 0>
<cfset totalReportDays = 0>
<cfset overdueReportCount = 0>

<cfset overallTotalAudits = 0>
<cfset overallTotalReportDays = 0>
<cfset overallOverdueReportCount = 0>

<Table border=1 style="border-collapse: collapse;">
<tr>
	<th>Lead</th>
	<th>Total Audits as Lead</th>
	<th>Overdue Reports*</th>
	<th>Average Days Report Published After Audit</th>
	<th>On-Time Percentage</th>
</tr>
<cfoutput query="LeadAuditors">
	<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
	SELECT EndDate, StartDate, ReportDate, ScopeLetterDate, AuditType2, Desk, CompletionNotes
	FROM AuditSchedule
	WHERE
	<cfif url.Year neq "All">
		Year_ = #URL.Year#
	<cfelse>
		(Year_ BETWEEN 2010 AND #curYear#)
	</cfif>
	AND Approved = 'Yes'
	AND AuditedBy = 'IQA'
	AND Report = 'Completed'
	<cfif LeadAuditor eq "Christopher Nicastro">
	AND (LeadAuditor = '#LeadAuditor#' OR LeadMetricsInclude = 'Yes')
	<cfelse>
	AND LeadAuditor = '#LeadAuditor#'
	</cfif>
	AND Status IS NULL
	</cfquery>

	<cfif Check.RecordCount GT 0>
		<cfloop query="Check">
			<cfif AuditType2 eq "Global Function/Process" AND Desk eq "Yes" AND Year LTE 2012>
			<cfelse>
				<!---Setting up total working days counter.--->
				<cfset variables.totalWorkingDays = -1>

				<!---Looping over our "Date Range" and incrementing our counter where the day is not Sunday or Saturday.--->
				<cfloop from="#EndDate#" to="#ReportDate#" index="i">
				   <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
				      <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
				   </cfif>
				</cfloop>

				<cfif variables.totalWorkingDays GT 5 AND NOT len(CompletionNotes)>
					<cfset overdueReportCount = overdueReportCount + 1>
				</cfif>

				<cfset totalReportDays = totalReportDays + variables.totalWorkingDays>
				<cfset totalAudits = totalaudits + 1>
			</cfif>
		</cfloop>

		<tr>
			<Td nowrap><a href="auditCompletion_Details.cfm?Auditor=#LeadAuditor#&GlobalDesk=No">#LeadAuditor#</a></td>
			<td align="center">#totalAudits#</td>
			<td align="center">#overdueReportCount#</td>
			<cfset avgReportDays = numberformat(totalReportDays / totalAudits, "99.99")>
			<td align="center">#avgReportDays#</td>
			<cfset pctOnTime = (totalAudits-overdueReportCount)/totalAudits>
			<td align="center"><cfif pctOnTime neq 100>#numberformat(pctOnTime * 100, 99.99)#%<cfelse>100%</cfif></td>
		</tr>
	</cfif>

<cfset overallTotalAudits = overallTotalAudits + totalAudits>
<cfset overallTotalReportDays = overallTotalReportDays + totalReportDays>
<cfset overallOverdueReportCount = overallOverdueReportCount + overdueReportCount>

<cfset totalAudits = 0>
<cfset totalReportDays = 0>
<cfset overdueReportCount = 0>

</cfoutput>

<cfoutput>
<tr>
	<Th>Total</th>
	<th align="center">#overallTotalAudits#</th>
	<th align="center">#overallOverdueReportCount#</th>
	<cfset avgReportDays = numberformat(overallTotalReportDays / overallTotalAudits, "99.99")>
	<th align="center">#avgReportDays#</th>
	<cfset pctOnTime = (overallTotalAudits-overallOverdueReportCount)/overallTotalAudits>
	<th align="center"><cfif pctOnTime neq 100>#numberformat(pctOnTime * 100, 99.99)#%<cfelse>100%</cfif></th>
</tr>
</cfoutput>
</table><br>

* Published more than 5 days after the End Date<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->