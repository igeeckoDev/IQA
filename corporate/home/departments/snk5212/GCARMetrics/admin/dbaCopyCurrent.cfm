<CFQUERY BLOCKFACTOR="100" NAME="CopyTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
CREATE TABLE GCAR_METRICS_NEW AS SELECT * FROM GCAR_METRICS_TEMPLATE WHERE 1=2
</CFQUERY>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=2" addtoken="no">