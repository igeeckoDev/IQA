<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=menu_AuditorAllocation.cfm?Year=#URL.Year#>IQA/DAP Auditor Allocation</a> - IQA/DAP Audits - #URL.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Page Notes</b>:<Br>
 :: DAP Audits are available starting in 2015.<br>
 :: Audit Days on Site and Number of Audits do not include Canceled or Removed audits.<Br>
 :: Audit Days is the number of auditing days for this audit - does not include Audit Prep or Reporting.<br><br>

<b>View Year</b>
<cfoutput>
	<cfloop from=2015 to=#curYear# index=i>
		 - <a href="#CGI.ScriptName#?Year=#i#">#i#</a>&nbsp;
	</cfloop><br><Br>
</cfoutput>

<b>IQA+DAP By Auditor - Summary</b><br><br>

<Table border=1 style="border-collapse: collapse;">
<tr valign="Top">
	<th>Auditor</th>
	<th>Audit Days on Site</th>
	<th>Number of Audits</th>
	<th>Number of IQA Audits</th>
	<th>Number of DAP Audits</th>
	<th>View Auditor's<br>Audit Schedule</th>
</tr>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE (Status = 'Active' OR Status = 'In Training')
AND IQA = 'Yes'
ORDER BY Auditor
</CFQUERY>

<cfoutput query="Auditor">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudits_IQA">
	SELECT Sum(AuditDays) as sumAuditDays, Count(*) as CountAuditDays
	FROM AuditSchedule
	WHERE (LeadAuditor = '#Auditor#'
	OR Auditor LIKE '%#Auditor#%'
	OR AuditorInTraining LIKE '%#Auditor#%')
	AND Status IS NULL
	AND Year_ = #URL.Year#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits_DAP" username="#OracleDB_Username#" password="#OracleDB_Password#">
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
			<cfif NOT len(viewAudits_DAP.sumAuditDays)>
				<cfset viewAudits_DAP.sumAuditDays = 0>
			</cfif>

			<cfif NOT len(viewAudits_IQA.sumAuditDays)>
				<cfset viewAudits_IQA.sumAuditDays = 0>
			</cfif>

			<cfset sumTotal = viewAudits_IQA.sumAuditDays + viewAudits_DAP.sumAuditDays>
			<cfif len(sumTotal)><b>#sumTotal#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<cfset countTotal = viewAudits_IQA.countAuditDays + viewAudits_DAP.countAuditDays>
			<cfif countTotal GT 0><b>#countTotal#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<cfif viewAudits_IQA.countAuditDays GT 0><b>#viewAudits_IQA.countAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<cfif viewAudits_DAP.countAuditDays GT 0><b>#viewAudits_DAP.countAuditDays#</b><cfelse>0</cfif>
		</td>
		<td align="center">
			<a href="AuditMatrix.cfm?Year=#URL.Year#&Auditor=#Auditor#">IQA</a> ::
			<a href="AuditMatrix_DAP.cfm?Year=#URL.Year#&Auditor=#Auditor#">DAP</a><br>
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
		GROUP BY Month
		</cfquery>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewLeadAudits">
		SELECT Count(*) as CountLeadAuditDays, Month
		FROM AuditSchedule
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