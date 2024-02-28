<!--- DV_CORP_002 02-APR-09 --->
<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
<!--- DV_CORP_002 02 APR 09 Change Start--->
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 31428600-448a-48b3-8850-cd9ebd15cfd1 Variable Datasource name --->

SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE Status = 'Active'
ORDER BY to_char(SC)

<!---TODO_DV_CORP_002_End: 31428600-448a-48b3-8850-cd9ebd15cfd1 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->

<!--- DV_CORP_002 02 APR 09 Change End--->
</cfquery>

<span class="blog-title">Sort by: Standard Categories</span><br><br>
<cfset holder = "">
<cfoutput query="Alerts">
<cfif Holder IS NOT SC>
<cfIf Holder is NOT ""><br></cfif>
<u>#SC#</u><br>
</cfif>
 - <a href="alertView.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#</a><br>
<cfset Holder = SC>
</cfoutput>