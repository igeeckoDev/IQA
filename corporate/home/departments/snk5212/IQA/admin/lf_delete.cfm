<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
DELETE FROM LocalFunctions
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="lf.cfm?ID=#URL.ID#" ADDTOKEN="No">