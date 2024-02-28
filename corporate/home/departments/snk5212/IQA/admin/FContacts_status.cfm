<cfif url.status is "Active">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
    UPDATE FContact
    SET
    Status IS NULL
    WHERE ID = #URL.ID#
    </CFQUERY>
<cfelseif url.status is "Remove">
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
    UPDATE FContact
    SET
    Status = 'removed'
    WHERE ID = #URL.ID#
    </CFQUERY>
</cfif>

<cflocation url="FContacts.cfm?msg=remove&id=#url.id#&name=#url.name#" ADDTOKEN="No">