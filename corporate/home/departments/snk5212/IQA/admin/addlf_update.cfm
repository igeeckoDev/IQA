<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM LocalFunctions
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO LocalFunctions(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE LocalFunctions
SET 
Function='#Form.LF#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="LF.cfm" addtoken="no">