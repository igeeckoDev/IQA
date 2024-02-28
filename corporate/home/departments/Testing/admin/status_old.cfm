<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Document Status">
<cfinclude template="SOP.cfm">

<!--- / --->

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=175,left = 200,top = 200');");
}
// End -->
</script>

<cflock scope="SESSION" timeout="90">
<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT * from AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif SESSION.AUTH.AccessLevel is "IQAAuditor">
AND LeadAuditor = '#SESSION.Auth.Name#'
</cfif>
AND Approved = 'Yes'
AND AuditedBy = 'IQA'
ORDER BY Month, ID
</cfquery>
</cflock>

<cfoutput>
Select Year - 
<cfif URL.Year is LastYear>
<b>#LastYear#</b> <a href="status.cfm?Year=#CurYear#">[ #CurYear# ]</a> <a href="status.cfm?Year=#NextYear#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<a href="status.cfm?Year=#LastYear#">[ #LastYear# ]</a> <b>#CurYear#</b> <a href="status.cfm?Year=#NextYear#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<a href="status.cfm?Year=#LastYear#">[ #LastYear# ]</a> <a href="status.cfm?Year=#CurYear#">[ #CurYear# ]</a> <b>#NextYear#</b> <br><br>
<cfelse>
</cfif>
</cfoutput>

<u><b>Legend</b></u>:<br>
<u>For Scope, Report, and/or Follow Up</u><br>
<img src="../images/red.jpg" border="0"> - Not Completed<br>
<img src="../images/orange.jpg" border="0"> - (Follow Up Only) Not Completed - See Notes<br>
<img src="../images/green.jpg" border="0"> - Completed<br><br>

<u>Report</u><br>
<img src="../images/blue.jpg" border="0"> (1) - Indicates your report page completion status <br>
<img src="../images/blue.jpg" border="0"> (Entered) - All 4-6 report pages entered, but the report is not yet published<br>
<img src="../images/blue.jpg" border="0"> (2006-1.pdf) - Indicates a file upload, report form not used<br>
<br>

Scroll to a specific month:<br>
<SELECT NAME="Month" displayname="Month" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="###i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<table border="1" class="blog-content" width="600">
<cfset M="">
<cfoutput query="Check">
<cfif status is "deleted">
<cfelse>
	<cfif M IS NOT Month>
	<cfIf M is NOT ""><tr><td colspan="5" align="right"><a href="##Top">Top <img src="../images/top.gif" alt="" height="7" width="5" border="0"></a>&nbsp;</td></tr></cfif>
	<tr><td colspan="5"><a name="#Month#"></a><b><u>#MonthAsString(Month)#</u></b></td></tr>
	<tr>
	<td width="20%" align="center"><b>Audit Number</b></td>
	<td width="20%" align="center"><b>Lead Auditor</b></td>
	<td width="20%" align="center"><b>Scope Letter</b></td>
	<td width="20%" align="center"><b>Report</b></td>
	<td width="20%" align="center"><b>Follow Up</b></td>	
	</tr>
	</cfif>
<tr>
<td><a href="auditdetails.cfm?id=#id#&year=#year#">#Year#-#ID#</a>
<cfif reschedulenextyear is "Yes">(Rescheduled for Next Year)</cfif></td>

<td>#LeadAuditor#</td>

<td><cfif reschedulenextyear is "Yes">N/A<cfelse><cfif ScopeLetter is ""><img src="../images/red.jpg" border="0"><cfelseif ScopeLetter is "#Year#-#ID#.pdf"> <img src="../images/green.jpg" border="0"> (Old Method)<cfelseif ScopeLetter is "Entered"><img src="../images/green.jpg" border="0"></cfif></cfif></td>

<td>
<cfif reschedulenextyear is "Yes">N/A
<cfelse>
	<cfif Report is ""><img src="../images/red.jpg" border="0">
	<cfelseif Report is "Completed"><img src="../images/green.jpg" border="0">
	<cfelseif Report is "#Year#-#ID#.pdf"><img src="../images/green.jpg" border="0"> (#report#)
	<cfelse><img src="../images/blue.jpg" border="0"> (#report#)
</cfif>
</cfif>
</td>

<td>
<cfif reschedulenextyear is "Yes">N/A<cfelse><cfif AuditType is "TPTDP">
	<cfif FollowUp is "">
		<img src="../images/red.jpg" border="0">&nbsp;
		<A HREF="javascript:popUp('Status_Notes.cfm?externallocation=#externallocation#&year=#year#&id=#id#')">Add Notes</A>
	<cfelseif FollowUp is "Notes">
		<img src="../images/orange.jpg" border="0">&nbsp;
		<A HREF="javascript:popUp('Status_Notes.cfm?externallocation=#externallocation#&year=#year#&id=#id#')">View Notes</A>
	<cfelse>
		<img src="../images/green.jpg" border="0">
</cfif>
<cfelse>
	N/A
</cfif>
</cfif>
</td>
</tr>
<cfset M = Month>
</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->