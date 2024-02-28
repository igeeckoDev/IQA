<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Change Quantity of Top Items Shown Bar Graph">

<cfinclude template="shared/incVariables_Report.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit")>

<cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_METRICS_QREPORTS
SET 

<cfif url.sortField EQ "CARSource">
	TopItems_CARSource = #Form.ItemSelect#
<cfelseif url.sortField EQ "CARRootCauseCategory">
	TopItems_CARRootCauseCategory = #Form.ItemSelect#
<cfelse>
	TopItems = #Form.ItemSelect#
</cfif>

WHERE ID = #URL.ID#
</cfquery>

<cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField, TopItems, SortField, TopItems_CARSource, TopItems_CARRootCauseCategory
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cfif url.sortField EQ "CARSource">
	<Cfset topValue = #Report.TopItems_CARSource#>
<cfelseif url.sortField EQ "CARRootCauseCategory">
	<Cfset topValue = #Report.TopItems_CARRootCauseCategory#>
<cfelse>
	<Cfset topValue = #Report.TopItems#>
</cfif>

<cflocation url="Report_Graph.cfm?format=flash&sortField=#url.sortField#&FunctionField=#Report.FunctionField#&Function=#Report.Function#&top=#topValue#&ID=#URL.ID#" addtoken="no">

<cfelse>

<cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField, TopItems, SortField, TopItems_CARSource, TopItems_CARRootCauseCategory
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="Report">
	<b>Graph Name</b><br>
   	#Function# CARs by #SortFieldName#<Br><br>
	
    <b>Current Top Items Value</b><br>
    <cfif url.sortField EQ "CARSource">
    	#TopItems_CARSource#
    <cfelseif url.sortField EQ "CARRootCauseCategory">
    	#TopItems_CARRootCauseCategory#
    <cfelse>
    	#TopItems#
    </cfif><br><br>
    
    <cfform action="#cgi.script_name#?#cgi.query_string#" name="form" method="post">
    <b>New Top Items Value</b><Br>
    <SELECT NAME="ItemSelect">
    <cfloop index="i" from="1" to="10">
            <OPTION VALUE="#i#">#i#</OPTION>
    </cfloop>
    </SELECT><Br><br>
    
    <input type="Submit" name="Submit" Value="Save Top Item Value" />
    </cfform>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->