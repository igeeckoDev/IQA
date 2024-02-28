<!--- DV_CORP_002 02-APR-09 --->
<cfquery name="Monthly" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 2174d79c-1336-4b20-bc94-ee813fe4debb Variable Datasource name --->
SELECT MONTH(CAROpenDate) as Mon, YEAR(CAROpenDate) as Yr, COUNT(*) as Count 
FROM qDataMartGCAR_09152008
GROUP BY YEAR(CAROpenDate), MONTH(CAROpenDate)
<!---TODO_DV_CORP_002_End: 2174d79c-1336-4b20-bc94-ee813fe4debb Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Yearly" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 67706f71-c95e-41c9-abba-bbcdea338f81 Variable Datasource name --->
SELECT YEAR(CAROpenDate) as Yr, COUNT(*) as Count 
FROM qDataMartGCAR_09152008
GROUP BY YEAR(CAROpenDate)
<!---TODO_DV_CORP_002_End: 67706f71-c95e-41c9-abba-bbcdea338f81 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
<td>Month</td>
<td>Year</td>
<td>CAR Count</td>
<td>percent</td>
</tr>
<cfset yrholder = "">
<cfoutput query="Monthly">
<cfif yrholder IS NOT Yr AND yrholder IS NOT "">
<tr>
	<td colspan="4">
	Total 2007 CARs = #yearly.Count#<br>
	<cfset yravg = #Yearly.Count# / 12 >
	Average CARs per Month = #yravg#
	</td>
</tr>
<tr>
	<td colspan="4">&nbsp;</td>
</tr>
</cfif>
<tr>
<td>#monthasstring(Mon)#</td>
<td>#Yr#</td>
<td align="center">#Count#</td>
<cfset perc = #Count# / #Yearly.Count#>
<cfset perc2 = #perc# * 100>
<td align="center">#numberformat(perc2, 99.99)#%</td>
</tr>
<cfset yrholder = #yr#>
</cfoutput>

<cfquery name="Yearly" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: f8128b4e-d26f-43e2-8ce3-f92da9516243 Variable Datasource name --->
SELECT YEAR(CAROpenDate) as Yr, COUNT(*) as Count 
FROM qDataMartGCAR_09152008
WHERE YEAR(CAROpenDate) = 2008
GROUP BY YEAR(CAROpenDate)
<!---TODO_DV_CORP_002_End: f8128b4e-d26f-43e2-8ce3-f92da9516243 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfoutput query="Yearly">
<tr>
	<td colspan="4">
	Total 2008 CARs = #Count#<br>
	<cfset yravg = #Count# / 8.5 >
	* Average CARs per Month = #numberformat(yravg, 999.99)#
	</td>
</tr>
<tr>
	<td colspan="4">* 8.5 months of data</td>
</tr>
</cfoutput>
</table>