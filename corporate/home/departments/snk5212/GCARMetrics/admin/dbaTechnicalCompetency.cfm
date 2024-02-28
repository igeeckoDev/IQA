<CFQUERY BLOCKFACTOR="100" NAME="TC" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSubType 
FROM GCAR_Metrics_New
WHERE CARTypeNew = 'Technical Competency Qualification & Assessment'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TC2" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARTypeNew = 'Technical Competency Qualification and Assessment'

WHERE 
CARTypeNew = 'Technical Competency Qualification & Assessment'
</cfquery>

<cfoutput>#TC.recordcount# records updated from CARTypeNew='Technical Competency Qualification & Assessment' to CARTypeNew='Technical Competency Qualification and Assessment'</cfoutput><br><br>