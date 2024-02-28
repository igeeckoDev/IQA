<CFQUERY BLOCKFACTOR="100" NAME="MMS" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSource
FROM GCAR_Metrics_New
WHERE CARSource = 'Health Canada-MMS'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="MMSUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSource = 'Health Canada - MMS'

WHERE 
CARSource = 'Health Canada-MMS'
</cfquery>

<cfoutput>#MMS.recordcount# records updated from CARSource='Health Canada-MMS' to CARSource='Health Canada - MMS'</cfoutput><br><br>