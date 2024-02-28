<CFQUERY BLOCKFACTOR="100" NAME="Radio" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARProgramAffected
FROM GCAR_Metrics_New
WHERE 
CARProgramAffected LIKE '%Anaylsis & Inspection%'
</cfquery>

<cfoutput query="Radio">
#CARNumber#<br>

<cfset newString = #replace(CARProgramAffected, "Anaylsis & Inspection", "Analysis and Inspection", "All")#>

	<CFQUERY BLOCKFACTOR="100" NAME="TC2" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update GCAR_Metrics_New
	SET
	CARProgramAffected = '#newString#'
	
	WHERE 
	CARNumber = '#CARNumber#'
	</cfquery>
</cfoutput>