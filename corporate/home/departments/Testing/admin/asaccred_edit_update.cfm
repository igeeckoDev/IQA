<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE ASAccreditors
SET 
Accreditor='#Form.Accred#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="ASAccred.cfm?msg=edit&ID=#URL.ID#" ADDTOKEN="No">