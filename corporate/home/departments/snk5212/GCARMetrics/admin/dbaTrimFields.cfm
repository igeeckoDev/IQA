<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARTypeNew, CARSubType, CARRootCauseCategory, CARType, docID, CARNumber 
FROM GCAR_Metrics_New
ORDER BY CARNumber
</cfquery>

<cfset i = 0>
<cfoutput query="InsertData">
<!---
A) GCAR_Metrics: #CARNumber# #docID# #len(CARSubType)# #len(CARTypeNEW)# #len(CARRootCauseCategory)#<br>
--->

	<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE GCAR_Metrics_New
	SET
	CARSubType = '#trim(CARSubType)#',
	CARTypeNEW = '#trim(CARTypeNew)#',
	CARRootCauseCategory = '#trim(CARRootCauseCategory)#',
	CARType = '#trim(CARType)#'
	
	WHERE CARNumber = '#CARNumber#'
	AND docID = '#docID#'
	</cfquery>
	
	<!---
	<CFQUERY BLOCKFACTOR="100" NAME="OutputData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM GCAR_Metrics
	WHERE CARNumber = '#CARNumber#'
	AND docID = '#docID#'
	</cfquery>

B) GCAR_Metrics: #outputData.CARNumber# #outputData.docID# #len(outputData.CARSubType)# #len(outputData.CARTypeNEW)# #len(outputData.CARRootCauseCategory)#<br><br>
	--->
<cfset i = i+1>
</cfoutput>

<cfoutput>
Trim Fields - #i# records reviewed.
</cfoutput>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=9" addtoken="no">