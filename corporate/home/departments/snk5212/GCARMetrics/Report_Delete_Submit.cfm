<cfquery name="ReportSetStatus" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_METRICS_QREPORTS
SET
STATUS = 'Removed'
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="Report_Details.cfm?ID=#URL.ID#&Deleted=Yes" addtoken="No">