<!--- DV_CORP_002 02-APR-09 --->
<table>
<tr>
<td valign="top">

<cfquery name="Test" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 634ec645-4079-4f7f-b8b7-54908da10635 Variable Datasource name --->
SELECT * FROM qCARsbyState2007
ORDER BY CountOfCARState DESC
<!---TODO_DV_CORP_002_End: 634ec645-4079-4f7f-b8b7-54908da10635 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Test2" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 9c8e9304-cd73-42bf-9665-bbdf755804dc Variable Datasource name --->
SELECT SUM(CountOfCARState) as Sum FROM qCARSbyState2007
<!---TODO_DV_CORP_002_End: 9c8e9304-cd73-42bf-9665-bbdf755804dc Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
	<td align="center" colspan="2">CAR States - 2007</td>
</tr>
<cfoutput query="Test">
<tr>
	<td>#CARState#</td>
	<cfset perc = #CountOfCARState# / #numberformat(test2.sum, 9999)#>
	<cfset perc2 = #perc# * 100>
	<td>#CountOfCARState# - #numberformat(perc2, 99.99)#%</td>
</tr>
</cfoutput>
</table>

</td>
<td valign="top">

<cfquery name="Test" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 2ca0ea7f-4a8f-4c72-ac3e-f5aac70d1b53 Variable Datasource name --->
SELECT * FROM qCARsbyState2008
ORDER BY CountOfCARState DESC
<!---TODO_DV_CORP_002_End: 2ca0ea7f-4a8f-4c72-ac3e-f5aac70d1b53 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Test2" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 6068f7b2-e45c-4cc2-9343-4704962614a5 Variable Datasource name --->
SELECT SUM(CountOfCARState) as Sum FROM qCARSbyState2008
<!---TODO_DV_CORP_002_End: 6068f7b2-e45c-4cc2-9343-4704962614a5 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
	<td align="center" colspan="2">CAR States - 2008</td>
</tr>
<cfoutput query="Test">
<tr>
	<td>#CARState#</td>
	<cfset perc = #CountOfCARState# / #numberformat(test2.sum, 9999)#>
	<cfset perc2 = #perc# * 100>
	<td>#CountOfCARState# - #numberformat(perc2, 99.99)#%</td>
</tr>
</cfoutput>
</table>

</td>
</tr>
</table>