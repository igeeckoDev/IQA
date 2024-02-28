<CFQUERY BLOCKFACTOR="100" NAME="Reports" DataSource="Corporate">
	UPDATE AuditSchedule
	SET 
	GCAR = 1,
	GCARConfirmDate = '#curdate#'
	
	WHERE 
	Year = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER"> AND 
	ID = #url.ID#
</cfquery>

<cflocation url="ASReports_Details.cfm?#CGI.Query_String#" addtoken="No">