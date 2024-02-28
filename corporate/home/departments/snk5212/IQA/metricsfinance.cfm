<CFQUERY BLOCKFACTOR="100" NAME="TotalAudits" Datasource="Corporate">
SELECT COUNT(*) as Count
FROM AuditSchedule
WHERE year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND (status IS NULL OR Status = 'Deleted')
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Approved = 'Yes'
</cfquery>

<cfif TotalAudits.Count is 0>

<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="Next" Datasource="Corporate">
SELECT COUNT(*) as Count
FROM AuditSchedule
WHERE RescheduleNextYEAR = 'Yes'
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
AND AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleTotal" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where RescheduleStatus = 'Rescheduled'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND (status IS NULL OR Status = 'Deleted')
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="PercentageTotal" Datasource="Corporate">
Select (#rescheduleTotal.count#/#TotalAudits.count#) as PercentageTotal From AuditSchedule
</cfquery>

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset Now = #Dateformat(now(), 'mm/dd/yyyy')#>
<CFSET Today = #CREATEODBCDATETIME('#Now#')#>

<CFQUERY BLOCKFACTOR="100" NAME="Cancelled" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
and Status = 'Deleted'
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledThisMonth" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE Month = #CurMonth#
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and StartDate <= #Today#
and Status = 'Deleted'
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledPast" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE Month <= #CurMonth#
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and Status = 'Deleted'
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Done" Datasource="Corporate">
SELECT COUNT(*) as Count
FROM AuditSchedule
WHERE <cfif url.YEAR eq curyear>Month <= #CurMonth# AND</cfif>
Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
AND AuditedBy='#URL.AuditedBy#'
AND status IS NULL
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Completed" Datasource="Corporate">
Select ((#Done.Count#)-(#CancelledThisMonth.Count#+#CancelledPast.Count#)) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Deleted" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE Status = 'Deleted'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>
</cfif>