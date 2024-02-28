<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE ASContact
SET 
ASContact='#Form.ASContact#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="ASContact.cfm" ADDTOKEN="No">