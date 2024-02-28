<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Coverage by Standard Category">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<!--- Select Standard Category Table based on year --->
<cfif url.year lt 2010>
	<cfset TableName = "Clauses_2009Jan1">
<cfelseif url.year gte 2010>
	<cfset TableName = "Clauses_2010Sept1">
</cfif>

<!--- Build field name, which is A001 through A035, corresponding to the ID/Title fields of Clauses_2009Jan1 / Clauses_2010Sept1 table. url.Clause equals the ID number of the clause. Here we are turning it into the corresponding field names in Report4 table --->
<cfif url.Clause lt 10>
	<cfset FieldName = "A00#url.Clause#">
<cfelseif url.Clause gte 10>
	<cfset FieldName = "A0#url.Clause#">
</cfif>

<!--- querying Report4/AuditSchedule Tables, FieldName equals the field we are querying, created above from the url --->
<cfquery name="Output" Datasource="Corporate">
SELECT Report4.*, AuditSchedule.Area, AuditSchedule.OfficeName, AuditSchedule.AuditArea

FROM Report4, AuditSchedule

WHERE AuditSchedule.AuditedBy = 'IQA' 
AND Report4.AuditedBy = 'IQA'
AND Report4.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Report4.ID = AuditSchedule.ID
AND #FieldName# <> 0

ORDER BY AuditSchedule.OfficeName, AuditSchedule.Area
</cfquery>

<!--- Obtain the name of the standard category from url.Clause --->
<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM #TableName#
WHERE ID = #url.Clause#
</cfquery>

<!--- output the criteria used to show output --->
<cfoutput query="Clauses">
<b>Year</b>: #url.year#<br>
<b>Standard Category</b>: #Title#<br>
<b>Number of Audits</b>: #output.recordcount#<br>
</cfoutput><br>

* - The Office Name 'Global' refers to Global Function/Process Audits that cover all applicable locations.<br><br>

<!--- build table --->
<table border="1">
<tr class="blog-title">
<th>Audit Number</th>
<th>Office Name</th>
<th>Audit Area</th>
</tr>
<cfoutput query="output">
<tr class="blog-content">
<td><a href="auditDetails.cfm?Year=#Year_#&ID=#ID#">#Year_#-#ID#</a></td>
<td>#OfficeName#</td>
<!--- some audits (i.e., field services, some others possibly) do not have an Area, so show the audit area (which is a free text field for the auditor to use to describe the audit focus --->
<td><cfif len(Area)>#Area#<cfelse>#AuditArea#</cfif></td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->