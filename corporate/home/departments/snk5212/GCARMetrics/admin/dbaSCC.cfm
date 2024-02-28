<CFQUERY BLOCKFACTOR="100" NAME="SCC" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSource
FROM GCAR_Metrics_New
WHERE CARSource = 'SCC(Standards Council of Canada)'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="SCCUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'SCC'

WHERE 
CARSource = 'SCC(Standards Council of Canada)'
</cfquery>

<cfoutput>#SCC.recordcount# records updated from CARSource='SCC(Standards Council of Canada)' to CARSource='SCC'</cfoutput><br><br>