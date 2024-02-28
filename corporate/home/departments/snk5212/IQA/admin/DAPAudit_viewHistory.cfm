<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<A href=AuditMatrix_DAP.cfm?Year=#curYear#>View DAP Audit Schedule</a> - View History - DAP Audit">
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
SELECT ClientName, AnniversaryDate
FROM DAPClient
WHERE ID = #output.DAPClient_ID#
</cfquery>

<b>Client Name</b><br>
#DAPClient.ClientName# (<A href="DAPClientList_Details.cfm?rowID=#DAPClient_ID#" target="_blank">View Profile</a>)<br><br>

<b>Audit Details</b><br>
<a href="DAPAudit_Details.cfm?rowID=#URL.rowID#">View Audit Details</a><br><br>

<b>History</b><br>
#History#<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->