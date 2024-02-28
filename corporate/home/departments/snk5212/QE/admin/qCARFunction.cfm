<!--- DV_CORP_002 02-APR-09 --->
<table>
<tr>
<td valign="top">

<cfquery name="Test" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d8baeb04-f5a3-4455-97c4-6d8b765f7766 Variable Datasource name --->
SELECT * FROM qCARsbyFunction2007
ORDER BY CountOfCARType DESC
<!---TODO_DV_CORP_002_End: d8baeb04-f5a3-4455-97c4-6d8b765f7766 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Test2" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 3ae8a086-400b-4653-baf0-a58dcc20cf44 Variable Datasource name --->
SELECT SUM(CountOfCARType) as Sum FROM qCARSbyFunction2007
<!---TODO_DV_CORP_002_End: 3ae8a086-400b-4653-baf0-a58dcc20cf44 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
	<td align="center" colspan="2">CAR Functions - 2007</td>
</tr>
<cfoutput query="Test">
<tr>
	<td>#CARType#</td>
	<cfset perc = #CountOfCARType# / #numberformat(test2.sum, 9999)#>
	<cfset perc2 = #perc# * 100>
	<td>#CountOfCARType# - #numberformat(perc2, 99.99)#%</td>
</tr>
</cfoutput>
</table>

</td>
<td valign="top">

<cfquery name="Test" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 16307761-4325-4f94-b66f-92d529b3bc17 Variable Datasource name --->
SELECT * FROM qCARsbyFunction2008
ORDER BY CountOfCARType DESC
<!---TODO_DV_CORP_002_End: 16307761-4325-4f94-b66f-92d529b3bc17 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Test2" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d987fc61-7885-4333-97b5-41a7a70c4239 Variable Datasource name --->
SELECT SUM(CountOfCARType) as Sum FROM qCARSbyFunction2008
<!---TODO_DV_CORP_002_End: d987fc61-7885-4333-97b5-41a7a70c4239 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
	<td align="center" colspan="2">CAR Functions - 2008</td>
</tr>
<cfoutput query="Test">
<tr>
	<td>#CARType#</td>
	<cfset perc = #CountOfCARType# / #numberformat(test2.sum, 9999)#>
	<cfset perc2 = #perc# * 100>
	<td>#CountOfCARType# - #numberformat(perc2, 99.99)#%</td>
</tr>
</cfoutput>
</table>

</td>
</tr>
</table>