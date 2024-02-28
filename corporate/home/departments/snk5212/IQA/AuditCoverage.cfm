<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset SubTitle = "IQA Audit Coverage by Standard Category">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- build the year select, if statement filters currently viewed year to be bold --->
<cfoutput>
<br>View Year:
<cfloop index="i" From="2008" To="#curyear#">
	<cfif url.year neq i>
		[<a href="AuditCoverage.cfm?Year=#i#">#i#</a>]
	<cfelseif url.year eq i>
		<b>[#i#]</b>
	</cfif>
</cfloop>
</cfoutput>
<br>

<!--- link to Standard Category Matrix as a reference --->
<a href="matrix.cfm">View</a> Standard Category Matrix<br><br>

<!--- in 2009, we added the Category 'Change in Certification Requirements'. Therefore we filter it out for 2008 (it is the last item on the standard category matrix). 2010, two categories were added - Participation in Standards Development and Regulatory Bodies. Both at the end of the list --->
<cfif url.year eq 2008>
	<cfset End = 34>
	<cfset TableName = "Clauses_2009Jan1">
<cfelseif url.year eq 2009>
	<cfset End = 35>
	<cfset TableName = "Clauses_2009Jan1">
<cfelseif url.year gte 2010>
	<cfset End = 37>
	<cfset TableName = "Clauses_2010Sept1">
</cfif>

<!--- build table --->
<table border="1">
<tr class="blog-title" align="center">
	<th>Standard Category</th>
	<th>Number of Audits</th>
</tr>
<!--- loop through the Standard Category Matrix by ID, which is used the queries below --->
<cfloop index="i" from="1" to="#End#">
	<!--- Build field names in Report4 table, which are A001 through A035, which correspond to ID 1 through ID 35 in the Clauses)2009Jan1 table --->
	<cfif i lt 10>
		<cfset FieldName = "Report4.A00#i#">
	<cfelseif i gte 10>
		<cfset FieldName = "Report4.A0#i#">
	</cfif>

<!--- query the Report4 and Auditschedule tables, similar values in these tables are ID, Year_, and AuditedBy --->
<!--- we are counting the number of audits where each category was covered for year_ = url.year --->
<cfquery name="Output" Datasource="Corporate">
SELECT Report4.*, AuditSchedule.Area, AuditSchedule.OfficeName

FROM Report4, AuditSchedule

WHERE AuditSchedule.AuditedBy = 'IQA'
AND Report4.AuditedBy = 'IQA'
AND Report4.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Report4.ID = AuditSchedule.ID
AND #FieldName# <> 0
AND AuditSChedule.Report = 'Completed'

ORDER BY AuditSchedule.OfficeName, AuditSchedule.Area
</cfquery>

<!-- obtain Category Names --->
<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM #TableName#
WHERE ID = #i#
</cfquery>

<!--- output row - Category Name, and recordcount of Output query, including link to details page --->
<cfoutput query="Clauses">
<tr class="blog-content">
	<td align="left">#Title#</td>
	<td align="center"><a href="AuditCoverageDetails.cfm?Clause=#i#&year=#url.year#">#output.recordcount#</a></td>
</tr>
</cfoutput>
</cfloop>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->