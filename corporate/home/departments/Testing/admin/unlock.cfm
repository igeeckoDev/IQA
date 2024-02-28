<!--- DV_CORP_002 02-APR-09 --->
<cfquery Datasource="Corporate" name="unlock"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 5a22d3c3-09c9-4f98-8824-13dfe948fc3e Variable Datasource name --->
SELECT null_field from login
<!---TODO_DV_CORP_002_End: 5a22d3c3-09c9-4f98-8824-13dfe948fc3e Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>