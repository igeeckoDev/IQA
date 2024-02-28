<!--- DV_CORP_002 02-APR-09 --->
<cfquery name="Offices" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: a1ea357b-b2eb-402d-b397-aea34369a1d6 Variable Datasource name --->
SELECT OfficeName FROM IQAtblOffices
WHERE Physical = 'Yes'
AND Exist = 'Yes'
AND CB = 'No'
ORDER BY OfficeName
<!---TODO_DV_CORP_002_End: a1ea357b-b2eb-402d-b397-aea34369a1d6 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfset var = ArrayNew(1)>
<cfset i = 1>
<cfloop query="Offices">
<cfset var[#i#] = #OfficeName#>
<cfset i = i+1>
</cfloop>

<span class="blog-title">Sort by: Offices</span><br>
<cfloop index="i" from="1" to ="#Offices.recordcount#">
<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 02 APR 09 Change Start--->
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 4e783483-6327-47bd-8814-ce27719ec668 Variable Datasource name --->

SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE Offices LIKE '%#var[i]#%'
AND  Status = 'Active'
ORDER BY ID
<!---TODO_DV_CORP_002_End: 4e783483-6327-47bd-8814-ce27719ec668 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->

<!--- DV_CORP_002 02 APR 09 Change End--->
</cfquery>

<cfset Holder = "">
<cfoutput query="alerts">
<cfif Holder IS NOT "#var[i]#"><Br>
<cfIf Holder is NOT ""><br></cfif>
<u>#var[i]#</u><br>
</cfif>
 - <a href="alertView.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#</a><br>
<cfset Holder = "#var[i]#">
</cfoutput>
</cfloop>