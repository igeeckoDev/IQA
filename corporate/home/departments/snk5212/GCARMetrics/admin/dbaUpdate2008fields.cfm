<cfsetting requesttimeout="600">

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM GCAR_2008Data
WHERE CARNumber LIKE '08%'
ORDER BY CARNumber
</cfquery>

<cfoutput query="InsertData">
GCAR_2008Data: #CARNumber# #docID# #CARSubType# #CARTypeNEW# #CARRootCauseCategory#<br>
	<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE GCAR_Metrics_New
	SET
	CARSubType = '#trim(CARSubType)#',
	CARTypeNEW = '#trim(CARTypeNew)#',
	CARRootCauseCategory = '#trim(CARRootCauseCategory)#'
	
	WHERE CARNumber = '#CARNumber#'
	AND docID = '#docID#'
	</cfquery>
	
	<CFQUERY BLOCKFACTOR="100" NAME="OutputData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM GCAR_Metrics_New
	WHERE CARNumber = '#CARNumber#'
	AND docID = '#docID#'
	</cfquery>

	GCAR_Metrics: #outputData.CARNumber# #outputData.docID# #outputData.CARSubType# #outputData.CARTypeNEW# #outputData.CARRootCauseCategory#<br><br>
</cfoutput>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=5" addtoken="no">