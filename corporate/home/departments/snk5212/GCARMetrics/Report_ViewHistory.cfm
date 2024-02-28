<cfquery name="Function" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - <a href='Report_Details.cfm?ID=#URL.ID#'>#Function.Function#</a> - View History">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="History" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="History">
    <cfif len(History)>
	    #History#
    <cfelse>
    	No History
    </cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->