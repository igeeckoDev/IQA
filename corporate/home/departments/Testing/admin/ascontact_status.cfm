<cfif url.status eq "Active">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
    UPDATE ASContact
    SET Status = NULL
    WHERE ID = #URL.ID#
	</CFQUERY>
<cfelseif url.status eq "Inactive">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
    UPDATE ASContact
    SET Status = 'Inactive'
    WHERE ID = #URL.ID#
	</CFQUERY>
</cfif>

<cflocation url="ASContact.cfm?msg=#url.status#&id=#url.id#" ADDTOKEN="No">