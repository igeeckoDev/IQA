<!--- Start of Page File --->
<cfset subTitle = "Add a CAR Trend Report - Custom CAR Grouping">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">

<b>Category</b><br />
<cfoutput>#FunctionFieldName#</cfoutput><br><br />

<b>Value</b><br />
<cfoutput>#url.Function#</cfoutput><br><br>

<cfquery name="sortField" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, FunctionField as sortField, FunctionFieldName as SortFieldName
FROM GCAR_METRICS_CATEGORIES
WHERE FunctionField <> '#url.FunctionField#'
AND (FunctionField <> 'CARRootCauseCategory' AND FunctionField <> 'CARSource' AND FunctionField <> 'CARState')
ORDER BY ID
</cfquery>

Select how to sort the Customer Grouping <b><cfoutput>#url.Function#</cfoutput></b> in this report:<br><br />

Note: CAR Source, CAR State, and Root Cause Category graphs are included when you create a report, therefore they are not available options below.<br /><br />

<cfoutput query="sortField">
:: <a href="GroupReport_Confirm.cfm?ReportType=#URL.ReportType#&Group=Yes&FunctionField=#FunctionField#&Function=#url.Function#&sortField=#sortField#">#sortFieldName#</a><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->