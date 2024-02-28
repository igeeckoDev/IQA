<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "<a href='Report.cfm'>CAR Trend Reports</a> - Delete Report">

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
Do you want to delete this CAR Trend Report?<br />
    
<a href="Report_Delete_Submit.cfm?ID=#URL.ID#"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Delete Report" /></a> <a href="Report_Delete_Submit.cfm?ID=#URL.ID#">Delete Report</a><br />
    
<a href="Report_Details.cfm?ID=#URL.ID#"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_cross.png" border="0" alt="Cancel Delete" /></a> <a href="Report_Details.cfm?ID=#URL.ID#">Cancel</a><br />
</cfoutput><br>

Note: You can reinstate this Report in the future by visiting the <a href="Report_ShowDeleted.cfm">Deleted Reports</a> page.<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->