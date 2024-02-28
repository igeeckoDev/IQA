<!--- Is there are URL Variable? If not, assign the value as last year --->
<cfif NOT isDefined("URL.YEAR")>
	<cfset url.year = "#lastyear#">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Findings - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cflock scope="SESSION" timeout="10">
	<cfif SESSION.Auth.AccessLevel eq "IQAAuditor">
		<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
		SELECT ID, Lead, Auditor
		FROM AuditorList
		WHERE Auditor = '#SESSION.Auth.Name#'
		</cfquery>
	</cfif>

	<cfif AuditorProfile.Lead eq "Yes">
		<cfset LeadAuditorQuery = "Yes">
	<cfelse>
		<cfset LeadAuditorQuery = "No">
	</cfif>
</cflock>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses_2013July1
ORDER BY ID
</cfquery>

<!--- Assign a array value to the matrix values --->
<cfset var=ArrayNew(1)>

<cfoutput>
	<cfloop query="Clauses">
		<cfset var[CurrentRow] = "#title#">
	</cfloop>
</cfoutput>

<!--- Menu: Select Year --->
<br>
<u>Select Year:</u><br>
<cfloop index="j" from="2010" to="#curyear#">
	<cfoutput>
		<!--- 2010 through current year, double colon is only used between values, not after the last/curyear --->
		<cfif j neq #url.year#>
			<a href="_nc.cfm?year=#j#">#j#</a><cfif j neq curyear> ::</cfif>
		<cfelse>
			<b>#j#</b><cfif j neq curyear> ::</cfif>
		</cfif>
	</cfoutput>
</cfloop><br>

<!--- Output --->
<Br>
<Table border=1 width=800>
	<tr>
		<th width=400>Standard Category Name</th>
		<th>Total NCs</th>
		<th>Findings</th>
		<th>Observations</th>
	</tr>
<cfoutput>
	<cfloop index=i from=1 to=#arraylen(var)#>
		<cfquery Datasource="Corporate" name="NC">
		SELECT SUM(Report.Count#i#) as Findings, SUM(Report.OCount#i#) as Observations
		FROM Report, AuditSchedule
		WHERE Report.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND Report.Year_= AuditSchedule.Year_
		AND Report.ID = AuditSchedule.ID
		<cfif LeadAuditorQuery eq "Yes">
		AND AuditSchedule.LeadAuditor = '#AuditorProfile.Auditor#'
		</cfif>
		</CFQUERY>

		<cfset value = #NC.Findings# + #NC.Observations#>

		<tr>
			<td>#var[i]#</td>
			<td>#numberformat(value, 99)#</td>

			<cfif NC.Findings GT 0>
				<cfset pctFindings = (NC.Findings / value) * 100>
			</cfif>

			<td>#numberformat(NC.Findings, 99)# <cfif NC.Findings GT 0>(#numberformat(pctFindings, 99.99)#%)</cfif></td>

			<cfif NC.Observations GT 0>
				<cfset pctObservations = (NC.Observations / value) * 100>
			</cfif>

			<td>#numberformat(NC.Observations, 99)# <cfif NC.Observations GT 0>(#numberformat(pctObservations, 99.99)#%)</cfif></td>
		</tr>
	</cfloop><br>
</cfoutput>
</Table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->