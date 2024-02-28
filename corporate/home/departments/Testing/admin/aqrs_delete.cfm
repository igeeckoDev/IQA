<CFQUERY BLOCKFACTOR="100" NAME="Remove" Datasource="Corporate">
	DELETE FROM QRSAuditor
	WHERE ID = #URL.ID#
</cfquery>

<cflocation url="aqrs.cfm" ADDTOKEN="No">