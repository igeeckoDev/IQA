<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM CorporateFunctions
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
INSERT INTO CorporateFunctions(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE CorporateFunctions
SET 
Function='#Form.CF#',
Owner='#Form.Owner#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="cf.cfm" addtoken="no">