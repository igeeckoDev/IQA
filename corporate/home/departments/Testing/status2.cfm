<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Schedule Status">
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

<cfif curmonth lte 3>
	<cfset q = 1>
<cfelseif curmonth lte 6>
	<cfset q = 2>
<cfelseif curmonth lte 9>
	<cfset q = 3>
<cfelseif curmonth lte 12>
	<cfset q = 4>
</cfif>

<cflock scope="SESSION" timeout="90">
<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year from AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif url.year is curyear>
	<cfif q is 1>
		AND Month <= 3
	<cfelseif q is 2>
		AND Month <= 6
	<cfelseif q is 3>
		AND Month <= 9
	<cfelseif q is 4>
	</cfif>
</cfif>
AND Approved = 'Yes'
AND AuditedBy = 'IQA'
ORDER BY Month, ID, AuditType
</cfquery>
</cflock>

<cfoutput>
Select Year - 
<cfif URL.Year is LastYear>
<b>#LastYear#</b> <a href="status2.cfm?Year=#CurYear#">[ #CurYear# ]</a> <a href="status2.cfm?Year=#NextYear#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<a href="status2.cfm?Year=#LastYear#">[ #LastYear# ]</a> <b>#CurYear#</b> <a href="status2.cfm?Year=#NextYear#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<a href="status2.cfm?Year=#LastYear#">[ #LastYear# ]</a> <a href="status2.cfm?Year=#CurYear#">[ #CurYear# ]</a> <b>#NextYear#</b> <br><br>
<cfelse>
</cfif>
</cfoutput>

<u><b>Legend</b></u>:<br>
<img src="images/red.jpg" border="0"> - Audit Rescheduled (see notes)<br>
<img src="images/orange.jpg" border="0"> - Audit Performed - Close Out issues (TP Only, see notes)<br>
<img src="images/green.jpg" border="0"> - Audit Performed<br>
<img src="images/black.jpg" border="0"> - Audit Cancelled (see notes)<br><br>

<table border="1" class="blog-content" width="600">
<cfset M="">
<cfoutput query="Check">
	<cfif M IS NOT Month>
	<cfIf M is NOT ""><tr><td colspan="4" align="right"><a href="##">Top <img src="images/top.gif" alt="" height="7" width="5" border="0"></a>&nbsp;</td></tr></cfif>
	<cfif month eq 1>
	<tr><td colspan="4"><b><u>1st Quarter</u></b></td></tr>	
	<cfelseif month eq 4>
	<tr><td colspan="4"><b><u>2nd Quarter</u></b></td></tr>	
	<cfelseif month eq 7>
	<tr><td colspan="4"><b><u>3rd Quarter</u></b></td></tr>	
	<cfelseif month eq 10>
	<tr><td colspan="4"><b><u>4th Quarter</u></b></td></tr>	
	</cfif>
	<tr><td colspan="4"><b>#MonthAsString(Month)#</b></td></tr>
	<tr>
	<td align="center"><b>Audit Number</b></td>
	<td align="center"><b>Audited Site/Program</b></td>
	<td align="center"><b>Status</b></td>
	<td align="center"><b>Notes</b></td>	
	</tr>
	</cfif>
<tr>
<td align="center"><a href="auditdetails.cfm?id=#id#&year=#year#">#Year#-#ID#</a></td>

<td>
<cfif audittype is "TPTDP">
#externallocation#
<cfelse>
	<cfif audittype2 is "Program">
	#Area#
	<cfelseif audittype2 is "Local Function">
	#officename# (#area#)
	<cfelseif audittype2 is "Local Function FS">
	#officename# (#area#)
	<cfelseif audittype2 is "Local Function CBTL">
	#officename# (#area#)
	<cfelseif audittype2 is "Global Function/Process">
	Global - #Area#
	<cfelseif audittype2 is "Corporate">
	Corporate - #Area#
	<cfelseif audittype2 is "Field Services">
	#officename# - #area#
	</cfif>
</cfif>
</td>

<td align="center">
<cfif reschedulenextyear is "Yes">
	<img src="images/red.jpg" border="0">
<cfelseif status is "deleted">
	<img src="images/black.jpg" border="0">
<cfelseif FollowUp is "Notes">
	<img src="images/orange.jpg" border="0">
<cfelse>
	<img src="images/green.jpg" border="0">
</cfif>
</td>

<td align="center">
<cfif reschedulenextyear is "Yes">
	<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')">View Details</a>
<cfelseif status is "deleted">
	<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')">View Details</a>
<cfelseif FollowUp is "Notes">
		<A HREF="javascript:popUp('Status2_Notes2.cfm?externallocation=#externallocation#&year=#year#&id=#id#')">View Details</A>
<cfelse>
--
</cfif>
</td>
</tr>
<cfset M = Month>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->