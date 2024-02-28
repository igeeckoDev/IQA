<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RDID">
SELECT MAX(ID) + 1 AS newid FROM RD
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RDIDAdd">
INSERT INTO RD(ID, KPID)
VALUES (#RDID.newid#, '#Form.KPID#')
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddRD">
UPDATE RD
SET 
RD='#Form.RD#',
RDNumber='#Form.RDNumber#'
WHERE ID=#RDID.newid#
</CFQUERY>

<cflocation url="KPRD.cfm" addtoken="no">