<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=menu_AuditorAllocation.cfm?Year=#URL.Year#>IQA/DAP Auditor Allocation</a> - IQA Audits - #URL.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
<cfsetting requestTimeout="600">
<b>Page Notes</b>:<Br>
 :: Audit Days on Site is available starting in 2014.<br>
 :: Audit Days on Site and Number of Audits do not include Canceled or Removed audits.<Br>
 :: Audit Days is the number of auditing days for this audit - does not include Audit Prep or Reporting.<br><br>

<b>View Year</b>
<cfoutput>
	<cfloop from=2012 to=#curYear# index=i>
		 - <a href="#CGI.ScriptName#?Year=#i#">#i#</a>&nbsp;
	</cfloop><br><Br>
</cfoutput>

<b>By Month - Summary</b><br><br>

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

<Tr>
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
<Tr>
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

<b>By Auditor - Summary</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Auditor</th>
	<cfif URL.Year GTE 2014>
		<th>Audit Days on Site</th>
	</cfif>
	<th>Number of Audits</th>
	<th>Number of Audits as Lead</th>
	<th>View Auditor's<br>Audit Schedule</th>
</tr>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE IQA = 'Yes' AND ( Status= 'Active' OR Status= 'In Training')
<!--- excluding DAP Auditors before 2015 --->
<cfif URL.Year LT 2015>
AND DAPAuditor IS NULL
</cfif>
ORDER BY Auditor
</CFQUERY>

<cfoutput query="Auditor">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudits">
	SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays
	FROM AuditSchedule
	WHERE (LeadAuditor = '#Auditor#'
	OR Auditor LIKE '%#Auditor#%'
	OR AuditorInTraining LIKE '%#Auditor#%')
	AND Status IS NULL
	AND Year_ = #URL.Year#
	AND AuditedBy = 'IQA'
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewLeadAudits">
	SELECT Count(*) as CountLeadAuditDays
	FROM AuditSchedule
	WHERE LeadAuditor = '#Auditor#'
	AND Status IS NULL
	AND Year_ = #URL.Year#
	AND AuditedBy = 'IQA'
	</cfquery>

	<Tr>
		<td width="150">
			#Auditor#
		</td>
		<cfif URL.Year GTE 2014>
			<td width="80" align="center">
				<cfif len(viewAudits.sumAuditDays)><b>#viewAudits.sumAuditDays#</b><cfelse>0</cfif>
			</td>
		</cfif>
		<td align="center">
			<cfif #ViewAudits.countAuditDays# GT 0><b>#ViewAudits.countAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<cfif ViewLeadAudits.countLeadAuditDays GT 0><b>#ViewLeadAudits.countLeadAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<a href="AuditMatrix.cfm?Year=#URL.Year#&Auditor=#Auditor#">View</a>
		</td>
	</Tr>
</cfoutput>
<table>
<br><br>

<b>By Auditor/Month</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Month</td>
	<cfif URL.Year GTE 2014>
		<th>Audit Days on Site</th>
	</cfif>
	<th>Number of Audits</th>
	<th>Number of Audits as Lead</th>
</tr>

<cfset AuditorHolder = "">

<cfoutput query="Auditor">
	<cfloop from="1" to="12" index="i">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudits">
		SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays, Month
		FROM AuditSchedule
		WHERE (LeadAuditor = '#Auditor#'
		OR Auditor LIKE '%#Auditor#%'
		OR AuditorInTraining LIKE '%#Auditor#%')
		AND Status IS NULL
		AND Year_ = #URL.Year#
		AND Month = #i#
		AND AuditedBy = 'IQA'
		GROUP BY Month
		</cfquery>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewLeadAudits">
		SELECT Count(*) as CountLeadAuditDays, Month
		FROM AuditSchedule
		WHERE LeadAuditor = '#Auditor#'
		AND Status IS NULL
		AND Year_ = #URL.Year#
		AND Month = #i#
		AND AuditedBy = 'IQA'
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
				<cfif URL.Year GTE 2014>
					<td width="80" align="center">
						<cfif len(viewAudits.sumAuditDays)><b>#viewAudits.sumAuditDays#</b><cfelse>0</cfif>
					</td>
				</cfif>
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