<cfoutput>
	<!--- add for report data --->

	<!--- get max id +1 from table --->
	<CFQUERY BLOCKFACTOR="100" name="getNewID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT MAX(rID)+1 newID
	from ProgramReportCard_Report3
	</cfquery>

	<cfif NOT isDefined("getNewID.newID") OR NOT len(getNewID.newID)>
		<cfset j = 1>
	<cfelse>
		<cfset j = getNewID.newID>
	</cfif>

	<cfloop index=i from="1" to="6">
		<!--- APPROACH --->
		<Cfset CriteriaType = "Approach">

		<!--- add rID to table (new row) + audit year, id, and auditedby --->
		<CFQUERY BLOCKFACTOR="100" name="addRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO ProgramReportCard_Report3(rID, ID, Year_, AuditedBy, CriteriaType, AreaID)
		VALUES(#j#, #URL.ID#, #URL.Year#, 'IQA', '#CriteriaType#', #i#)
		</cfquery>

		<cfset NotesField = replace(evaluate("Form.AreaID#i#_Approach_Notes"), "'", "''", "All")>

		<!--- update row "where rID = getNewID.newid" with rating, critiera type, and comments --->
		<!---Field: Form.AreaID#i#_Approach_Rating--->
		<CFQUERY BLOCKFACTOR="100" name="updateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE ProgramReportCard_Report3
		SET
		Rating = #evaluate("Form.AreaID#i#_Approach_Rating")#,
		Comments = '#NotesField#'
		WHERE rID = #j#
		</cfquery>

		<!--- new rowID --->
		<Cfset j = j+1>

		<!--- EFFECTIVENESS --->
		<Cfset CriteriaType = "Effectiveness">

		<!--- add rID to table (new row) + audit year, id, and auditedby --->
		<CFQUERY BLOCKFACTOR="100" name="addRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO ProgramReportCard_Report3(rID, ID, Year_, AuditedBy, CriteriaType, AreaID)
		VALUES(#j#, #URL.ID#, #URL.Year#, 'IQA', '#CriteriaType#', #i#)
		</cfquery>

		<cfset NotesField = replace(evaluate("Form.AreaID#i#_Effectiveness_Notes"), "'", "''", "All")>

		<!--- update row "where rID = getNewID.newid" with rating, critiera type, and comments --->
		<!---Field: Form.AreaID#i#_Approach_Rating--->
		<CFQUERY BLOCKFACTOR="100" name="updateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE ProgramReportCard_Report3
		SET
		Rating = #evaluate("Form.AreaID#i#_Effectiveness_Rating")#,
		Comments = '#NotesField#'
		WHERE rID = #j#
		</cfquery>

		<!--- new rowID --->
		<cfset j = j+1>
	</cfloop>

	<!--- add report to chart output table --->
	<!--- get max id +1 from table --->
	<CFQUERY BLOCKFACTOR="100" name="getNewID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT MAX(rID)+1 newID
	from ProgramReportCard_Output
	</cfquery>

	<cfif NOT isDefined("getNewID.newID") OR NOT len(getNewID.newID)>
		<cfset k = 1>
	<cfelse>
		<cfset k = getNewID.newID>
	</cfif>

	<cfloop index=i from="1" to="6">
		<!--- add rID to table (new row) + audit year, id, and auditedby --->
		<CFQUERY BLOCKFACTOR="100" name="addRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO ProgramReportCard_Output(rID, ID, Year_, AuditedBy, AreaID, xAxis, yAxis)
		VALUES(#k#, #URL.ID#, #URL.Year#, 'IQA', #i#, #evaluate("Form.AreaID#i#_Approach_Rating")#, #evaluate("Form.AreaID#i#_Effectiveness_Rating")#)
		</cfquery>

		<cfset k = k+1>
	</cfloop>

<cfif isDefined("URL.Report4") AND URL.Report4 eq "Edit">
	<cflocation url="Report_Edit4.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=IQA" addtoken="no">
<Cfelse>
	<cflocation url="Report4new.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=IQA" addtoken="no">
</cfif>
</cfoutput>