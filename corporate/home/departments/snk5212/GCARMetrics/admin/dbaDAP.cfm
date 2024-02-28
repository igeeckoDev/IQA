<CFQUERY BLOCKFACTOR="100" NAME="DAP" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSource
FROM GCAR_Metrics_New
WHERE CARSource = 'DAP-Internal Only'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="DAPUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'DAP - Internal Only'

WHERE 
CARSource = 'DAP-Internal Only'
</cfquery>

<cfoutput>#DAP.recordcount# records updated from CARSource='DAP-Internal Only' to CARSource='DAP - Internal Only'</cfoutput><br><br>