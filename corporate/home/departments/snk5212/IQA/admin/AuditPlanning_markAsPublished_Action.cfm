<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="setReadyValue" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update AuditSchedule_Planning_Status
	SET
	PublishStatus = 'Yes',
	PublishDate = #CreateODBCDate(form.PublishDate)#,
	PublishUser = '#Form.PublishUser#'

	WHERE
	Year_ = #URL.Year#
</cfquery>

<cflocation url="AuditPlanning.cfm?Year=#URL.Year#" addtoken="No">