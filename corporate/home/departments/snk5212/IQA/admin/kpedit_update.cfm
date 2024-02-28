<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE KP
SET 
KP='#Form.KP#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="addKP.cfm" ADDTOKEN="No">