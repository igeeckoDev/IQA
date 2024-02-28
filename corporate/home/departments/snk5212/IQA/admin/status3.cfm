<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Scope and Report Completion Status - <cfoutput>#monthasstring(url.month)# #url.year#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->

<cflock scope="SESSION" timeout="90">
<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.LeadAuditor, AuditSchedule.ScopeLetterDate, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Month, AuditSchedule.ReportDate
 FROM AuditSchedule
 WHERE AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif SESSION.AUTH.AccessLevel is "IQAAuditor">
 AND  LeadAuditor = '#SESSION.Auth.Name#'
</cfif>
 AND  Approved = 'Yes'
 AND  AuditSchedule.AuditedBy = 'IQA'
 AND  Month = #url.month#
 ORDER BY Month, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
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
<img src="../images/green.jpg" border="0"> - Completed On Time<br><br>

Scroll to a specific month:<br>
<SELECT NAME="Month" displayname="Month" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="status2.cfm?year=#curyear#&month=#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<table border="1" class="blog-content" width="600">
<cfoutput query="Check" group="Month">
<tr><td colspan="6"><a name="#Month#"></a><b><u>#MonthAsString(Month)#</u></b></td></tr>
</cfoutput>
	<tr>
	<td width="17%" align="center"><b>Audit Number</b></td>
	<td width="17%" align="center"><b>Lead Auditor</b></td>
	<td width="17%" align="center"><b>Scope Letter</b></td>
	<td width="17%" align="center"><b>Start Date</b></td>
	<td width="17%" align="center"><b>End Date</b></td>
	<td width="17%" align="center"><b>Report</b></td>
	</tr>
<cfoutput query="Check">	
<!--- 8/29/2007 added removed status so they are not shown any longer --->
<cfif status is "deleted" or status is "removed">
<!--- /// --->
<cfelse>
<tr>
<td><a href="auditdetails.cfm?id=#id#&year=#year#">#Year#-#ID#</a>
<cfif reschedulenextyear is "Yes">(Rescheduled for Next Year)</cfif></td>

<td>#LeadAuditor#</td>

<td align="center">
<cfif reschedulenextyear is "Yes">
N/A
<cfelse>

<!---Setting the 2 "Date Range" dates.--->
<cfset Start = DateFormat(StartDate, 'mm/dd/yyyy')>
<cfset Scope = DateFormat(ScopeLetterDate, 'mm/dd/yyyy')>

<cfif Scope is NOT "">
<cfset variables.date1= "#Scope#">
<cfset variables.date2 = "#Start#">

<!---Setting up our total working days counter.--->
<cfset variables.totalWorkingDays = -1>

<!---Looping over our "Date Range" an incrementing our counter where the day is not Sunday or Saturday.--->
<cfloop from="#variables.date1#" to="#variables.date2#" index="i">
   <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
      <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
   </cfif>
</cfloop>

<!---Outputing our total working days.--->
#Scope# (#variables.totalWorkingDays#)
<cfif variables.totalworkingdays gte 10>
<img src="../images/green2.jpg" border="0">
<cfelse>
<img src="../images/red2.jpg" border="0">
</cfif>
<cfelse>
No Scope
</cfif>
</cfif></td>

<td align="center">
<cfset Start = DateFormat(StartDate, 'mm/dd/yyyy')>
<cfif Start is NOT "">
#Start#
<cfelse>
No Start Date
</cfif>
</td>

<td align="center">
<cfset End = DateFormat(EndDate, 'mm/dd/yyyy')>
<cfif End is NOT "">
#End#
<cfelse>
No End Date
</cfif>
</td>

<td align="center">
<cfif reschedulenextyear is "Yes">
N/A
<cfelse>

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
#ReportD# (<cfif variables.totalWorkingDays lt 0>0<cfelse>#variables.totalWorkingDays#</cfif>)
<cfif variables.totalworkingdays lte 5>
<img src="../images/green2.jpg" border="0">
<cfelse>
<img src="../images/red2.jpg" border="0">
</cfif>
<cfelse>
No Report
</cfif>

</cfif>
</cfif>
</td>
</tr>
<cfset M = Month>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->