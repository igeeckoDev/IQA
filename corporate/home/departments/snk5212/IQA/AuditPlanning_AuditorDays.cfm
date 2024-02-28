<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditPlanning.cfm?Year=#URL.Year#'>Audit Planning</a> - Audit Days by Auditor - #URL.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<Table border=1>
<tr valign="Top">
	<th>Auditor</th>
	<th>Audit Days</th>
	<th>Number of Audits</th>
	<th>Number of Audits as Lead</th>
	<th>View Auditor's<br>Planning Schedule</th>
</tr>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE (Status = 'Active' OR Status = 'In Training')
AND IQA = 'Yes'
ORDER BY Auditor
</CFQUERY>

<b>Note</b>: Audit Days only includes audits that are active (does not include Cancelled or Removed audits).<Br><br>

<cfoutput query="Auditor">
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays
	FROM AuditSchedule_Planning
	WHERE (LeadAuditor = '#Auditor#'
	OR Auditor LIKE '%#Auditor#%'
	OR AuditorInTraining LIKE '%#Auditor#%')
	AND Status IS NULL
	AND Year_ = #URL.Year#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewLeadAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Count(*) as CountLeadAuditDays
	FROM AuditSchedule_Planning
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
			<cfif ViewLeadAudits.countLeadAuditDays GT 0><b>#ViewLeadAudits.countLeadAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<a href="AuditPlanning.cfm?Year=#URL.Year#&Auditor=#Auditor#">View</a>
		</td>
	</Tr>
</cfoutput>
<table>
<br><br>

<b>By Month</b><br><br>

<Table border=1>
<tr valign="Top">
	<th>Month</td>
	<th>Audit Days</th>
	<th>Number of Audits</th>
	<th>Number of Audits as Lead</th>
</tr>

<cfset AuditorHolder = "">

<cfoutput query="Auditor">
	<cfloop from="1" to="12" index="i">
		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays, Month
		FROM AuditSchedule_Planning
		WHERE (LeadAuditor = '#Auditor#'
		OR Auditor LIKE '%#Auditor#%'
		OR AuditorInTraining LIKE '%#Auditor#%')
		AND Status IS NULL
		AND Year_ = #URL.Year#
		AND Month = #i#
		GROUP BY Month
		</cfquery>

		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewLeadAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Count(*) as CountLeadAuditDays, Month
		FROM AuditSchedule_Planning
		WHERE LeadAuditor = '#Auditor#'
		AND Status IS NULL
		AND Year_ = #URL.Year#
		AND Month = #i#
		Group BY Month
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
				<td align="center">
					<cfif ViewLeadAudits.countLeadAuditDays GT 0><b>#ViewLeadAudits.countLeadAuditDays#</b><cfelse>0</cfif>
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