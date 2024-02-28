<cfif url.ListItem neq "All">
	<cfset newList = #ListDeleteAt(url.List, url.ListItem)#>

    <cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE GCAR_METRICS_QREPORTS
    SET 
    CC = '#newList#'
    WHERE ID = #URL.ID#
    </cfquery>
<cfelse>
    <cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE GCAR_METRICS_QREPORTS
    SET 
    CC = NULL
    WHERE ID = #URL.ID#
    </cfquery>
</cfif>

<cflocation url="Report_ChangeFYI.cfm?ID=#URL.ID#" addtoken="no">