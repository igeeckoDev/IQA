<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN CARHistory
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN ResponseAcceptanceDate_delete
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN Sort_Clause
</CFQUERY>
--->

<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN ResponseAcceptanceDate_delete2
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN ResponseAcceptanceDate
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN CARCHKREPEAT
</CFQUERY>
--->

<CFQUERY BLOCKFACTOR="100" NAME="DeleteNullRows" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
DELETE FROM UL06046.GCAR_Metrics_NewImport
WHERE docID IS NULL
</CFQUERY>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=1" addtoken="no">