<!--- This file is run every day at 6am by the cf scheduler / coldfusion server.

CF Scheduler items are shown here: \\USNBKW002P\c$\ColdFuions8\lib\neo-cron.xml --->

<!--- Scope Check / Notify --->
<cfinclude template="ScopeNotify.cfm">

<!--- Report Check / Notify --->
<cfinclude template="ReportNotify.cfm">

<!--- removed by Kai and chris on Dec 7 2018 due to migration to new server
	<!--- Audit Schedule Backup to UL06046.AuditSchedule_Backup --->
	<cfinclude template="AuditSchedule_Backup.cfm">

	<!--- Audit Planning Backup to UL06046.AuditSchedule__Planning_Backup --->
	<cfinclude template="AuditPlanning_Backup.cfm">
--->
	
<!--- DAP SNAP overdue notifications --->
<cfinclude template="DAPSNAPNotify.cfm">

<!---
<CFQUERY BLOCKFACTOR="100" NAME="baseline" Datasource="Corporate">
SELECT *  FROM Baseline
WHERE YEAR_ = #curYear#
</cfquery>

<!--- move audits quarterly --->
<cfif baseline.baseline eq 1>
	<cfif Day is 15>
    	<cfif Month gt 1>
        	<cflocation url="_MoveToNextYear.cfm?MoveYear=#curYear#" addtoken="no">
		</cfif>
    <cfelseif Day is 02>
    	<cfif Month eq 01>
        	<cflocation url="_MoveToNextYear.cfm?MoveYear=#lastYear#" addtoken="no">
        </cfif>
	</cfif>
</cfif>
--->