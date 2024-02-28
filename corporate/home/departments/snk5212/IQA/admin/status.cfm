<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Document Status - #url.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=350,left = 200,top = 200');");
}
// End -->
</script>

<cflock scope="SESSION" timeout="90">
    <CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
    FROM AuditSchedule
    WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    <cfif SESSION.AUTH.AccessLevel is "IQAAuditor"
		OR SESSION.Auth.AccessLevel neq "IQAAuditor" AND SESSION.AUTH.AccessLevel neq "SU" AND SESSION.Auth.IQA eq "Yes">
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
<b>#LastYear#</b> <a href="status.cfm?Year=#CurYear#">[ #CurYear# ]</a> <a href="status.cfm?Year=#NextYear#">[ #NextYear# ]</a><br>
<cfelseif URL.Year is CurYear>
<a href="status.cfm?Year=#LastYear#">[ #LastYear# ]</a> <b>#CurYear#</b> <a href="status.cfm?Year=#NextYear#">[ #NextYear# ]</a><br>
<cfelseif URL.Year is NextYear>
<a href="status.cfm?Year=#LastYear#">[ #LastYear# ]</a> <a href="status.cfm?Year=#CurYear#">[ #CurYear# ]</a> <b>#NextYear#</b> <br>
<cfelse>
</cfif><br><br>

<!---
<a href="status2.cfm?year=#curyear#&month=#curmonth#">Status 2</a> - Audit Scope and Report Completion (Monthly)<br>
<a href="status2year.cfm?year=#curyear#">Status 2</a> - Audit Scope and Report Completion (Yearly)<br><br>
--->
</cfoutput>

<u><b>Legend</b></u>:<br>
<u>For Scope, Report, and/or Follow Up</u><br>
<img src="../images/red.jpg" border="0"> - Not Completed<br>
<img src="../images/orange.jpg" border="0"> - Third Party Audits (Ending 2007) - Follow Up Not Completed - See Notes<br>
<img src="../images/orange.jpg" border="0"> - Internal Audits (starting 2008) - Scope/Report Completion Notes<br>
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

<table border="1" class="sched-content" width="600">
<cfset M="">
<cfoutput query="Check">
<!--- 8/29/2007 added removed status so they are not shown any longer --->
<cfif status is "deleted" or status is "removed">
<!--- /// --->
<cfelse>
	<cfif M IS NOT Month>
	<cfIf M is NOT ""><tr><td colspan="6" align="right" class="sched-title"><a href="##Top">Top <img src="../images/top.gif" alt="" height="7" width="5" border="0"></a>&nbsp;</td></tr></cfif>
	<tr><td colspan="6" class="sched-title"><a name="#Month#"></a><b><u>#MonthAsString(Month)#</u></b></td></tr>
	<tr>
	<td width="20%" align="center" class="sched-title"><b>Audit<br>Number</b></td>
	<td width="20%" align="center" class="sched-title"><b>Lead Auditor</b></td>
	<td width="15%" align="center" class="sched-title"><b>Scope<br>Letter</b></td>
	<td width="15%" align="center" class="sched-title"><b>Report</b></td>
	<td width="15%" align="center" class="sched-title"><b>Pathnotes</b></td>
	<td width="15%" align="center" class="sched-title"><b><cfif url.year gte 2008>Completion Notes<cfelse>Follow Up</cfif></b></td>
	</tr>
	</cfif>
<tr>
<!--- Audit Number --->
<td class="sched-content"><a href="auditdetails.cfm?id=#id#&year=#year#">#Year#-#ID#</a><Br>
#Area#<br>
#OfficeName#
<cfif reschedulenextyear is "Yes"><br>(Rescheduled for Next Year)</cfif></td>

<!--- Auditor Name --->
<td class="sched-content">#LeadAuditor#</td>

<!--- Scope Letter --->
<td align="center" class="sched-content">
<cfif reschedulenextyear is "Yes">
	N/A
<cfelse>
	<cfif ScopeLetter is "">
		<img src="../images/red.jpg" border="0">
		<cfset s1 = 0>
	<cfelseif ScopeLetter is "#Year#-#ID#.pdf">
		<img src="../images/green.jpg" border="0"> (Old Method)
		<cfset s1 = 1>
	<cfelseif ScopeLetter is "Entered">
		<img src="../images/green.jpg" border="0">
		<cfset s1 = 1>
	</cfif>
</cfif>
</td>

<!--- Report --->
<td align="center" class="sched-content">
<cfif reschedulenextyear is "Yes">
	N/A
<cfelse>
	<cfif Report is "">
		<img src="../images/red.jpg" border="0">
		<cfset s2 = 0>
	<cfelseif Report is "Completed">
		<img src="../images/green.jpg" border="0">
		<cfset s2 = 1>
	<cfelseif Report is "#Year#-#ID#.pdf">
		<img src="../images/green.jpg" border="0"> (#report#)
		<cfset s2 = 1>
	<cfelse>
		<img src="../images/blue.jpg" border="0"> (#report#)
		<cfset s2 = 0>
</cfif>
</cfif>
</td>

<!--- Pathnotes --->
<td align="center" class="sched-content">
<cfif reschedulenextyear is "Yes">
N/A
<cfelse>
	<cfif len(PathnotesFile)>
        <img src="../images/green.jpg" border="0">
    <cfelse>
        <img src="../images/red.jpg" border="0">
    </cfif>
</cfif>
</td>

<!--- Completion Notes / Follow Up (pre 2008) --->
<td class="sched-content">
<cfif reschedulenextyear is "Yes">
	N/A
<cfelse>
	<cfif AuditType is "TPTDP">
		 <cfif FollowUp is "">
            <img src="../images/red.jpg" border="0">&nbsp;
            <A HREF="javascript:popUp('Status_Notes.cfm?externallocation=#externallocation#&year=#year#&id=#id#')">Add Notes</A>
         <cfelseif FollowUp is "Notes">
            <img src="../images/orange.jpg" border="0">&nbsp;
            <A HREF="javascript:popUp('Status_Notes.cfm?externallocation=#externallocation#&year=#year#&id=#id#')">View Notes</A>
         <cfelse>
            <img src="../images/green.jpg" border="0">
         </cfif>
	<cfelse><!--- not TPTDP --->
	    <cfset nextmonth = curmonth + 1>

    	<cfif year eq curyear AND Month lte nextmonth>
			<cfif CompletionNotes is NOT "">
                <a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">[View Notes]</a>
            <cfelse>
                <cfif s1 eq 0 OR s2 eq 0>
                    <A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">[Add Notes]</A>
                <cfelse>
                    Completed
                </cfif>
            </cfif>
		<cfelse><!--- current and future months of current year --->
		&nbsp;
	</cfif>
	</cfif>
</cfif>
</td>
</tr>
<cfset M = Month>
</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->