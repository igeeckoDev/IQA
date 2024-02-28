<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE SME
SET
SME='#Form.SME#'
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="SME.cfm?var=Edit&value=#Form.SME#" ADDTOKEN="No">