v<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Time">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Sums" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT SUM(PlanningTime) as sumPlanning, SUM(ReportingTime) as sumReporting
FROM IQAAuditTime
WHERE Year_ = #url.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="All" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM IQAAuditTime
WHERE Year_ = #url.Year#
</cfquery>

<cfoutput query="Sums">
#sumPlanning#<br>
#sumReporting#<br>
Number of Audits: #All.recordCount#<br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="List" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT IQAAuditTime.PlanningTime, IQAAuditTime.ReportingTime, Corporate.AuditSchedule.ID, Corporate.AuditSchedule.Year_, Corporate.AuditSchedule.LeadAuditor,
Corporate.AuditSchedule.AuditType2, Corporate.AuditSchedule.OfficeName, Corporate.AuditSchedule.Area
FROM IQAAuditTime, Corporate.AuditSchedule
WHERE IQAAuditTime.Year_ = #url.Year#
AND IQAAuditTime.Year_ = Corporate.AuditSchedule.Year_
AND IQAAuditTime.ID = Corporate.AuditSchedule.ID
</cfquery>

<table border=1>
<tr>
	<th>Audit Number</th>
	<th>Planning Time</th>
	<th>Reporting Time</th>
</tr>
<cfoutput query="List">
<tr>
	<td>#Year_#-#ID#</td>
	<td>#PlanningTime#</td>
	<td>#ReportingTime#</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->