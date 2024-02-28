<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<A href=AuditMatrix_DAP.cfm?Year=#curYear#>View DAP Audit Schedule</a> - Cancel DAP Audit">
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

<cfif structKeyExists(form,'submit') AND structKeyExists(form, 'YesNoItem')>

<cflock scope="Session" timeout="5">
	<cfset HistoryUpdate = "Audit Cancelled on #curdate# #curtime# by #SESSION.Auth.UserName#<br>Cancel Notes: #Form.CancelNotes#">

	<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE DAP_AuditSchedule
	SET
	Status = 'Deleted',
	CancelNotes = 'Audit Cancelled on #curdate# #curtime# by #SESSION.Auth.UserName#<br><br>#Form.CancelNotes#',
	History = <CFQUERYPARAM VALUE="#historyUpdate#<br><br>#output.History#" CFSQLTYPE="CF_SQL_CLOB">

	WHERE xGUID = #URL.rowID#
	</cfquery>
</cflock>

	<cflocation url="DAPAudit_Details.cfm?rowID=#URL.rowID#" addtoken="no">
<cfelse>
	<cfFORM  method ="post" id="myform" name="myform" ACTION="#CGI.ScriptName#?#CGI.Query_String#">

	<CFQUERY BLOCKFACTOR="100" name="DAPClient" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ClientName, AnniversaryDate, DAFileNumber
	FROM DAPClient
	WHERE ID = #output.DAPClient_ID#
	</cfquery>

	<cfoutput query="DAPClient">
	<b>Client Name</b><br>
	#ClientName#<br><br>

	<b>DA File Number</b><br>
	#DAFileNumber#<br><br>
	</cfoutput>

	Do you wish to cancel this audit?<br><br>

	Yes <input
			type="checkbox"
			name="YesNoItem"
			value="Yes" /><Br><br>

	Cancellation Notes:<br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="CancelNotes" displayname="CancelNotes" value=""></textarea><br><br>

	<cfoutput query="Output">
	<b>Audit Number</b><br>
	#Year_#-#ID#-DAP<Br><br>

	<b>Audit Type</b><br>
	#AuditType# / #AuditType2#<br><br>

	<b>Month Scheduled</b><br>
	#MonthAsString(Month)#<br><br>

	<b>Audit Days</b><br>
	#AuditDays#<br><br>

	<b>Audit Dates</b><br>
	<!--- uses incDates.cfc --->
	<cfinvoke
		component="IQA.Components.incDates"
	    returnvariable="DateOutput"
	    method="incDates">

		<cfif len(StartDate)>
	        <cfinvokeargument name="StartDate" value="#StartDate#">
	    <cfelse>
	        <cfinvokeargument name="StartDate" value="">
	    </cfif>

		<cfif len(EndDate)>
	        <cfinvokeargument name="EndDate" value="#EndDate#">
	    <cfelse>
	        <cfinvokeargument name="EndDate" value="">
	    </cfif>

	    <cfinvokeargument name="Status" value="#Status#">
	    <cfinvokeargument name="RescheduleNextYear" value="No">
	</cfinvoke>

	<!--- output of incDates.cfc --->
	#DateOutput#<Br /><br>

	<cfset RescheduleNextYear = "No">
	<cfset Report = "">
	<cfset Year = Year_>

	<cfinclude template="#IQADir#status_colors_DAP.cfm"><Br><br>

	<b>Auditor</b><br>
	#LeadAuditor#<br><br>

	<b>Notes</b><br>
	<cfif len(Notes)>
		#Notes#
	<cfelse>
		None Listed
	</cfif><br><br>
	</cfoutput>

	<input name="submit" type="submit" value="Cancel Audit">
	<input type="reset" value="Reset Form"><br /><br />
	</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->