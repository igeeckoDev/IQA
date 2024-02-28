<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE CorporateFunctions
SET 
Function='#Form.CF#',
Owner='#Form.Owner#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="CF.cfm" ADDTOKEN="No">