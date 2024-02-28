<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE QRSAuditor
SET 
Auditor='#Form.Auditor#'
WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="aqrs.cfm" ADDTOKEN="No">