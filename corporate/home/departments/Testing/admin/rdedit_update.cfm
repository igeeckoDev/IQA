<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE RD
SET 
KP='#Form.RD#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="addRD.cfm" addtoken="no">