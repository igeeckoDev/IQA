<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE IQAtbloffices
SET 
QRS='#Form.QRS#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="contacts.cfm?ID=#URL.ID#" addtoken="no">