<CFQUERY BLOCKFACTOR="100" NAME="Commercial" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSubType
FROM GCAR_Metrics_New
WHERE CARSubType = 'Commerical and Industrial - CO'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CommercialUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSubType = 'Commercial and Industrial - CO'

WHERE
CARSubType = 'Commerical and Industrial - CO'
</cfquery>

<cfoutput>#Commercial.recordcount# records updated from CARSubtype='Commerical and Industrial - CO' to CARSubType='Commercial and Industrial - CO'</cfoutput><br><br>