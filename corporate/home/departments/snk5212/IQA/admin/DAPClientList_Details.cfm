<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=DAPClientList.cfm?Order=DA&Status=Active>DAP Client List</a> -  View Client Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="DAPClient" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPClient
WHERE ID = #URL.rowID#
</cfquery>

<u>Available Actions</u><br>
<cfoutput query="DAPClient">

<cflock scope="SESSION" timeout="10">
	<cfif SESSION.Auth.AccessLevel eq "Admin"
	  OR SESSION.Auth.AccessLevel eq "SU">
 :: <a href="DAPClientList_Edit.cfm?rowID=#URL.rowID#">Edit</a> Client Details<br>
 :: <a href="DAPAudit_Add.cfm?rowID=#URL.rowID#">Add</a> Audit<br>
	</cfif>
</cflock>
 :: <A href="DAPClientList.cfm">View</a> DAP Client List<br><br>

<b>Client Name</b><br>
#ClientName#<br><br>

<b>DA File Number</b><br>
#DAFileNumber#<br><br>

<b>Location</b><br>
Address: #Address1#<br>
State: #State#<br>
Country: #Country#<br>
Region: #Region#<br><br>

<b>Status</b><br>
<cfif len(status)>
	#Status#
<cfelse>
	None Listed
</cfif><br><br>

<b>Audit Cycle</b><br>
#AuditCycle# Years<br><br>

<b>Anniversary Date</b><br>
#dateformat(AnniversaryDate, "mm/dd/yyyy")#<br><br>

<b>DAP Participant Programs</b><br>
<cfif len(ACTL)><u>ACTL</u>: #ACTL#<br></cfif>
<cfif len(CBTL)><u>CBTL</u>: #CBTL#<br></cfif>
<cfif len(CTDP)><u>CTDP</u>: #CTDP#<br></cfif>
<cfif len(CTF)><u>CTF Stage 3/4</u>: #CTF#<br></cfif>
<cfif len(TCP)><u>TCP</u>: #TCP#<br></cfif>
<cfif len(TPTDP)><u>TPTDP</u>: #TPTDP#<br></cfif>
<cfif len(CAP)><u>CAP</u>: #CAP#<br></cfif>
<cfif len(PPP)><u>PPP</u>: #PPP#<br></cfif>
</cfoutput><br>

<CFQUERY BLOCKFACTOR="100" name="ViewAudits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
DAP_AuditSchedule.xGUID, DAP_AuditSchedule.ID, DAP_AuditSchedule.Year_, DAP_AuditSchedule.Month, DAP_AuditSchedule.AuditType2, DAP_AuditSchedule.DAPCLIENT_ID,
DAP_AuditSchedule.AuditDays, DAP_AuditSchedule.LeadAuditor, DAP_AuditSchedule.Status, DAPClient.ClientName, DAPClient.AnniversaryDate,
DAPClient.DAFileNumber

FROM
DAP_AuditSchedule, DAPClient

WHERE
DAPClient.ID = DAP_AuditSchedule.DAPCLIENT_ID
AND DAPClient.ID = #URL.rowID#

ORDER BY
Year_, Month
</cfquery>

<b>Audit Search Results</b>:<Br>
<cfif viewAudits.recordCount GT 0>
	<Table border="1" style="border-collapse: collapse;">
	<tr>
		<th>Audit Number</th>
		<th width="200">Client Name</th>
		<th width="75">Month</th>
		<th width="75">Audit Type</th>
	</tr>
	<cfoutput query="viewAudits">
	<tr>
		<td><A href="DAPAudit_Details.cfm?rowID=#xGUID#">#Year_#-#ID#-DAP</a></td>
		<td>#ClientName#</td>
		<td>#MonthAsString(Month)#</td>
		<td>#AuditType2#</td>
	</tr>
	</cfoutput>
	</table>
<cfelse>
	<cfoutput>
		No Audits Found for #DAPClient.ClientName# / DA File Number #DAPClient.DAFileNumber#
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->