<cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT COUNT(to_char(CAROpenDate, 'mm')) as MonthOpenCount, to_char(CAROpenDate, 'mm') as MonthOpen, CARAuditedRegion
FROM GCAR_Metrics
WHERE 
<cfinclude template="shared/incProgramQuery.cfm">
CARYear = #url.year#
<cfinclude template="shared/incManagerAndViewQuery.cfm">
GROUP BY to_char(CAROpenDate, 'mm'), CARAuditedRegion
ORDER BY to_char(CAROpenDate, 'mm') ASC, CARAuditedRegion ASC
</cfquery>

<cfdump var="#qResult#">

<cfquery name="DistinctItems" dbtype="query">
SELECT DISTINCT CARAuditedRegion
From qResult
ORDER BY CARAuditedRegion
</cfquery>

<cfset i = 1>

<cfoutput query="DistinctItems">
	<cfset "Region#i#" = "#CARAuditedRegion#">
    <cfset i = i+1>
</cfoutput>

<cfset MonthHolder = "00">
<cfset RegionHolder = "">

CARs Open by Region, Month<Br>

<table border="1">
<tr>
<th>Month</th>
<cfoutput query="DistinctItems">
<th>#CARAuditedRegion#</th>
</cfoutput>
</tr>
<tr>
<cfoutput query="qResult">
<cfif MonthHolder neq MonthOpen>
<cfif MonthHolder NEQ "00" AND MonthHolder neq MonthOpen></tr><tr></cfif> 
<td><b>#MonthAsString(MonthOpen)#</b></td>
<cfset RegionHolder = 1>
</cfif>

<cfif Evaluate("Region#RegionHolder#") eq CARAuditedRegion>
    <td>#CARAuditedRegion# #MonthOpenCount#<br></td>
<cfelse>
    <td>--</td>
    <td>#CARAuditedRegion# #MonthOpenCount#<br></td>
</cfif>

<cfset MonthHolder = MonthOpen>
<cfset RegionHolder = RegionHolder + 1>
</cfoutput>
</tr>
</table>