<cfoutput>
	<cfset completedDate = #now()#>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Records" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE xSNAPData
SET 
Status = 'Complete',
CompletedDate = #completedDate#
WHERE 
AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Records" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
ORDER BY FunctionType DESC, FunctionType2
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="selOffice">
SELECT OfficeName, ID
FROM IQAtblOffices
WHERE ID = #Records.AuditOfficeNameID#
</cfquery>

<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#&Complete=Yes" addtoken="no">