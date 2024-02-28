<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM QRSAuditor
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO QRSAuditor(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE QRSAuditor
SET 
Auditor='#Form.Auditor#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="aqrs.cfm" addtoken="no">