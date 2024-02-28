<cfset datex = createdate(2023, 01, 11)>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="setReadyValue" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update AuditSchedule_Planning_Status
	SET
	ReadyToPublishDate = #CreateODBCDate(datex)#,
	PublishDate = #CreateODBCDate(datex)#

	WHERE
	Year_ = 2023
	</cfquery>
	
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Output" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM AuditSchedule_Planning_Status
WHERE Year_ = 2023
</cfquery>
	
<cfdump var = "#output#">