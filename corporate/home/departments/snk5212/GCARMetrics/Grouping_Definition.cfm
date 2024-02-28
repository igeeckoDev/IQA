<cfset FunctionField = "#url.groupType#">

<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariables_Report.cfm">

<!--- Start of Page File --->
<cfset subTitle = "#FunctionFieldName# Grouping Definition - #url.groupName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ItemName 
FROM GCAR_Metrics_Function_Grouping
WHERE GroupName = '#url.groupName#'
AND groupType = '#url.groupType#'
ORDER BY ItemName
</cfquery>

<cfset setQueryString = "&Group=Yes&Manager=None&View=All&Type=All&Program=null&showPerf=No">

<cfset FunctionField = "#url.groupType#">

<cfoutput>
<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariables_Report.cfm">

<b>Group Name</b>: #url.groupName#<Br />
<b>Grouping Type</b>: #FunctionFieldName# items<br /><br />
</cfoutput>

<u>Included Items:</u><br />
<cfoutput query="getItems">
 - #ItemName#<br />
</cfoutput><br /><br />

<hr class='dash'><br />

<cfoutput>
<b>Quick Links</b><br />
:: <a href="qManager.cfm?groupName=#url.groupName#&var=#url.groupType##setQueryString#">View CARs</a> for this Grouping<br />
:: <a href="qGroup_Select.cfm">Custom CAR</a> Groupings Index<br />
:: <a href="index.cfm">GCAR Metrics Home</a><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->