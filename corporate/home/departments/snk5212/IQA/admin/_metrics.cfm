<cfloop index="i" from="2004" to="#curyear#">
	<CFQUERY BLOCKFACTOR="100" name="Total" Datasource="Corporate">
	SELECT COUNT(xGUID) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #i#
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Scheduled" Datasource="Corporate">
	SELECT COUNT(xGUID) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #i#
	AND Status IS NULL
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Removed" Datasource="Corporate">
	SELECT COUNT(xGUID) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #i#
	AND Status = 'Deleted'
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Deleted" Datasource="Corporate">
	SELECT COUNT(xGUID) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #i#
	AND Status = 'removed'
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="RescheduleNextYear" Datasource="Corporate">
	SELECT COUNT(xGUID) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #i#
	AND RescheduleNextYear = 'Yes'
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Report" Datasource="Corporate">
	SELECT COUNT(xGUID) as Count
	FROM AuditSchedule
	WHERE AuditedBy = 'IQA'
	AND Year_ = #i#
	AND Report IS NOT NULL
	</CFQUERY>

	<cfoutput query="Scheduled">
	<b>#i#</b><br>
	Total Audits: #Total.Count# (Report Completed - #Report.Count#)<br>
	Scheduled Audits: #Count#<br>
	Cancelled Audits: #Removed.Count#<br>
	Deleted Audits: #Deleted.Count#<br>
	Rescheduled for Next Year: #RescheduleNextYear.Count#<br><br>
	</cfoutput>
</cfloop>