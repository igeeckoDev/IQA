<!--- DV_CORP_002 02-APR-09 --->
<cfquery name="Sectors" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 02 APR 09 Change Start--->
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 8e217ef2-e757-4a02-8fa0-4183c55bf872 Variable Datasource name --->

SELECT SECTOR FROM  CAR_SECTOR  "SECTOR" ORDER BY SECTOR
<!---TODO_DV_CORP_002_End: 8e217ef2-e757-4a02-8fa0-4183c55bf872 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->

<!--- DV_CORP_002 02 APR 09 Change End--->
</cfquery>

<cfset var = ArrayNew(1)>
<cfset i = 1>
<cfloop query="Sectors">
<cfset var[#i#] = #Sector#>
<cfset i = i+1>
</cfloop>

<span class="blog-title">Sort by: Sectors</span><br>
<cfloop index="i" from="1" to ="#Sectors.recordcount#">
<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 02 APR 09 Change Start--->
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 68c807b2-f1ce-44f2-9c0b-149ff1323b01 Variable Datasource name --->

SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE Sectors LIKE '%#var[i]#%'
AND Status = 'Active'
ORDER BY ID
<!---TODO_DV_CORP_002_End: 68c807b2-f1ce-44f2-9c0b-149ff1323b01 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->

<!--- DV_CORP_002 02 APR 09 Change End--->
</cfquery>

<cfset Holder = "">
<cfoutput query="alerts">
<cfif Holder IS NOT "#var[i]#"><br>
<cfIf Holder is NOT ""><br></cfif>
<u>#var[i]#</u><br>
</cfif>
 - <a href="alertView.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#</a><br>
<cfset Holder = "#var[i]#">
</cfoutput>
</cfloop>