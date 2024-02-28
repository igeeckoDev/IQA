<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RD">
UPDATE RD
SET 
RD='#Form.RD#',
RDNumber='#Form.RDNumber#'

WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="KPRD.cfm" ADDTOKEN="No">