<CFQUERY BLOCKFACTOR="100" NAME="GL" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSubType 
FROM GCAR_Metrics_New
WHERE CARSubType = 'Global labs'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="GlobalLabs" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSubType = 'Global Labs'

WHERE 
CARSubType = 'Global labs'
</cfquery>

<cfoutput>#GL.recordcount# records updated from CARSubType='Global labs' to CARSubType='Global Labs'</cfoutput><br><br>