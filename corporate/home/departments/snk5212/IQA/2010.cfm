<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT * 
FROM AuditSchedule
WHERE Year_ = 2010
AND AuditedBy = 'IQA'
ORDER BY Status DESC, AuditType2, Area, ID
</CFQUERY>

<table border=1>
<tr class="blog-content">
	<td>Count</td>
	<td>Year</td>
	<td>ID</td>
	<td>Audit Type 2</td>
	<td>Status</td>
	<td>Audit Area</td>
	<td>Area</td>
	<td>Office Name</td>
	<td>Lead Auditor</td>
	<td>Month</td>
	<td>Scope/Report</td>
</tr>
<cfset i = 1>
<cfoutput query="Check">
<tr class="blog-content">
	<td>#i#</td>
	<td>#Year_#</td>
	<td>#ID#</td>
	<td>#AuditType2#</td>
	<td><cfif NOT len(Status)>Active<cfelse><b><font color="red">#Status#</font></b></cfif></td>
	<td>#AuditArea#</td>
	<td>#Area#</td>
	<td>#OfficeName#</td>
	<td>#LeadAuditor#</td>
	<td><cfif Month lt 1 OR Month gt 12><b>#Month#</b><cfelse>#MonthAsString(Month)#</cfif> </td>
	<td>#ScopeLetter#/#Report#</td>
</tr>
<cfset i = i + 1>
</cfoutput>
</table>