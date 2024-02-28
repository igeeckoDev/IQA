<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
UPDATE GlobalFunctions
SET
Status = 'removed'
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="gf.cfm?ID=#URL.ID#" ADDTOKEN="No">