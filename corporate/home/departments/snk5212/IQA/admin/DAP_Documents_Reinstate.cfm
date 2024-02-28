<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
	DAP_Documents
SET
	Status = NULL
WHERE
	ID = #URL.ID#
</cfquery>

<cflocation url="DAP_Documents.cfm" addtoken="No">