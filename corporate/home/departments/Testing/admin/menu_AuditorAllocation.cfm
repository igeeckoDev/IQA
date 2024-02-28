<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA/DAP Auditor Allocation - #URL.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<style type="text/css">
	tr.shade:nth-child(even) {background: #FFF}
	tr.shade:nth-child(odd) {background: #EEE}
</style>

<b>View Year</b>
<cfoutput>
	<cfloop from=2012 to=#curYear# index=i>
		 - <a href="#CGI.ScriptName#?Year=#i#">#i#</a>&nbsp;
	</cfloop><br><Br>

<b>Auditor Allocation Details</b><br>
 :: <a href="AuditMatrix_auditorDays.cfm?Year=#URL.Year#">IQA</a> Audits<br>
 :: <a href="AuditMatrix_DAP_auditorDays.cfm?Year=#URL.Year#">DAP</a> Audits<br>
 :: <a href="AuditMatrix_Full_auditorDays.cfm?Year=#URL.Year#">IQA and DAP</a> Audits<br><br>
</cfoutput>

<b>Page Notes</b>:<Br>
 :: DAP Audits are available starting in 2015.<br>
 :: Audit Days on Site is available starting in 2014.<br>
 :: Audit Days on Site and Number of Audits do not include Canceled or Removed audits.<Br>
 :: Audit Days is the number of auditing days for this audit - does not include Audit Prep or Reporting.<br><br>

<b>IQA By Month - Summary</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Month</th>
	<cfif URL.Year GTE 2014>
		<th>Audit Days on Site</th>
	</cfif>
	<th>Number of Audits</th>
	<th>Average Audit Team</th>
	<th>View Monthly<br>Audit Schedule</th>
</tr>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudits">
SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays, Month
FROM AuditSchedule
WHERE Status IS NULL
AND Year_ = #URL.Year#
AND AuditedBy = 'IQA'
GROUP BY MONTH
ORDER BY MONTH
</cfquery>

<cfset YearAuditTeamCount = 0>

<Cfoutput query="ViewAudits">
<Cfset AuditTeam = 0>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="auditorCount">
SELECT Auditor, LeadAuditor, AuditorInTraining
FROM AuditSchedule
WHERE Status IS NULL
AND Year_ = #URL.Year#
AND Month = #Month#
AND AuditedBy = 'IQA'
ORDER BY ID
</cfquery>

<Tr class="shade">
	<td width="150">
		#MonthAsString(month)#
	</td>
	<cfif URL.Year GTE 2014>
		<td width="80" align="center">
			<cfif len(sumAuditDays)>#sumAuditDays#<cfelse>0</cfif>
		</td>
	</cfif>
	<td align="center">
		<cfif #countAuditDays# GT 0>#countAuditDays#<cfelse>0</cfif>
	</td>
	<td align="center">
		<cfloop query="auditorCount">
			<cfset AuditTeam = #listlen(LeadAuditor)# + AuditTeam>
			<cfset AuditTeam = #listlen(Auditor)# + AuditTeam>
			<cfset AuditTeam = #listlen(AuditorInTraining)# + AuditTeam>
		</cfloop>

		<cfif len(CountAuditDays)>
			<cfset avgAuditTeam = #numberformat(AuditTeam / CountAuditDays, "0.00")#>
			#avgAuditTeam#
		<cfelse>
			N/A
		</cfif>

		<cfset YearAuditTeamCount = YearAuditTeamCount + AuditTeam>
	</td>
	<td align="center">
		<a href="AuditMatrix.cfm?Year=#URL.Year#&Month=#Month#">View</a>
	</td>
</Tr>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudits">
SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays
FROM AuditSchedule
WHERE Status IS NULL
AND Year_ = #URL.Year#
AND AuditedBy = 'IQA'
</cfquery>

<cfoutput query="ViewAudits">
<Tr class="shade">
	<td width="150">
		Total
	</td>
	<cfif URL.Year GTE 2014>
		<td width="80" align="center">
			<cfif len(sumAuditDays)><b>#sumAuditDays#</b><cfelse>0</cfif>
		</td>
	</cfif>
	<td align="center">
		<cfif #countAuditDays# GT 0><b>#countAuditDays#</b><cfelse>0</cfif>
	</td>
	<td align="center">
		<cfset avgAuditTeam = #numberformat(#YearAuditTeamCount# / CountAuditDays, "0.00")#>
		<b>#avgAuditTeam#</b>
	</td>
	<td align="center">
		--
	</td>
</Tr>
</cfoutput>
<table>
<br><br>

<cfif URL.Year GTE 2015>
<b>DAP By Month - Summary</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Month</th>
	<th>Audit Days on Site</th>
	<th>Number of Audits</th>
	<th>View Monthly<br>Audit Schedule</th>
</tr>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays, Month
FROM DAP_AuditSchedule
WHERE Status IS NULL
AND Year_ = #URL.Year#
GROUP BY MONTH
ORDER BY MONTH
</cfquery>

<cfset YearAuditTeamCount = 0>

<Cfoutput query="ViewAudits">
<Cfset AuditTeam = 0>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="auditorCount" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT LeadAuditor
FROM DAP_AuditSchedule
WHERE Status IS NULL
AND Year_ = #URL.Year#
AND Month = #Month#
ORDER BY ID
</cfquery>

<Tr class="shade">
	<td width="150">
		#MonthAsString(month)#
	</td>
	<td width="80" align="center">
		<cfif len(sumAuditDays)>#sumAuditDays#<cfelse>0</cfif>
	</td>
	<td align="center">
		<cfif #countAuditDays# GT 0>#countAuditDays#<cfelse>0</cfif>
	</td>
	<td align="center">
		<a href="AuditMatrix_DAP.cfm?Year=#URL.Year#&Month=#Month#">View</a>
	</td>
</Tr>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays
FROM DAP_AuditSchedule
WHERE Status IS NULL
AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="ViewAudits">
<Tr class="shade">
	<td width="150">
		Total
	</td>
	<td width="80" align="center">
		<cfif len(sumAuditDays)><b>#sumAuditDays#</b><cfelse>0</cfif>
	</td>
	<td align="center">
		<cfif #countAuditDays# GT 0><b>#countAuditDays#</b><cfelse>0</cfif>
	</td>
	<td align="center">
		--
	</td>
</Tr>
</cfoutput>
<table>
<br><br>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->