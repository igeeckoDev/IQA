<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE SME
SET
Status = NULL
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="SME.cfm?ID=#URL.ID#" ADDTOKEN="No">