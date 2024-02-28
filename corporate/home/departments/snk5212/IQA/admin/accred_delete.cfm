<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
UPDATE Accreditors
SET Status = 'remove'
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="accred.cfm?msg=remove&id=#url.id#" addtoken="no">