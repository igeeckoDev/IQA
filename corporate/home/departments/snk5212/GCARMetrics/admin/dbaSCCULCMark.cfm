<CFQUERY BLOCKFACTOR="100" NAME="SCC" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSource
FROM GCAR_Metrics_New
WHERE CARSource LIKE 'SCC-ULC%' AND CARSource <> 'SCC-ULC Mark'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="SCCUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'SCC-ULC Mark'

WHERE
CARSource LIKE 'SCC-ULC%' AND CARSource <> 'SCC-ULC Mark'
</cfquery>

<cfoutput>#SCC.recordcount# records updated from CARSource='SCC-ULC Mark (Canada Only)/SCC-ULC (Canada Only)' to CARSource='SCC-ULC Mark'</cfoutput><br><br>