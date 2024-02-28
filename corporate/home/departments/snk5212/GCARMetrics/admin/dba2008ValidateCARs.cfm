<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="query" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT GCAR_Metrics_New.CARNumber, GCAR_Metrics_New.docID, GCAR_2008Data.CARNumber as CARNumber08, GCAR_2008Data.docID as docID08
FROM GCAR_Metrics_New

FULL JOIN GCAR_2008Data
ON 
GCAR_Metrics_New.docID = GCAR_2008Data.docID 
AND GCAR_Metrics_New.CARNumber = GCAR_2008Data.CARNumber

WHERE GCAR_Metrics_New.CARNumber LIKE '08%'

ORDER BY GCAR_Metrics_New.CARNumber
</cfquery>

<cfdump var="#query#">