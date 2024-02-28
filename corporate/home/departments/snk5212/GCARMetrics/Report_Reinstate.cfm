<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "<a href='Report.cfm'>CAR Trend Reports</a> - Reinstate Report">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="Reports" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, sortField, ReportType
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="Reports">
<cfinclude template="shared/incVariables_Report.cfm">
Details: <b>#Function#</b> (by #sortFieldName#)<br />
Owner: #ReportType#<br><br>
</cfoutput>

<cfoutput>
Do you want to reinstate this CAR Trend Report?<br />
    
<a href="Report_Reinstate_Submit.cfm?ID=#URL.ID#"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Reinstate Report" /></a> <a href="Report_Reinstate_Submit.cfm?ID=#URL.ID#">Reinstate Report</a><br />
    
<a href="Report_Details.cfm?ID=#URL.ID#"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_cross.png" border="0" alt="Cancel Delete" /></a> <a href="Report_Details.cfm?ID=#URL.ID#">Cancel</a><br /><br>

Note: You can Delete this Report in the future by visiting the <a href="Report_Details.cfm?ID=#ID#">Report Details</a> page.<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->