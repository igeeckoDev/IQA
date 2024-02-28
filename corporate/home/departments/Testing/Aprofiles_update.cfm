<CFQUERY BLOCKFACTOR="100" NAME="UpdateAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

Comments=<CFQUERYPARAM VALUE="#Form.Comments#" CFSQLTYPE="CF_SQL_CLOB">,
Expertise=<CFQUERYPARAM VALUE="#Form.Expertise#" CFSQLTYPE="CF_SQL_CLOB">,
Training=<CFQUERYPARAM VALUE="#Form.Training#" CFSQLTYPE="CF_SQL_CLOB">

WHERE ID=#URL.ID#
</CFQUERY>

<cflocation url="Aprofiles_detail.cfm?ID=#URL.ID#" ADDTOKEN="No">