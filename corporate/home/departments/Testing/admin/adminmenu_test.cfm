<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "AS">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=AS&auditor=All">Accreditation Audit Schedule</a><br>
:: <a href="calendar.cfm?type=all">Audit Calendar</a><br>
:: <a href="ASAccred.cfm">Manage AS Accreditors</a><br>
:: <a href="ASContact.cfm">Manage AS Contacts</a><br>
:: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="KBindex.cfm">Knowledge Base</a><br>
:: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br><br>
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>
</cfoutput>
<CFELSEIF SESSION.Auth.AccessLevel is "CPO">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
:: <a href="_prog.cfm?list=CPO">CPO Programs</a><br>
:: <a href="_prog.cfm?list=CPCMR">CPC Programs</a><br>
:: <a href="_prog.cfm?list=Silver">Silver/Bronze Programs</a><br>
:: <a href="_prog.cfm?list=IQA">Programs Audited by IQA</a><br>
:: <a href="_prog.cfm?list=all">All Programs</a><br>
<!---:: <a href="prog_add.cfm">Add Program</a><br>--->
:: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br><br>
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>

<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "QRS">

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=QRS&auditor=All">QRS Audit Schedule</a><br>
:: <a href="calendar.cfm?type=all">Audit Calendar</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="aqrs.cfm">Auditor List</a><br>
:: <a href="qrs_office.cfm">Offices/Regions</a><br>
:: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br><br>
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>
</cfoutput>
<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "Field Services">

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=Field Services&auditor=All">Field Service Audit Schedule</a><br>
:: <a href="calendar.cfm?type=FS&type2=FS">Audit Calendar</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="aprofiles.cfm?view=Field Services">Auditor List</a><br>
<!---:: <a href="fus.cfm">IC Regions/Locations</a> (old)<br>--->
:: <a href="fus2.cfm">IC Locations</a> (new)<br>
:: <a href="FSPlan.cfm">Field Service Plan</a><br>
:: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br><br>
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>
</cfoutput>
<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "Finance">

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=Finance&auditor=All">Corporate Finance Audit Schedule</a><br>
:: <a href="calendar.cfm?type=Finance">Audit Calendar</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="FContacts.cfm">Corporate Finance Auditor List</a><br>
:: <a href="metrics_finance.cfm?Year=#CurYear#&AuditedBy=Finance">Schedule Attainment Metrics</a><br>
:: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br><br>
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>
</cfoutput>
<CFelseIF SESSION.Auth.accesslevel is "Auditor">

<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
<table width="600">
<tr>
<td width="300" class="blog-content" valign="top" align="left">
 :: <a href="admin.cfm">Main</a><br>
 :: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br> 
 :: <a href="schedule.cfm?Year=#CurYear#&Auditor=#SESSION.AUTH.Name#&AuditedBy=IQA">Audit Schedule</a><br>
 :: <a href="calendar.cfm?type=all">Audit Calendar</a><br>
 :: <a href="KBindex.cfm">Knowledge Base</a><br>
</td>
<td width="300" class="blog-content" valign="top" align="left">
 :: <a href="Status.cfm?year=#curyear#">Scope Letter, Follow Up, and Report Status</a><br>
 :: <a href="prog.cfm?list=IQA&order=">IQA Program List</a><br>
 :: <a href="select_office.cfm">Audit Plan/Coverages/Contacts</a><br>
 :: <a href="iReport_select.cfm">Internal Audit Summary Report</a><br>
 :: <a href="iReportProg_select.cfm">Program Audit Summary Report</a><br>
 :: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
</td>
</tr>
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>
</cfoutput>
<CFelseIF SESSION.Auth.accesslevel is "IQAAuditor">

<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
<table width="600">
<tr>
<td width="300" class="blog-content" valign="top" align="left">
 :: <a href="admin.cfm">Main</a><br>
 :: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a><br> 
 :: <a href="schedule.cfm?Year=#CurYear#&Auditor=#SESSION.AUTH.Name#&AuditedBy=IQA">Audit Schedule</a><br>
 :: <a href="calendar.cfm?type=all">Audit Calendar</a><br>
<cfif SESSION.Auth.Username is "Carlisle">
 :: <a href="FUS2.cfm">IC Locations</a><br>
</cfif> 
 :: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
</td>
<td width="300" class="blog-content" valign="top" align="left">
 :: <a href="KBindex.cfm">Knowledge Base</a><br>
 :: <a href="Status.cfm?year=#curyear#">Scope Letter, Follow Up, and Report Status</a><br>
 :: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
 :: <a href="select_office.cfm">Audit Plan/Coverages/Contacts</a><br>
 :: <a href="iReport_select.cfm">Internal Audit Summary Report</a><br>
 :: <a href="iReportProg_select.cfm">Program Audit Summary Report</a><br>
</td>
</cfoutput>
</tr>
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>

<cfelseif SESSION.Auth.AccessLevel is "RQM" or SESSION.Auth.AccessLevel is "OQM">

<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="center">
<a href="schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&auditor=All">Audit Schedule</a></cfoutput>
 :: <a href="calendar.cfm?type=all">Audit Calendar</a> :: <a href="Aprofiles.cfm?view=All">Auditor List</a> :: <a href="metrics_region.cfm">Metrics</a> :: <a href="Accred.cfm">View Accreditors</a><br><a href="NotApproved.cfm">Audits Awaiting Approval</a> :: <a href="KBindex.cfm">Knowledge Base</a> :: <a href="select_office.cfm">Location Information</a><br> <a href="_prog.cfm?list=all">UL Programs Master List</a> :: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a> <cfinclude template="user_credentials.cfm">
</td>
</tr>
</table>

<cfelse>

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="center">
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
&nbsp;&nbsp;<a href="admin.cfm">Main</a> :: <cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#><a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&auditor=All">Audit Schedule</a></cfoutput> :: <a href="calendar.cfm?type=all">Audit Calendar</a> :: <a href="Aprofiles.cfm?View=All">Auditor List</a> :: <a href="FAQ.cfm">FAQ</a> :: <a href="KBindex.cfm">Knowledge Base</a><br><a href="alert_view.cfm">Auditor Alerts</a> :: <a href="metrics_region.cfm">Metrics</a> :: <a href="TPTDP.cfm">TPTDP Locations and Certificates</a> :: <a href="auditor_req_view.cfm">Auditor Requests</a> :: <A HREF="javascript:popUp('../webhelp/webhelp.cfm')">IQA Web Help</a> <cfinclude template="user_credentials.cfm">
</td>
</tr>
<tr>
<td width="300" class="blog-content" valign="top" align="left">
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
<cfoutput>
:: <a href="Status.cfm?year=#curyear#">Scope Letter, Follow Up, and Report Status</a><br>
:: <a href="Status2.cfm?year=#curyear#&month=#curmonth#">Audit Scope and Report Completion Status</a><br>
</cfoutput>
<CFIF SESSION.Auth.accesslevel is "SU">
:: <a href="baseline.cfm?year=#curyear#">Schedule Baseline</a><br>
</CFIF>
:: <a href="info_output.cfm">Information Request</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="Lists.cfm">Manage Lists</a><br>
&nbsp;&nbsp; - Functions, Programs, Accred Lists, KPs, RDs<br>
<CFIF SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.AccessLevel is "SU">
<cfoutput>
:: <a href="iqa_list.cfm?year=#curyear#">IQA Audit List</a><br>
</cfoutput>
:: <a href="select_office.cfm">Offices/Regions</a><br>
&nbsp;&nbsp; - Notification, Coverage, Plan<br>
:: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
:: <a href="iReport_select.cfm">Internal Audit Summary Report</a><br>
:: <a href="iReportProg_select.cfm">Program Audit Summary Report</a><br>
</cfif>
<cfelse>
</cfif>
</cflock>

<img src="../images/spacer.gif" width="300" height="0" border="0" align="left">
</td>
<td width="300" class="blog-content" valign="top" align="left">
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU">
:: <a href="backup.cfm">Backup Database</a><br>
:: <a href="file_upload_Admin.cfm">Upload Files</a> (<a href="file.cfm">multiple upload</a>)<br>
:: <a href="delete_file.cfm">Delete Files</a><br>
:: <a href="manage.cfm">Change Password/Manage Accounts</a><br>
:: <a href="user_select.cfm">Access Log</a><br>
:: <a href="changelist.cfm">Change Log File List</a><br>
:: <a href="view_stats.cfm">Page Views</a><br>
:: <a href="error_list.cfm">Error Reporting</a>
</cfif>
</cflock>

</td>
</tr>
<tr><td colspan="2" class="blog-content" align="left">
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.AccessLevel is "SU">
	<cfif cgi.path_translated is "#path#lists.cfm">
<u>Manage Database Control Lists</u><br>	
:: <a href="KPRD.cfm">Key Processes and Reference Documents Lists</a><br>
:: <a href="prog.cfm?list=IQA&order=">Programs List</a><br>
:: <a href="cf.cfm">Corporate Functions</a><br>
:: <a href="gf.cfm">Global Function/Processs</a><br>
:: <a href="lf.cfm">Local Functions</a><br>
:: <a href="ASAccred.cfm">Manage AS Accreditors</a><br>
:: <a href="Accred.cfm">Manage Non-AS Accreditors</a><br>
	<cfelseif cgi.path_translated is "#path#prog.cfm">
<u>Program Lists</u><br>
:: <a href="prog.cfm?list=CPO&order=">UL Programs Master List</a><br>
:: <a href="prog.cfm?list=CPCMR&order=">CPC-MR</a><br>
:: <a href="prog.cfm?list=Silver&order=">Silver</a><br>
:: <a href="prog.cfm?list=IQA&order=">Programs Audited by IQA</a><br>
:: <a href="prog.cfm?list=All&order=">All Programs (IQA+CPO)</a><br>
	<cfelseif cgi.path_translated is "#path#_prog.cfm" or cgi.path_tranlated is "#path#_prog_detail.cfm">
<u>UL Programs Master List</u><br>
:: <a href="_prog.cfm?list=CPO">CPO Programs</a> (Certification Programs Office)<br>
:: <a href="_prog.cfm?list=CPCMR">CPC Programs</a> (Certification Programs Council)<br>
:: <a href="_prog.cfm?list=Silver">Silver/Bronze Programs</a><br>
:: <a href="_prog.cfm?list=IQA">Programs Audited by IQA</a><br>
:: <a href="_prog.cfm?list=All">All Programs (CPO, CPC-MR, Silver/Bronze)</a><br>
:: <a href="_prog.cfm?list=removed">Removed Programs</a><br>
:: <a href="_progRhLog.cfm">Program Revision History Log</a> (excludes Rev 1/Initial Release)<br>
	</cfif>
</cfif>
</cflock>
</td></tr>
</table>
</cfif>
</cflock>
