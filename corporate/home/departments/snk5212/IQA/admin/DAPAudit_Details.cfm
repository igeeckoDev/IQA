<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<A href=AuditMatrix_DAP.cfm?Year=#curYear#>View DAP Audit Schedule</a> - View DAP Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAP_AuditSchedule
WHERE xGUID = #URL.rowID#
</cfquery>

<cfoutput query="output">
<b>Audit Number</b><br>
#Year_#-#ID#-DAP<br><br>

<CFQUERY BLOCKFACTOR="100" name="DAPClient" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ClientName, AnniversaryDate, DAFileNumber
FROM DAPClient
WHERE ID = #output.DAPClient_ID#
</cfquery>

<u>Available Actions</u><br>
 :: <a href="DAPAudit_Edit.cfm?rowID=#URL.rowID#">Edit</a> Audit<br>
<cfif NOT len(Status)>
 :: <a href="DAPAudit_Cancel.cfm?rowID=#URL.rowID#">Cancel</a> Audit<br>
<cfelseif len(Status) AND Status eq "Deleted">
 :: <a href="DAPAudit_Reinstate.cfm?rowID=#URL.rowID#">Resintate</a> Audit<br>
</cfif>
<cfif NOT len(Status)>
 :: <a href="DAPAudit_Remove.cfm?rowID=#URL.rowID#">Delete</a> Audit (Remove it entirely from the Audit Schedule)<br>
<cfelseif Len(Status) AND Status eq "Removed">
 :: <a href="DAPAudit_UnRemove.cfm?rowID=#URL.rowID#">Un-Delete</a> Audit (Return it to the Audit Schedule)<br>
</cfif>
 :: <a href="DAPAudit_viewHistory.cfm?rowID=#URL.rowID#">View Change History</a><br><br>

<b>Client Name</b><br>
#DAPClient.ClientName# (<A href="DAPClientList_Details.cfm?rowID=#DAPClient_ID#" target="_blank">View Profile</a>)<br><br>

<b>DA File Number</b><br>
#DAPClient.DAFileNumber#<br><br>

<b>Anniversary Date</b><br>
#dateformat(DAPClient.AnniversaryDate, "mm/dd/yyyy")#<br><br>

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

<cfif len(Status) AND Status eq "Deleted">
<b>Cancellation Notes</b><br>
	<cfif len(CancelNotes)>
		#CancelNotes#
	<cfelse>
		None Listed
	</cfif><br><br>
</cfif>

<b>Auditor</b><br>
#LeadAuditor#<br><br>

<b>Notes</b><br>
<cfif len(Notes)>
	#Notes#
<cfelse>
	None Listed
</cfif><br><br>

<b>Admin Notes</b> (Not publicly viewable)<br>
<cfif len(AdminNotes)>
	#AdminNotes#
<cfelse>
	None Listed
</cfif><br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->