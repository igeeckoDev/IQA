<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset LastMonth = #CurMonth# - 1>

<CFQUERY BLOCKFACTOR="100" NAME="TotalTALastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE (AuditType = 'Quality System,Technical Assessment' OR
AuditType = 'Quality System, Technical Assessment' OR
AuditType = 'Technical Assessment')
 AND  Month = #LastMonth#
 AND YEAR_='2004'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalQSLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType LIKE '%Quality System%' AND  Month = #LastMonth#
 AND YEAR_='2004'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalTPTDPLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType = 'TPTDP' 
 AND  Month = #LastMonth#
 AND YEAR_='2004'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedQSLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType LIKE '%Quality System%' AND  Month = #LastMonth#
 AND YEAR_='2004' AND  Report IS NOT NULL
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedTPTDPLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType = 'TPTDP' 
 AND  Month = #LastMonth#
 AND YEAR_='2004' AND  Report IS NOT NULL
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTALastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE (AuditType = 'Quality System,Technical Assessment' OR
AuditType = 'Quality System, Technical Assessment' OR
AuditType = 'Technical Assessment')
 AND  Month = #LastMonth#
 AND YEAR_='2004' AND  Status = 'Deleted'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledQSLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType LIKE '%Quality System%' AND  Month = #LastMonth#
 AND YEAR_='2004' AND  Status = 'Deleted'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTPTDPLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType = 'TPTDP'
 AND  Month = #LastMonth#
 AND YEAR_='2004' AND  Status = 'Deleted'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedTALastMonth" Datasource="Corporate">
Select (#TotalTALastMonth.Count#-#CancelledTALastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAuditsScheduled" Datasource="Corporate">
Select (#TotalTALastMonth.Count#+#TotalQSLastMonth.Count#+#TotalTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAuditsCompleted" Datasource="Corporate">
Select (#CompletedTALastMonth.Count#+#CompletedQSLastMonth.Count#+#CompletedTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAuditsCancelled" Datasource="Corporate">
Select (#CancelledTALastMonth.Count#+#CancelledQSLastMonth.Count#+#CancelledTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalOutstanding" Datasource="Corporate">
Select (#TotalAuditsScheduled.Count#-#TotalAuditsCompleted.Count#-#TotalAuditsCancelled.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OutstandingTPTDPLastMonth" Datasource="Corporate">
Select (#TotalTPTDPLastMonth.Count#-#CompletedTPTDPLastMonth.Count#-#CancelledTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OutstandingQSLastMonth" Datasource="Corporate">
Select (#TotalQSLastMonth.Count#-#CompletedQSLastMonth.Count#-#CancelledQSLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OutstandingTALastMonth" Datasource="Corporate">
Select (#TotalTALastMonth.Count#-#CompletedTALastMonth.Count#-#CancelledTALastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFOUTPUT>
<u>Total Audits Scheduled: <B>#TotalAuditsScheduled.Count#</B></u>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#TotalTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#TotalQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#TotalTALastMonth.Count#</B>
</CFOUTPUT>
<br><br><br>

<CFOUTPUT>
<u>Total Audits Completed: <B>#TotalAuditsCompleted.Count#</B></u>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#CompletedTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#CompletedQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#CompletedTALastMonth.Count#</B>
</CFOUTPUT>
<br><br>
<CFOUTPUT>
<u>Cancelled Audits</u>: <B>#TotalAuditsCancelled.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#CancelledTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#CancelledQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#CancelledTALastMonth.Count#</B>
</CFOUTPUT>
<br><br>
<CFOUTPUT>
<u>Outstanding Audits</u>: <B>#TotalOutstanding.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#OutstandingTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#OutstandingQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#OutstandingTALastMonth.Count#</B>
</CFOUTPUT>

<cfmail
	 to="Christopher.J.Nicastro@ul.com"
	 from="Internal.Quality_Audits@ul.com"
	 cc=""
	 Mailerid="Metrics"
	 subject="Monthly Metrics">
	 

Please view http://#CGI.Server_Name#/departments/snk5212/IQA/metrics/monthly_metrics_view.cfm to view metrics for <cfif LastMonth is 1>January's<cfelseif LastMonth is 2>February's<cfelseif LastMonth is 3>March's<cfelseif LastMonth is 4>April's<cfelseif LastMonth is 5>May's<cfelseif LastMonth is 6>June's<cfelseif LastMonth is 7>July's<cfelseif LastMonth is 8>August's<cfelseif LastMonth is 9>September's<cfelseif LastMonth is 10>October's<cfelseif LastMonth is 11>November's<cfelseif LastMonth is 12>December's<cfelse></cfif> audits.
 
</cfmail>
