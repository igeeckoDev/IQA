<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
UPDATE ASAccreditors
SET Status = 'remove'
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="ASaccred.cfm?msg=remove&id=#url.id#" ADDTOKEN="No">