<!--- DV_CORP_002 02-APR-09 --->
<cfquery name="KPAlerts" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 02 APR 09 Change Start--->
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d5c7a19d-edb3-4fd0-b4dc-97c197b234d2 Variable Datasource name --->

SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE Status = 'Active'
ORDER BY to_char(KP)
<!---TODO_DV_CORP_002_End: d5c7a19d-edb3-4fd0-b4dc-97c197b234d2 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->

<!--- DV_CORP_002 02 APR 09 Change End--->
</cfquery>

<span class="blog-title">Sort by: Key Processes</span><br><br>
<cfset KPholder = "">
<cfoutput query="KPAlerts">
<cfif KPHolder IS NOT KP>
<cfIf KPHolder is NOT ""><br></cfif>
<u>#KP#</u><br>
</cfif>
 - <a href="alertView.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#</a><br>
<cfset KPHolder = KP>
</cfoutput>