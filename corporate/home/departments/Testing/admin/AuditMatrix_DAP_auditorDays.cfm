<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=menu_AuditorAllocation.cfm?Year=#URL.Year#>IQA/DAP Auditor Allocation</a> - DAP Audits - #URL.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Page Notes</b>:<Br>
 :: DAP Audits are available starting in 2015.<br>
 :: Audit Days on Site is available starting in 2014.<br>
 :: Audit Days on Site and Number of Audits do not include Canceled or Removed audits.<Br>
 :: Audit Days is the number of auditing days for this audit - does not include Audit Prep or Reporting.<br><br>

<b>View Year</b>
<cfoutput>
	<cfloop from=2015 to=#nextYear# index=i>
		 - <a href="#CGI.ScriptName#?Year=#i#">#i#</a>&nbsp;
	</cfloop><br><Br>
</cfoutput>

<b>By Month - Summary</b><br><br>

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

<Tr>
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
<Tr>
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

<b>By Auditor - Summary</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Auditor</th>
	<th>Audit Days on Site</th>
	<th>Number of Audits</th>
	<th>View Auditor's<br>Audit Schedule</th>
</tr>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE (Status = 'Active' OR Status = 'In Training')
AND IQA = 'Yes'
AND DAPAuditor = 'Yes'
ORDER BY Auditor
</CFQUERY>

<cfoutput query="Auditor">
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays
	FROM DAP_AuditSchedule
	WHERE LeadAuditor = '#Auditor#'
	AND Status IS NULL
	AND Year_ = #URL.Year#
	</cfquery>

	<Tr>
		<td width="150">
			#Auditor#
		</td>
		<td width="80" align="center">
			<cfif len(viewAudits.sumAuditDays)><b>#viewAudits.sumAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<cfif #ViewAudits.countAuditDays# GT 0><b>#ViewAudits.countAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<a href="AuditMatrix_DAP.cfm?Year=#URL.Year#&Auditor=#Auditor#">View</a>
		</td>
	</Tr>
</cfoutput>
<table>
<br><br>

<b>By Auditor/Month</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Month</td>
	<th>Audit Days on Site</th>
	<th>Number of Audits</th>
</tr>

<cfset AuditorHolder = "">

<cfoutput query="Auditor">
	<cfloop from="1" to="12" index="i">
		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays, Month
		FROM DAP_AuditSchedule
		WHERE LeadAuditor = '#Auditor#'
		AND Status IS NULL
		AND Year_ = #URL.Year#
		AND Month = #i#
		GROUP BY Month
		</cfquery>

		<cfif viewAudits.RecordCount GT 0>
			<cfif len(AuditorHolder) AND AuditorHolder NEQ Auditor
				OR NOT len(AuditorHolder)>
				<tr>
					<th colspan="4" align="left">#Auditor#</th>
				</tr>
			</cfif>
			<Tr>
				<td>
					#MonthAsString(i)#
				</td>
				<td width="80" align="center">
					<cfif len(viewAudits.sumAuditDays)><b>#viewAudits.sumAuditDays#</b><cfelse>0</cfif>
				</td>
				<td align="center">
					<cfif #ViewAudits.countAuditDays# GT 0><b>#ViewAudits.countAuditDays#</b><cfelse>0</cfif>
				</td>
			</Tr>
		<cfset AuditorHolder = Auditor>
		</cfif>
	<cfset i = i + 1>
	</cfloop>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->