<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KPID">
SELECT MAX(ID) + 1 AS newid FROM KP
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KPIDAdd">
INSERT INTO KP(ID)
VALUES (#KPID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKP">
UPDATE KP
SET 
KP='#Form.KP#'
WHERE ID=#KPID.newid#
</CFQUERY>

<cflocation url="addKP.cfm" addtoken="no">