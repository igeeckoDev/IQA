<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE Accreditors
SET 
Accreditor='#Form.Accred#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="Accred.cfm" addtoken="no">