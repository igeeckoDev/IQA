<CFQUERY BLOCKFACTOR="100" NAME="Find" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARStandardNumber 
FROM GCAR_Metrics_New
WHERE CARStandardNumber = 'ISO/IEC GUIDE 65'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Update" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARStandardNumber = 'ISO/IEC GUIDE 65'

WHERE 
CARStandardNumber = 'ISO Guide 65'
</cfquery>

<cfoutput>#Find.recordcount# records updated from CARStandardNumber='ISO/IEC GUIDE 65' to='ISO Guide 65'</cfoutput><br><br>