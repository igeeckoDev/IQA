<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE FContact
SET 
FContact='#Form.FContact#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="FContacts.cfm" ADDTOKEN="No">