<CFQUERY BLOCKFACTOR="100" NAME="Fix" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARProgramAffected
FROM GCAR_Metrics_New
WHERE CARProgramAffected LIKE 'Ministry of Health|Labor and Welfare (MHLW)%'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="FixUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARProgramAffected = 'Ministry of Health|Labor and Welfare (MHLW) - PAL'

WHERE CARProgramAffected LIKE '%Ministry of Health|Labor and Welfare (MHLW)%'
</cfquery>

<cfoutput>#Fix.recordcount# records (for MHLW) updated EM Dash to En Dash</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Fix2" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARProgramAffected
FROM GCAR_Metrics_New
WHERE CARSource LIKE '%PSE'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="FixUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'NITE - PSE'

WHERE CARSource LIKE '%PSE'
</cfquery>

<cfoutput>#Fix2.recordcount# records (for NITE - PSE) updated EM Dash to En Dash</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Fix3" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARProgramAffected
FROM GCAR_Metrics_New
WHERE CARSource LIKE '%PSC'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="FixUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'NITE - PSC'

WHERE CARSource LIKE '%PSC'
</cfquery>

<cfoutput>#Fix3.recordcount# records (for NITE - PSC) updated EM Dash to En Dash</cfoutput><br><br>