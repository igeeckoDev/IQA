<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE GlobalFunctions
SET 
Owner='#Form.Owner#'
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="GF.cfm?var=Edit&value=#Form.GF#" ADDTOKEN="No">