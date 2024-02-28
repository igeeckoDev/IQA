<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBTopicsID">
SELECT MAX(ID) + 1 AS newid FROM KBTopics
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBTopicsIDAdd">
INSERT INTO KBTopics(ID)
VALUES (#KBTopicsID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKB">
UPDATE KBTopics
SET 
KBTopics='#Form.KBTopics#'
WHERE ID=#KBTopicsID.newid#
</CFQUERY>

<cflocation url="addKBTopic.cfm" addtoken="no">