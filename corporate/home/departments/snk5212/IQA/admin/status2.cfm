<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Scope and Report Completion Status - #monthasstring(url.month)# #url.year#">
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
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.LeadAuditor, AuditSchedule.ScopeLetterDate, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Month, AuditSchedule.ReportDate, AuditSchedule.CompletionNotes, auditSchedule.AuditType2, AuditSchedule.Desk
 FROM AuditSchedule
 WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif SESSION.AUTH.AccessLevel is "IQAAuditor" AND SESSION.Auth.Username NEQ "Jessen"
	OR SESSION.Auth.AccessLevel neq "IQAAuditor" AND SESSION.AUTH.AccessLevel neq "SU" AND SESSION.Auth.IQA eq "Yes">
 AND  LeadAuditor = '#SESSION.Auth.Name#'
</cfif>
 AND  Approved = 'Yes'
 AND  AuditSchedule.AuditedBy = 'IQA'
 AND  Month = #url.month#
 ORDER BY Month, ID
</cfquery>
</cflock>

<cfoutput>
Select Year - 
<cfif URL.Year is LastYear>
<b>#LastYear#</b> <a href="status2.cfm?Year=#CurYear#&month=1">[ #CurYear# ]</a> <a href="status2.cfm?Year=#NextYear#&month=1">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<a href="status2.cfm?Year=#LastYear#&month=#curmonth#">[ #LastYear# ]</a> <b>#CurYear#</b> <a href="status2.cfm?Year=#NextYear#&month=#curmonth#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<a href="status2.cfm?Year=#LastYear#&month=1">[ #LastYear# ]</a> <a href="status2.cfm?Year=#CurYear#&month=1">[ #CurYear# ]</a> <b>#NextYear#</b> <br><br>
<cfelse>
</cfif>

<a href="status.cfm?year=#curyear#">Status</a> - Scope Letter, Follow Up, and Report Status<br><br>
</cfoutput>

<u><b>Legend</b></u>:<br>
<img src="../images/red.jpg" border="0"> - Scope Completion - Less than 10 days before Start Date of Audit<br>
<img src="../images/red.jpg" border="0"> -  Report Completion - Greater than Five days after End Date of Audit<br>
<img src="../images/green.jpg" border="0"> - Completed On Time<br>
<img src="../images/blue.jpg" border="0"> - Global Doc Audit (Criteria: Audit Type 2 = Global Function/Process, Desk Audit = Yes)<br><br>

Scroll to a specific month:<br>
<SELECT NAME="Month" displayname="Month" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="status2.cfm?year=#url.year#&month=#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<table border="1" class="blog-content">
<cfoutput query="Check" group="Month">
<tr><td colspan="6 class="sched-title""><a name="#Month#"></a><b><u>#MonthAsString(Month)#</u></b></td></tr>
</cfoutput>
	<tr>
	<td width="15%" align="center" class="sched-title"><b>Audit Number</b></td>
	<td width="15%" align="center" class="sched-title"><b>Lead Auditor</b></td>
	<td width="15%" align="center" class="sched-title"><b>Scope Letter</b></td>
	<td width="15%" align="center" class="sched-title"><b>Start Date</b></td>
	<td width="15%" align="center" class="sched-title"><b>End Date</b></td>
	<td width="15%" align="center" class="sched-title"><b>Report</b></td>
	</tr>
<cfoutput query="Check">	
<!--- 8/29/2007 added removed status so they are not shown any longer --->
<cfif status is "deleted" or status is "removed" or reschedulenextyear is "Yes">
<!--- /// --->
<cfelse>
<tr>
<td class="sched-content">
	<a href="auditdetails.cfm?id=#id#&year=#year#">#Year#-#ID#</a>
</td>

<td class="sched-content">#LeadAuditor#</td>

<td align="center" class="sched-content">
<!---Setting the 2 "Date Range" dates.--->
<cfset Start = DateFormat(StartDate, 'mm/dd/yyyy')>
<cfset Scope = DateFormat(ScopeLetterDate, 'mm/dd/yyyy')>

<cfif len(Scope) AND NOT len(Start)>
<!--- Scope Letter Sent but no Start date - usually for a rescheduled audit or audit dates mistakenly not entered --->
#Scope#

<cfelseif len(Scope) AND len(Start)>
<!--- Scope  Letter Sent with Start Date for audit correctly input --->
<cfset variables.date1= "#Scope#">
<cfset variables.date2 = "#Start#">

<!---Setting up our total working days counter.--->
<cfset variables.totalWorkingDays = -1>

<!---Looping over our "Date Range" and incrementing our counter where the day is not Sunday or Saturday.--->
<cfloop from="#variables.date1#" to="#variables.date2#" index="i">
   <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
      <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
   </cfif>
</cfloop>

<!---Outputing our total working days.--->
#Scope#<br>(#variables.totalWorkingDays#)
<cfif variables.totalworkingdays gte 10>
<img src="../images/green2.jpg" border="0">
<cfelse>
<img src="../images/red2.jpg" border="0"><br>
	<cfif CompletionNotes is "">
	<A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">Add Notes</A>
	<cfelse>
	<b><a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">View Notes</a></b>
	</cfif>
</cfif>
<cfelseif NOT len(Scope) AND len(Start)>
<!--- if scope is blank and Start Date exists, show how many days till Start Date from today --->
<cfset variables.date1= "#curdate#">
<cfset variables.date2 = "#Start#">

<!---Setting up our total working days counter.--->
<cfset variables.totalWorkingDays = -1>

<!---Looping over our "Date Range" and incrementing our counter where the day is not Sunday or Saturday.--->
<cfloop from="#variables.date1#" to="#variables.date2#" index="i">
   <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
      <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
   </cfif>
</cfloop>

No Scope (#variables.totalWorkingDays#)
<cfelseif NOT len(Scope) AND NOT len(Start)>
<!--- if scope and start date are blank --->
No Scope<br />
<cfif year eq curyear>
	<cfif month lt curmonth>
		<cfif CompletionNotes is "">
		<Br>
	<A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">Add Notes</A>
		<cfelse>
		<br>
	<b><a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">View Notes</a></b>
		</cfif>
	</cfif>
<cfelseif Year lt curyear>
		<cfif CompletionNotes is "">
		<Br>
	<A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">Add Notes</A>
		<cfelse>
		<br>
	<b><a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">View Notes</a></b>
		</cfif>		
</cfif>
</cfif>
</td>

<td align="center" class="sched-content">
<cfset Start = DateFormat(StartDate, 'mm/dd/yyyy')>
<cfif Start is NOT "">
#Start#
<cfelse>
<b>No Start Date</b>
</cfif>
</td>

<td align="center" class="sched-content">
<cfset End = DateFormat(EndDate, 'mm/dd/yyyy')>
<cfif End is NOT "">
#End#
<cfelse>
<b>No End Date</b>
</cfif>
</td>

<td align="center" class="sched-content">
<cfset End = DateFormat(EndDate, 'mm/dd/yyyy')>
<cfset ReportD = DateFormat(ReportDate, 'mm/dd/yyyy')>

<cfif ReportD is NOT "">
<cfset variables.date1 = "#End#">
<cfset variables.date2 = "#ReportD#">

<!---Setting up our total working days counter.--->
<cfset variables.totalWorkingDays = -1>

<!---Looping over our "Date Range" an incrementing our counter where the day is not Sunday or Saturday.--->
<cfloop from="#variables.date1#" to="#variables.date2#" index="i">
   <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
      <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
   </cfif>
</cfloop>

<!---Outputing our total working days.--->
#ReportD#<br>(<cfif variables.totalWorkingDays lt 0>0<cfelse>#variables.totalWorkingDays#</cfif>)
<cfif variables.totalworkingdays lte 5>
<img src="../images/green2.jpg" border="0">
<cfelse>
<cfif audittype2 is "Global Function/Process" AND Desk is "Yes">
	<img src="../images/blue2.jpg" border="0"><br>
<cfelse>
	<img src="../images/red2.jpg" border="0"><br>
</cfif>
	<cfif audittype2 is "Global Function/Process" AND Desk is "Yes">
	<cfelse>
	<cfif CompletionNotes is "">
	<A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">Add Notes</A>
	<cfelse>
	<b><a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">View Notes</a></b>
	</cfif>
	</cfif>
</cfif>
<cfelse>
No Report
<cfif year eq curyear>
	<cfif month lt curmonth>
		<cfif CompletionNotes is "">
		<Br>
	<A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">Add Notes</A>
		<cfelse>
		<br>
	<b><a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">View Notes</a></b>
		</cfif>
	</cfif>
<cfelseif Year lt curyear>
		<cfif CompletionNotes is "">
		<Br>
	<A HREF="javascript:popUp('Status_CompletionNotes.cfm?year=#year#&id=#id#&page=status2')">Add Notes</A>
		<cfelse>
		<br>
	<b><a href="javascript:popUp('Status_vCompletionNotes.cfm?year=#year#&id=#id#&page=status2')">View Notes</a></b>
		</cfif>		
</cfif>
</cfif>

</cfif>
</td>
</tr>
<cfset M = Month>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->