<CFQUERY BLOCKFACTOR="100" NAME="SM" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSubType
FROM GCAR_Metrics_New
WHERE CARSubType = 'Sales and Mktg' 
OR CARSubType = 'Sales & Mktg'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="SMUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSubType = 'Sales and Marketing'

WHERE CARSubType = 'Sales and Mktg' 
OR CARSubType = 'Sales & Mktg'
</cfquery>

<cfoutput>#SM.recordcount# records updated from CARSubType = 'Sales & Mktg' / 'Sales and Mktg' to 'Sales and Marketing'</cfoutput><br><br>