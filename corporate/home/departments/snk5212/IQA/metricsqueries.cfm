<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" NAME="TotalTPTDP" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
and AuditType = 'TPTDP'
AND (status IS NULL OR status <> 'removed')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalQS" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy = '#URL.AuditedBy#'
and AuditType LIKE '%Quality System%'
AND (status IS NULL OR status <> 'removed')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalTA" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE AuditType LIKE '%Technical Assessment%'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND (status IS NULL OR status <> 'removed')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAudits" Datasource="Corporate">
Select (#TotalTPTDP.Count# + #TotalQS.Count# + #TotalTA.Count#) as Count From AuditSchedule
</cfquery>

<cfif TotalAudits.Count is 0>

<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleTPTDP" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where RescheduleStatus = 'Rescheduled'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
and AuditType = 'TPTDP'
AND (status IS NULL)
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleTPTDPfor2005" Datasource="Corporate">
SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE RescheduleStatus = 'Rescheduled'
 AND RescheduleNextYEAR='Yes' AND  year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
 AND  AuditedBy='#URL.AuditedBy#'
 AND  AuditType = 'TPTDP'
 AND  (status IS NULL)
 AND  Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleTPTDPfor2004" Datasource="Corporate">
Select (#RescheduleTPTDP.Count#-#RescheduleTPTDPfor2005.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleQS" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where RescheduleStatus = 'Rescheduled'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
and (AuditType LIKE '%Quality System%')
AND (status IS NULL)
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleTA" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where (AuditType LIKE '%Technical Assessment%')
and RescheduleStatus = 'Rescheduled'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND (status IS NULL)
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="RescheduleTotal" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where RescheduleStatus = 'Rescheduled'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND (status IS NULL)
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="PercentageTotal" Datasource="Corporate">
Select (#rescheduleTotal.count# / #TotalAudits.count#) as PercentageTotal From AuditSchedule
</cfquery>

<cfif totalTPTDP.Count is 0>
<cfelse>
<CFQUERY BLOCKFACTOR="100" NAME="PercentageTPTDPfor2004" Datasource="Corporate">
Select (#rescheduleTPTDPfor2004.count#/#totalTPTDP.count#) as PercentageTPTDP04 From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="PercentageTPTDPfor2005" Datasource="Corporate">
Select (#rescheduleTPTDPfor2005.count#/#totalTPTDP.count#) as PercentageTPTDP05 From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="PercentageTPTDP" Datasource="Corporate">
Select (#rescheduleTPTDP.count#/#totalTPTDP.count#) as PercentageTPTDP From AuditSchedule
</cfquery>
</cfif>

<cfif totalqs.count is 0>
<cfelse>
<CFQUERY BLOCKFACTOR="100" NAME="PercentageQS" Datasource="Corporate">
Select (#rescheduleQS.count#/#totalQS.count#) as PercentageQS From AuditSchedule
</cfquery>
</cfif>

<cfif totalta.count is 0>
<cfelse>
<CFQUERY BLOCKFACTOR="100" NAME="PercentageTA" Datasource="Corporate">
Select (#rescheduleTA.count#/#totalTA.count#) as PercentageTA From AuditSchedule
</cfquery>
</cfif>

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset Now = #Dateformat(now(), 'mm/dd/yyyy')#>
<CFSET Today = #CREATEODBCDATETIME('#Now#')#>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTA" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE AuditType LIKE '%Technical Assessment%'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
and Status = 'Deleted'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledQSThisMonth" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE AuditType LIKE '%Quality System%'
and Month = #CurMonth#
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and StartDate <= #Today#
and Status = 'Deleted'
and AuditedBy='#URL.AuditedBy#'
and Report IS NULL
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledQSPast" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE AuditType LIKE '%Quality System%'
and Month <= #CurMonth#
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and Status = 'Deleted'
and AuditedBy='#URL.AuditedBy#'
and Report IS NULL
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTPTDPThisMonth" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE AuditType = 'TPTDP'
and Month = #CurMonth#
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and StartDate <= #Today#
and Status = 'Deleted'
and AuditedBy='#URL.AuditedBy#'
and Report IS NULL
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTPTDPPast" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE AuditType = 'TPTDP'
and Month <= #CurMonth#
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and Status = 'Deleted'
and AuditedBy='#URL.AuditedBy#'
and Report IS NULL
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="DoneTPTDP" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where Report = 'Completed'
AND year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
AND AuditType = 'TPTDP'
AND AuditedBy='#URL.AuditedBy#'
AND (status IS NULL  OR status <> 'removed')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="DoneQS" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
Where Report = 'Completed'
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
AND AuditType LIKE '%Quality System%'
AND AuditedBy='#URL.AuditedBy#'
AND (status IS NULL  OR status <> 'removed')
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedTPTDP" Datasource="Corporate">
Select ((#DoneTPTDP.Count#)-(#CancelledTPTDPThisMonth.Count#+#CancelledTPTDPPast.Count#)) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TACompleted" Datasource="Corporate">
Select (#TotalTA.Count# - #CancelledTA.Count#) as Count From AuditSchedule
</cfquery>


<CFQUERY BLOCKFACTOR="100" NAME="CompletedQS" Datasource="Corporate">
Select ((#DoneQS.Count#)-(#CancelledQSThisMonth.Count#+#CancelledQSPast.Count#)) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalCompleted" Datasource="Corporate">
Select (#CompletedTPTDP.Count#+#CompletedQS.Count#+#TACompleted.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="DeletedQS" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE Status = 'Deleted'
and AuditType LIKE '%Quality System%'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="DeletedTA" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE Status = 'Deleted'
and AuditType LIKE '%Technical Assessment%'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="DeletedTPTDP" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE Status = 'Deleted'
and AuditType = 'TPTDP'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Deleted" Datasource="Corporate">
Select (#DeletedTPTDP.Count#+#DeletedQS.Count#+#DeletedTA.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="NextYearQS" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE RescheduleNextYear = 'Yes'
AND Status IS NULL
and AuditType LIKE '%Quality System%'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="NextYearTA" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE RescheduleNextYear = 'Yes'
AND Status IS NULL
and AuditType LIKE '%Technical Assessment%'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="NextYearTPTDP" Datasource="Corporate">
Select COUNT(*) as Count From AuditSchedule
WHERE RescheduleNextYear = 'Yes'
AND Status IS NULL
and AuditType = 'TPTDP'
and year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
and AuditedBy='#URL.AuditedBy#'
AND Approved = 'Yes'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="NextYear" Datasource="Corporate">
Select (#NextYearTPTDP.Count#+#NextYearQS.Count#+#NextYearTA.Count#) as Count From AuditSchedule
</cfquery>

</cfif>