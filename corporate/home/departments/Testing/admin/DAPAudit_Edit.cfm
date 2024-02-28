<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<A href=AuditMatrix_DAP.cfm?Year=#curYear#>View DAP Audit Schedule</a> - Edit DAP Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAP_AuditSchedule
WHERE xGUID = #URL.rowID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Auditors" Datasource="Corporate">
SELECT Auditor
FROM AuditorList
WHERE DAPAuditor = 'Yes'
ORDER BY Auditor
</cfquery>

<cfif structKeyExists(form,'submit')>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Form.StartDate") AND isDefined("Form.EndDate")>
		<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>
	</cfif>

	<cfset historyUpdate = "Audit Details Edited on #curdate# #curtime# by #SESSION.Auth.Username#<br>Edit Notes: #Form.EditNotes#">

	<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE DAP_AuditSchedule
	SET
	AuditDays = #Form.AuditDays#,
	AuditType2 = '#Form.AuditType2#',
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
	LeadAuditor = '#Form.LeadAuditor#',
	Notes = '#Form.Notes#',
	AdminNotes = '#Form.AdminNotes#',
	History = <CFQUERYPARAM VALUE="#historyUpdate#<br><br>#output.History#" CFSQLTYPE="CF_SQL_CLOB">

	WHERE xGUID = #URL.rowID#
	</cfquery>
</cflock>

	<cflocation url="DAPAudit_Details.cfm?rowID=#URL.rowID#" addtoken="no">
<cfelse>
	<cfFORM  method ="post" id="myform" name="myform" ACTION="#CGI.ScriptName#?#CGI.Query_String#">

	<CFQUERY BLOCKFACTOR="100" name="DAPClient" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ClientName, DAFileNumber, AnniversaryDate
	FROM DAPClient
	WHERE ID = #output.DAPClient_ID#
	</cfquery>

	<cfoutput query="DAPClient">
	<b>Client Name</b><br>
	#ClientName#<br><br>

	<b>DA File Number</b><br>
	#DAFileNumber#<br><br>

	<b>Anniversary Date</b><br>
	#dateformat(AnniversaryDate, "mm/dd/yyyy")#<br><br>
	</cfoutput>

	<cfoutput query="output">
	<cfset yearMax = curyear + 2>

	Audit Year: #Year_#<br><br>

	Month Scheduled: (#MonthAsString(Month)#)<br>
	<cfSELECT NAME="Month"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Month Scheduled Required">

		<option value="">Select Month
		<option value="">---
		<option value="#Month#" selected>#MonthAsString(Month)#
		<cfloop index="i" to="12" from="1">
			<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
		</cfloop>
	</cfSELECT><br><br>

	Audit Type: (#AuditType2#)<br>
	<cfSELECT NAME="AuditType2"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Audit Type Required">

		<option value="">Select Audit Type
		<option value="">---
		<option value="#AuditType2#" selected>#AuditType2#
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
		<option value="#LeadAuditor#" selected>#LeadAuditor#
		<cfloop query="Auditors">
			<option value="#Auditor#">#Auditor#
		</cfloop>
	</cfSELECT><br><br>

	Audit Days - Number of On-Site Days: (required)<br>
	<cfSELECT NAME="AuditDays"
		queryposition="below"
		data-bvalidator="required"
		data-bvalidator-msg="Audit Days Required">

		<option value="">Select Audit Days
		<option value="">---
		<option value="#AuditDays#" selected>#AuditDays#
		<cfloop index="i" to="10" from="1">
			<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
		</cfloop>
	</cfSELECT><br><br>

	Start Date<br>
	<cfINPUT value="#StartDate#" ID="StartDate" TYPE="datefield" NAME="StartDate"><br><br><br>

	End Date (Leave blank for one day audits)<br>
	<cfINPUT value="#EndDate#" ID="EndDate" TYPE="datefield" NAME="EndDate"><br><br><br>

	Notes<br>
	<cftextarea
		name="Notes"
	    data-bvalidator="required"
		data-bvalidator-msg="Notes Required"
		cols="60"
	    rows="5">#Notes#</cftextarea>
	<br><br>

	Admin Notes (not publicly viewable)<br>
	<cftextarea
		name="AdminNotes"
	    data-bvalidator="required"
		data-bvalidator-msg="Notes Required"
		cols="60"
	    rows="5">#AdminNotes#</cftextarea>
	<br><br>

	Edit Notes - Document the changes made to this audit:<br>
	<cftextarea
		name="EditNotes"
	    data-bvalidator="required"
		data-bvalidator-msg="Edit Notes Required"
		cols="60"
	    rows="5"></cftextarea>
	<br><br>
	</cfoutput>

	<input name="submit" type="submit" value="Update Audit">
	<input type="reset" value="Reset Form"><br /><br />
	</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->