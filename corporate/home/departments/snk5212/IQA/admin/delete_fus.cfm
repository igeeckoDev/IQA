<cfif url.action eq "remove">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Status">
    UPDATE FUSAreas
    SET Status = 'removed'
    WHERE ID = #url.id#
    </CFQUERY>
<cfelseif url.action eq "reinstate">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Status">
    UPDATE FUSAreas
    SET Status = NULL
    WHERE ID = #url.id#
    </CFQUERY>
</cfif>

<cflocation url="FUS2.cfm?msg=#URL.action#&id=#URL.ID#" ADDTOKEN="No">