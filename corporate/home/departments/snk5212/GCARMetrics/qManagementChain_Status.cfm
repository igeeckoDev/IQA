<cfquery name="qGetNames" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_METRICS_ManagementChain
SET STATUS
<cfif url.action eq "Reinstate">
	= NULL
<cfelseif url.action eq "Remove">
 = 'Removed'
</cfif>
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="qManagementChain_Modify.cfm" addtoken="No">