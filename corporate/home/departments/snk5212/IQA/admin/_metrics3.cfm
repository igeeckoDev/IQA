<cfset yr = 0>

<cfloop index="i" from="2004" to="2010">
	<cfquery name="Counts" datasource="Corporate">
	SELECT
		AuditType2,
		COUNT(xGUID) AS audit_count,
		sum(case when Status = 'Deleted' then 1 else 0 end) as cancelled_status_count,
		sum(case when RescheduleNextYear = 'Yes' then 1 else 0 end) as nextyear_status_count,
		sum(case when Report IS NOT NULL then 1 else 0 end) as report_complete_count,
		sum(case when Status = 'Deleted' AND RescheduleNextYear = 'Yes' then 1 else 0 end) as cancel_resched_count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND AuditType LIKE '%Quality System%'
	AND Year_ = #i#
	GROUP BY AuditType2
	</cfquery>

	<cfoutput query="Counts">
	<cfif yr IS NOT i>
		<b><u>#i#</u></b><br>
	</cfif>
	<u><cfif len(AuditType2)>#auditType2#<cfelse>Quality System (includes Technical Assessments)</cfif></u><Br>
	total scheduled: #audit_count#<br>
	audits complete: <cfset sum = #audit_count# - #cancelled_status_count# - #nextyear_status_count#><strong>#sum#</strong><br>
	cancelled: #cancelled_status_count#<br>
	rescheduled for next year: #nextyear_status_count#<br><br>
	<cfset yr = i>
	</cfoutput>
</cfloop>

<!---<br>
	<cfquery name="Audits" datasource="Corporate">
	SELECT Year_, ID, AuditedBy
	FROM AuditSchedule
	WHERE AuditType2 = 'N/A'
	AND AuditedBy = 'IQA'
	AND Year_ = 2007
	</cfquery>

	<cfoutput query="Audits">
	<a href="auditdetails.cfm?ID=#ID#&Year=#Year_#&AuditedBy=#AuditedBy#">View</a><br>
	</cfoutput>
	--->