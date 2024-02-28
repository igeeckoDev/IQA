<CFQUERY BLOCKFACTOR="100" NAME="AllNoneFix" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARProgramAffected
FROM GCAR_Metrics_New
WHERE 
CARProgramAffected LIKE 'All%' 
OR CARProgramAffected LIKE 'N/A%'
OR CARProgramAffected LIKE 'None%'
</cfquery>

<cfoutput query="AllNoneFix">
#CARNumber#<br>

	<CFQUERY BLOCKFACTOR="100" NAME="Update" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update GCAR_Metrics_New
	SET
	CARProgramAffected = 'Process Concern'
	
	WHERE 
	CARNumber = '#CARNumber#'
	</cfquery>
</cfoutput>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=8" addtoken="no">