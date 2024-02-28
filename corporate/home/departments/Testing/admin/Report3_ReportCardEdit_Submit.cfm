<cfdump var="#Form#">

<cfoutput>
	<cfloop index=i from="1" to="6">

	<!--- APPROACH --->
	<Cfset CriteriaType = "Approach">

		<cfset NotesField = replace(evaluate("Form.AreaID#i#_Approach_Notes"), "'", "''", "All")>

		<!--- update row with rating, critiera type, and comments --->
		<!---Field: Form.AreaID#i#_Approach_Rating--->
		<CFQUERY BLOCKFACTOR="100" name="updateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE ProgramReportCard_Report3
		SET
		Rating = #evaluate("Form.AreaID#i#_Approach_Rating")#,
		Comments = '#NotesField#'
		WHERE ID = #URL.ID#
		AND Year_ = #URL.Year#
		AND AreaID = #i#
		AND CriteriaType = 'Approach'
		</cfquery>

	<!--- EFFECTIVENESS --->
	<Cfset CriteriaType = "Effectiveness">

	<cfset NotesField = replace(evaluate("Form.AreaID#i#_Effectiveness_Notes"), "'", "''", "All")>

		<CFQUERY BLOCKFACTOR="100" name="updateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE ProgramReportCard_Report3
		SET
		Rating = #evaluate("Form.AreaID#i#_Effectiveness_Rating")#,
		Comments = '#NotesField#'
		WHERE ID = #URL.ID#
		AND Year_ = #URL.Year#
		AND AreaID = #i#
		AND CriteriaType = 'Effectiveness'
		</cfquery>
	</cfloop>

	<!--- add report to chart output table --->
	<!--- get max id +1 from table --->
	<CFQUERY BLOCKFACTOR="100" name="getNewID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT MAX(ID)+1 newID
	from ProgramReportCard_Output
	</cfquery>

	<cfloop index=i from="1" to="6">
		<!--- add rID to table (new row) + audit year, id, and auditedby --->
		<CFQUERY BLOCKFACTOR="100" name="addRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE ProgramReportCard_Output
		SET
		xAxis = #evaluate("Form.AreaID#i#_Approach_Rating")#,
		yAxis = #evaluate("Form.AreaID#i#_Effectiveness_Rating")#
		WHERE ID = #URL.ID#
		AND Year_ = #URL.Year#
		AND AreaID = #i#
		</cfquery>
	</cfloop>

	<cflocation url="Report_Edit4New.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=IQA" addtoken="no">
</cfoutput>