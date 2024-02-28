<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="DateFix" Datasource="UL06046_IN">
SELECT CAROpenDate, docID
FROM GCAR_METRICS_NEWIMPORT
ORDER BY docID
</cfquery>

<cfoutput query="DateFix">
#docID#<br>
#CAROpenDate#<br>
	<CFQUERY BLOCKFACTOR="100" NAME="CopyData" Datasource="UL06046">
	UPDATE GCAR_METRICS_NEWIMPORT
	SET
	CAROpenDate = #CreateODBCDate(CAROpenDate)#
	WHERE docID = '#docID#'
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" NAME="ViewFix" Datasource="UL06046_IN">
	SELECT CAROpenDate
	FROM GCAR_METRICS_NEWIMPORT
	WHERE docID = '#docID#'
	</cfquery>

#ViewFix.CAROpenDate#<br><br>
</cfoutput>