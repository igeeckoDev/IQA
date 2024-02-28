<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audited Schedule - Baseline Activity">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="output" DataSource="Corporate">
SELECT Year_ as Year, ID, AuditedBy, AuditType, AuditType2, OfficeName, Area, AuditArea, LeadAuditor, Month, StartDate, EndDate, Status
FROM AuditSchedule
WHERE AuditedBy = 'IQA'
AND Year_ = #curyear#
ORDER BY Month, StartDate, ID
</CFQUERY>

<table border=1>
<tr class="blog-content">
	<td>Audit Number</td>
	<td>Type</td>
	<td>Location</td>
	<td>Area</td>
	<td>Lead</td>
	<td>Status</td>
	<td>Change Month</td>
</tr>
<cfset M = "">
<cfoutput query="output">
<cfif M IS NOT Month> 
<tr class="blog-content">
	<td colspan="7"><br><b><u>#MonthAsString(Month)#</u></b></td>
</tr>
</cfif>
<tr valign="top" class="blog-content">
	<td>#Year#-#ID#</td>
	<td>#AuditType2#</td>
	<td>#OfficeName#</td>
	<td>#Area#</td>
	<td>#LeadAuditor#</td>
	<td><cfif NOT len(Status)>Active<cfelse><b>#Status#</b></cfif></td>
	<td>
	<SELECT NAME="MonthJump" class="blog-content" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Month
		<option value="javascript:document.location.reload();">
		<cfloop index="i" to="12" from="1">
			<OPTION VALUE="" <cfif i eq Month>SELECTED</cfif>>#MonthAsString(i)#
		</cfloop>
	</SELECT>
	</td>
</tr>
<cfset M = Month>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->