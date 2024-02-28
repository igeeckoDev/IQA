<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE LocalFunctions
SET 
Function='#Form.LF#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="LF.cfm" ADDTOKEN="No">