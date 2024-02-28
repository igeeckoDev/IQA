<CFQUERY BLOCKFACTOR="100" NAME="SCC" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSource
FROM GCAR_Metrics_New
WHERE CARSource = 'SCC-IB (Canada Only)'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="SCCUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'SCC-IB'

WHERE 
CARSource = 'SCC-IB (Canada Only)'
</cfquery>

<cfoutput>#SCC.recordcount# records updated from CARSource='SCC-IB (Canada Only)' to CARSource='SCC-IB'</cfoutput><br><br>