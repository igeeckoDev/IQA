<cfif url.ListItem neq "All">
	<cfset newList = #ListDeleteAt(url.List, url.ListItem)#>

    <cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE GCAR_METRICS_QREPORTS
    SET 
    Owner = '#newList#'
    WHERE ID = #URL.ID#
    </cfquery>
<cfelse>
    <cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE GCAR_METRICS_QREPORTS
    SET 
    Owner = NULL
    WHERE ID = #URL.ID#
    </cfquery>
</cfif>

<cflocation url="Report_ChangeOwner.cfm?ID=#URL.ID#" addtoken="no">