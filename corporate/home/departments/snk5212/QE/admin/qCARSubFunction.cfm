<!--- DV_CORP_002 02-APR-09 --->
<table>
<tr>
<td valign="top">

<cfquery name="Test" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 3775e035-09ac-4971-b5e3-fe6bc871cc78 Variable Datasource name --->
SELECT * FROM qCARsbySubFunction2007
ORDER BY CountOfCARSubType DESC
<!---TODO_DV_CORP_002_End: 3775e035-09ac-4971-b5e3-fe6bc871cc78 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Test2" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: becaf9a2-b7fb-4544-9937-9150e9096ad6 Variable Datasource name --->
SELECT SUM(CountOfCARSubType) as Sum FROM qCARSbySubFunction2007
<!---TODO_DV_CORP_002_End: becaf9a2-b7fb-4544-9937-9150e9096ad6 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
	<td align="center" colspan="2">CAR Functions - 2007</td>
</tr>
<cfoutput query="Test">
<tr>
	<td>#CARSubType#</td>
	<cfset perc = #CountOfCARSubType# / #numberformat(test2.sum, 9999)#>
	<cfset perc2 = #perc# * 100>
	<td>#CountOfCARSubType# - #numberformat(perc2, 99.99)#%</td>
</tr>
</cfoutput>
</table>

</td>
<td valign="top">

<cfquery name="Test" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d2353319-da3e-4087-8cee-310d2a0ae7b5 Variable Datasource name --->
SELECT * FROM qCARsbySubFunction2008
ORDER BY CountOfCARSubType DESC
<!---TODO_DV_CORP_002_End: d2353319-da3e-4087-8cee-310d2a0ae7b5 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfquery name="Test2" datasource="Corporate" blockfactor="100"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: c254c447-d4f7-426c-b939-eda714dbd12c Variable Datasource name --->
SELECT SUM(CountOfCARSubType) as Sum FROM qCARSbySubFunction2008
<!---TODO_DV_CORP_002_End: c254c447-d4f7-426c-b939-eda714dbd12c Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table border="1">
<tr>
	<td align="center" colspan="2">CAR Functions - 2008</td>
</tr>
<cfoutput query="Test">
<tr>
	<td>#CARSubType#</td>
	<cfset perc = #CountOfCARSubType# / #numberformat(test2.sum, 9999)#>
	<cfset perc2 = #perc# * 100>
	<td>#CountOfCARSubType# - #numberformat(perc2, 99.99)#%</td>
</tr>
</cfoutput>
</table>

</td>
</tr>
</table>