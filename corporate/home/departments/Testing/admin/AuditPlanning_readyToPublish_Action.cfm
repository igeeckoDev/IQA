<cfif URL.Action eq "Ready">
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="setReadyValue" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update AuditSchedule_Planning_Status
	SET
	ReadyToPublish = 'Yes',
	ReadyToPublishDate = #CreateODBCDate(form.ReadyToPublishDate)#,
	ReadyToPublishUser = '#Form.ReadyToPublishUser#'

	WHERE
	Year_ = #URL.Year#
	</cfquery>
<cfelseif URL.ACtion eq "Undo">
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="setReadyValue" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update AuditSchedule_Planning_Status
	SET
	ReadyToPublish = null,
	ReadyToPublishDate = null,
	ReadyToPublishUser = null

	WHERE
	Year_ = #URL.Year#
	</cfquery>
</cfif>

<cflocation url="AuditPlanning.cfm?Year=#URL.Year#" addtoken="No">