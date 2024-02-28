<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
DELETE FROM RD
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="addrd.cfm?ID=#URL.ID#" addtoken="no">