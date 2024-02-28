<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="Log" DataSource="#DB.ChangeLog#"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: c90ba31b-5c16-494e-af29-1c0c3d331e87 Variable Datasource name --->
SELECT * FROM PathCount
ORDER BY Path
<!---TODO_DV_CORP_002_End: c90ba31b-5c16-494e-af29-1c0c3d331e87 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log2" DataSource="#DB.ChangeLog#"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: fa695ab4-afa6-40b4-bc39-22c5b74f0f7e Variable Datasource name --->
SELECT * FROM PathCount2
ORDER BY Path
<!---TODO_DV_CORP_002_End: fa695ab4-afa6-40b4-bc39-22c5b74f0f7e Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log3" DataSource="#DB.ChangeLog#"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 8bc75b40-fa04-46aa-b6f4-33e74e0693c7 Variable Datasource name --->
SELECT * FROM PathCount3
ORDER BY Path
<!---TODO_DV_CORP_002_End: 8bc75b40-fa04-46aa-b6f4-33e74e0693c7 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log4" DataSource="#DB.ChangeLog#"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: ffe18992-722c-4481-975e-7cf81abfb5e7 Variable Datasource name --->
SELECT * FROM PathCount4
ORDER BY Path
<!---TODO_DV_CORP_002_End: ffe18992-722c-4481-975e-7cf81abfb5e7 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfset Total = "">
<cfoutput query="Log" maxrows="1">

<cfif Log2.Path is #Log.Path#>
	<cfset Total = #Log.CountofID# + #Log2.CountofID#>
<cfelseif Log3.Path is #Log.Path#>
	<cfset Total = #Total# + #Log3.CountofID#>
<cfelseif Log4.Path is #Log.Path#>	
	<cfset Total = #Total# + #Log4.CountofID#>
</cfif>

<cfset Total = #Total#>
</cfoutput>

<cfoutput>#Path# - #Total#</cfoutput>