<CFQUERY BLOCKFACTOR="100" name="DAPClient" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ClientName
FROM DAPClient
WHERE ID = #URL.rowID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=DAPClientList.cfm?Order=DA&Status=Active>DAP Client List</a> - <a href=DAPClientList_Details.cfm?rowID=#URL.rowID#>DAP Client Details</a> (#DAPClient.ClientName#) - Add DAP Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" name="Auditors" Datasource="Corporate">
SELECT Auditor
FROM AuditorList
WHERE DAPAuditor = 'Yes'
ORDER BY Auditor
</cfquery>

<cfif structKeyExists(form,'submit')>
	<!--- xGUID --->
	<CFQUERY BLOCKFACTOR="100" name="newRowID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT MAX(xGUID)+1 as xGUID FROM DAP_AuditSchedule
	</cfquery>

	<!--- check for audits in URL.Year to determine the ID--->
	<CFQUERY BLOCKFACTOR="100" name="yearCheck" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM DAP_AuditSchedule WHERE Year_ = #Form.Year#
	</cfquery>

	<cfif yearCheck.recordCount eq 0>
		<CFQUERY BLOCKFACTOR="100" name="insertRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO DAP_AuditSchedule(xGUID, ID, Year_)
		VALUES(#newRowID.xGUID#, 1, #form.Year#)
		</cfquery>
	<cfelse>
		<CFQUERY BLOCKFACTOR="100" name="newID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT MAX(ID)+1 as newID FROM DAP_AuditSchedule WHERE Year_ = #Form.Year#
		</cfquery>

		<CFQUERY BLOCKFACTOR="100" name="insertRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO DAP_AuditSchedule(xGUID, ID, Year_)
		VALUES(#newRowID.xGUID#, #newID.newID#, #form.Year#)
		</cfquery>
	</cfif>

	<cflock scope="Session" timeout="5">
	<cfif isDefined("Form.StartDate") AND isDefined("Form.EndDate")>
		<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>
	</cfif>

		<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE DAP_AuditSchedule
		SET
		<cfif NOT len(Form.StartDate) AND NOT len(Form.EndDate)>
		    StartDate=null,
		    EndDate=null,
		    Month=#form.month#,
		<cfelseif len(Form.StartDate) AND NOT len(Form.EndDate)>
			StartDate=#CreateODBCDate(FORM.StartDate)#,
			EndDate=#CreateODBCDate(FORM.StartDate)#,
			<cfset m = #DateFormat(CreateODBCDate(Form.StartDate), 'mm')#>
			Month='#m#',
		<cfelseif len(Form.Startdate) AND len(Form.EndDate)>
			<cfif CompareDate eq -1>
				StartDate=#CreateODBCDate(FORM.StartDate)#,
				EndDate=#CreateODBCDate(FORM.EndDate)#,
				<cfset m = #DateFormat(CreateODBCDate(Form.StartDate), 'mm')#>
				Month='#m#',
			<cfelseif CompareDate eq 0>
				StartDate=#CreateODBCDate(FORM.StartDate)#,
				EndDate=#CreateODBCDate(FORM.EndDate)#,
				<cfset m = #DateFormat(CreateODBCDate(Form.StartDate), 'mm')#>
				Month='#m#',
			<cfelseif CompareDate eq 1>
				StartDate=#CreateODBCDate(FORM.EndDate)#,
				EndDate=#CreateODBCDate(FORM.StartDate)#,
				<cfset m = #DateFormat(CreateODBCDate(Form.EndDate), 'mm')#>
				Month='#m#',
			</cfif>
		<cfelseif NOT len(Form.Startdate) AND len(Form.EndDate)>
			StartDate=#CreateODBCDate(FORM.EndDate)#,
			EndDate=#CreateODBCDate(FORM.EndDate)#,
			<cfset m = #DateFormat(CreateODBCDate(Form.EndDate), 'mm')#>
			Month='#m#',
		</cfif>
		AuditDays = #Form.AuditDays#,
		Approved = 'Yes',
		AuditType = 'Data Acceptance Program (DAP)',
		AuditType2 = '#Form.AuditType2#',
		LeadAuditor = '#Form.LeadAuditor#',
		Notes = '#Form.Notes#',
		AdminNotes = '#Form.AdminNotes#',
		DAPClient_ID = #URL.rowID#,
		History = 'Audit Added on #curdate# #curtime# by #SESSION.Auth.UserName#'

		WHERE xGUID = #newRowID.xGUID#
		</cfquery>
	</cflock>

	<cflocation url="DAPAudit_Details.cfm?rowID=#newRowID.xGUID#" addtoken="no">
<cfelse>
	<cfFORM  method ="post" id="myform" name="myform" ACTION="#CGI.ScriptName#?#CGI.Query_String#">

	<CFQUERY BLOCKFACTOR="100" name="DAPClient" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM DAPClient
	WHERE ID = #URL.rowID#
	</cfquery>

	<cfoutput query="DAPClient">
	<b>Client Name</b><br>
	#ClientName#<br><br>

	<b>DA File Number</b><br>
	#DAFileNumber#<br><br>
	</cfoutput>

	<cfset yearMax = curyear + 2>

	Audit Year: (required)<br>
	<cfSELECT NAME="Year"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Year Scheduled Required">

		<option value="">Select Year Below
		<option value="">---
		<cfloop index="i" to="#yearMax#" from="#curYear#">
			<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
		</cfloop>
	</cfSELECT><br><br>

	Month Scheduled: (required)<br>
	<cfSELECT NAME="Month"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Month Scheduled Required">

		<option value="">Select Month
		<option value="">---
		<cfloop index="i" to="12" from="1">
			<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
		</cfloop>
	</cfSELECT><br><br>

	Audit Type: (required)<br>
	<cfSELECT NAME="AuditType2"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Audit Type Required">

		<option value="">Select Audit Type
		<option value="">---
		<option value="Annual">Annual
		<option value="Gap Assessment">Gap Assessment
		<option value="Initial">Initial
		<option value="PQA Asessment">PQA Assessment
		<option value="Scope Expansion">Scope Expansion
	</cfSELECT><br><br>

	Auditor: (required)<br>
	<cfSELECT NAME="LeadAuditor"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Auditor Required">

		<option value="">Select Auditor
		<option value="">---
		<cfoutput query="Auditors">
			<option value="#Auditor#">#Auditor#
		</cfoutput>
	</cfSELECT><br><br>

	Audit Days - Number of On-Site Days: (required)<br>
	<cfSELECT NAME="AuditDays"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Audit Days Required">

		<option value="">Select Audit Days
		<option value="">---
		<cfloop index="i" to="10" from="1">
			<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
		</cfloop>
	</cfSELECT><br><br>

	Start Date<br>
	<cfINPUT ID="StartDate" TYPE="datefield" NAME="StartDate"><br><br><br>

	End Date (Leave blank for one day audits)<br>
	<cfINPUT ID="EndDate" TYPE="datefield" NAME="EndDate"><br><br><br>

	Notes<br>
	<cftextarea
		name="Notes"
	    data-bvalidator="required"
		data-bvalidator-msg="Notes Required"
		cols="60"
	    rows="5">No Notes Entered</cftextarea>
	<br><br>

	Admin Notes (not publicly viewable)<br>
	<cftextarea
		name="AdminNotes"
	    data-bvalidator="required"
		data-bvalidator-msg="Notes Required"
		cols="60"
	    rows="5">No Notes Entered</cftextarea>
	<br><br>

	<input name="submit" type="submit" value="Add Audit">
	<input type="reset" value="Reset Form"><br /><br />
	</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->