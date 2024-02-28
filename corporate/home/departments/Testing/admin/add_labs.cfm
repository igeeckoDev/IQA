<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(LabID) + 1 AS newid FROM IQAOffices_Areas
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
SELECT * FROM IQAtblOffices
WHERE ID = #URL.OfficeName#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
INSERT INTO IQAOffices_Areas(LabID,ID,Lab, IQA, LTA)
VALUES (#ID.newid#,#Add.ID#,'#Form.Lab#', 1, 0)
</CFQUERY>

<cflocation url="labs.cfm?OfficeName=#URL.OfficeName#" addtoken="no">