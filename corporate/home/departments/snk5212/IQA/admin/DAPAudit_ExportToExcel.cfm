<cfsavecontent variable="output">
	<cfcontent type="application/msexcel">
	<cfcontent type="text/html">

<cfif NOT isDefined("URL.Year")>
	<cfset URL.Year = #curyear#>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="output" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DAP_AuditSchedule.*, DAPClient.ClientName, DAPClient.DAFileNumber, DAPClient.AnniversaryDate

FROM DAP_AuditSchedule, DAPClient

WHERE DAP_AuditSchedule.Year_ = #URL.Year#
AND DAP_AuditSchedule.Approved = 'Yes'
AND DAP_AuditSchedule.DAPClient_ID = DAPClient.ID

ORDER BY DAP_AuditSchedule.Month, DAPClient.ClientName
</cfquery>

<table border="1">
<tr align="center" class="blog-title">
	<td>OracleDB:DAP_AuditSchedule.rowID</td>
	<td>Audit Number</td>
	<td>Month</td>
	<td>Start Date</td>
	<td>End Date</td>
	<td>Audit Type</td>
	<td>Client Name / DA File Number</td>
	<td>Anniversary Date</td>
	<td>Status</td>
	<td>Auditor</td>
	<td>Notes</td>
	<td>Cancel Notes</td>
</tr>
<cfoutput query="output">
<tr class="blog-content" valign="top">
	<td>#ID#</td>
	<td>#Year_#-#ID#-DAP</td>
	<td>#MonthAsString(month)#</td>
	<td>#Dateformat(StartDate, "mm/dd/yyyy")#</td>
	<td>#Dateformat(EndDate, "mm/dd/yyyy")#</td>
	<td>#AuditType2#</td>
	<td>#ClientName# (DA File Number - #DAFileNumber#)</td>
	<td>#Dateformat(AnniversaryDate, "mm/dd/yyyy")#</td>
	<td>
		<cfif len(Status)>
			<cfif Status eq "Deleted">
				Cancelled
			<cfelseif Status eq "Removed">
				Removed
			</cfif>
		<cfelse>
			Active
		</cfif>
	</td>
	<td>#LeadAuditor#</td>
	<td>#Notes#</td>
	<td>#CancelNotes#</td>
</tr>
</cfoutput>
</tr>
</table>
<br><Br>

<cfheader name="Content-Disposition" value="attachment; filename=Test.xls">
</cfsavecontent>

<cfoutput>#output#</cfoutput>