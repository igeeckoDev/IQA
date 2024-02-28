<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "Technical Audit">
	<cflocation url="TechnicalAudits_Test.cfm" addtoken="no">
<CFELSEIF SESSION.Auth.accesslevel is "AS">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=AS&auditor=All">Accreditation Audit Schedule</a><br>
:: <a href="AS_AddAudit.cfm"><b>Add Audit</b></a><Br />
:: <a href="calendar.cfm?type=all">Audit Calendar</a><br>
:: <a href="AuditNumber.cfm">Audit Lookup</a><br>
:: <a href="Audit_List2.cfm?type=Accred&type2=AS&year=#curYear#">Yearly List of Audits</a><br>
:: <a href="ASAccred.cfm">Manage AS Accreditors</a><br>
:: <a href="ASContact.cfm">Manage AS Contacts</a><br>
:: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="KBindex.cfm">Knowledge Base</a><br>
:: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><Br />

<cfinclude template="../approval.cfm">
<br />
<hr />
</cfoutput>

</td>
</tr>
</table>

<CFELSEIF SESSION.Auth.AccessLevel is "CPO">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
:: <a href="_prog.cfm?list=CPO">CPO Programs</a><br>
:: <a href="_prog.cfm?list=CPCMR">CPC Programs</a><br>
:: <a href="_prog.cfm?list=Silver">Silver/Bronze Programs</a><br>
:: <a href="_prog.cfm?list=IQA">Programs Audited by IQA</a><br>
:: <a href="_prog.cfm?list=all">All Programs</a><br>
:: Program List Revision History<br>
&nbsp;&nbsp; :: <a href="_progRHLog.cfm">by Program</a><br>
&nbsp;&nbsp; :: <a href="_progRHLog2.cfm">by Revision Date</a><br>
:: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br>

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
:: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br>
</cfoutput>

</td>
</tr>
</table>

<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "Field Services">

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="addaudit.cfm?auditedby=Field Services">Add Audit</a><br />
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=Field Services&auditor=All">Field Service Audit Schedule</a><br>
:: <a href="calendar.cfm?type=FS&type2=FS">Audit Calendar</a><br>
:: <a href="Audit_List2.cfm?type=FS&type2=FS&year=#curYear#">Yearly List of Audits</a><br>
:: <a href="AuditNumber.cfm">Audit Lookup</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="aprofiles.cfm?view=Field Services">Auditor List</a><br>
:: <a href="fus2.cfm">IC Locations</a><br>
:: <a href="FSPlan.cfm">Field Service Audit Plan</a><br>
:: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><br />

<cfinclude template="../approval.cfm">
</cfoutput>

</td>
</tr>
</table>

<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "Finance">

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <a href="F_AddAudit.cfm?AuditedBy=Finance">Add Audit</a><br />
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="FContacts.cfm">Auditor List</a><Br />
:: <a href="AuditNumber.cfm">Audit Lookup</a> (by Audit Number)<br>
<!---
:: <a href="metrics_finance.cfm?Year=#CurYear#&AuditedBy=Finance">Schedule Attainment Metrics</a><br>
--->
:: <a href="calendar.cfm?type=Finance">View Audits - Calendar View</a><br>
:: <a href="Audit_List2.cfm?Year=#curyear#&type=Finance">View Audits - List View</a><br>
:: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=Finance&auditor=All">View Audits - Schedule View</a><br>
:: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><br />

<cfinclude template="../approval.cfm">
<br />
</cfoutput>

</td>
</tr>
</table>

<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "Laboratory Technical Audit">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <u>Audits</u><br>
&nbsp;&nbsp; - <a href="LTA_AddAudit.cfm">Add Laboratory Technical Audit (LTA)</a><br>
&nbsp;&nbsp; - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=LAB&auditor=All">Laboratory Technical Audit (LTA) Schedule View</a><br>
&nbsp;&nbsp; - <a href="calendar.cfm?type=LAB">LTA Calendar View</a><br>
&nbsp;&nbsp; - <a href="Audit_List2.cfm?Year=#curyear#&type=LAB">LTA List View by Year</a><br>
:: <u>Source Lists</u><br>
&nbsp;&nbsp; - <a href="Auditors.cfm?Type=LTA">LTA Auditor List</a><br>
:: <u>Search</u><br />
&nbsp;&nbsp; - <a href="AuditNumber.cfm">Lookup Audit by Audit Number</a><br>
&nbsp;&nbsp; - <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
&nbsp;&nbsp; - <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><br />

<cfinclude template="../approval.cfm">
</cfoutput>
</td>
</tr>
</table>

<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "Verification Services">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <u>Audits</u><br>
&nbsp;&nbsp; - <a href="VS_AddAudit.cfm">Add Verification Services (VS) Audit</a><br>
&nbsp;&nbsp; - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=VS&auditor=All">VS Audits Schedule View</a><br>
&nbsp;&nbsp; - <a href="calendar.cfm?type=VS">VS Audits Calendar View</a><br>
&nbsp;&nbsp; - <a href="Audit_List2.cfm?Year=#curyear#&type=VS">VS Audits List View by Year</a><br>
:: <u>Source Lists</u><br>
&nbsp;&nbsp; - <a href="Auditors.cfm?Type=VS">VS Auditor List</a><br>
:: <u>Search</u><br />
&nbsp;&nbsp; - <a href="AuditNumber.cfm">Lookup Audit by Audit Number</a><br>
&nbsp;&nbsp; - <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
&nbsp;&nbsp; - <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><br />
</cfoutput>
</td>
</tr>
</table>

<!---
<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "UL Environment">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <u>Audits</u><br>
&nbsp;&nbsp; - <a href="ULE_AddAudit.cfm">Add ULE Internal Audit</a><br>
&nbsp;&nbsp; - <a href="Accred_AddAudit.cfm?AuditedBy=ULE">Add ULE Accreditor Audit</a><br>
&nbsp;&nbsp; - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=ULE&auditor=All">ULE Audits Schedule View</a><br>
&nbsp;&nbsp; - <a href="calendar.cfm?type=ULE">ULE Audits Calendar View</a><br>
&nbsp;&nbsp; - <a href="Audit_List2.cfm?Year=#curyear#&type=ULE">ULE Audits List View by Year</a><br>
:: <u>Source Lists</u><br>
&nbsp;&nbsp; - <a href="Auditors.cfm?Type=ULE">ULE Auditor List</a><br>
&nbsp;&nbsp; - <a href="accred.cfm">View Accredtiors</a><br>
:: <u>Search</u><br />
&nbsp;&nbsp; - <a href="AuditNumber.cfm">Lookup Audit by Audit Number</a><br>
&nbsp;&nbsp; - <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
&nbsp;&nbsp; - <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><br />
</cfoutput>
</td>
</tr>
</table>
--->

<CFELSEIF SESSION.AUTH.ACCESSLEVEL is "WiSE">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
:: <u>Audits</u><br>
&nbsp;&nbsp; - <a href="WiSe_AddAudit.cfm">Add WiSE Technical Audit</a><br>
&nbsp;&nbsp; - <a href="Accred_AddAudit.cfm?AuditedBy=WiSE">Add WiSE Accreditor Audit</a><br>
&nbsp;&nbsp; - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=WiSE&auditor=All">WiSE Audits Schedule View</a><br>
&nbsp;&nbsp; - <a href="calendar.cfm?type=WiSE">WiSE Audits Calendar View</a><br>
&nbsp;&nbsp; - <a href="Audit_List2.cfm?Year=#curyear#&type=WiSE">WiSE Audits List View by Year</a><br>
:: <u>Source Lists</u><br>
&nbsp;&nbsp; - <a href="Auditors.cfm?Type=WiSE">WiSE Auditor List</a><br>
&nbsp;&nbsp; - <a href="accred.cfm">View Accreditors</a><br>
:: <u>Search</u><br />
&nbsp;&nbsp; - <a href="AuditNumber.cfm">Lookup Audit by Audit Number</a><br>
&nbsp;&nbsp; - <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
&nbsp;&nbsp; - <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br><br />
</cfoutput>
</td>
</tr>
</table>

<CFelseIF SESSION.Auth.accesslevel is "Auditor">
<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
<table width="600">
<tr>
<td width="300" class="blog-content" valign="top" align="left">
 :: <a href="admin.cfm">Main</a><br>
 :: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br>
 :: <a href="schedule.cfm?Year=#CurYear#&Auditor=#SESSION.AUTH.Name#&AuditedBy=IQA">Audit Schedule</a><br>
 :: <a href="calendar.cfm?type=all">Audit Calendar</a><br>
 :: <a href="Audit_List2.cfm?Year=#curyear#&type=all">Yearly List of Audits</a><br>
 :: <a href="AuditNumber.cfm">Audit Lookup</a><br>
 :: <a href="KBindex.cfm">Knowledge Base</a><br>
</td>
<td width="300" class="blog-content" valign="top" align="left">

 :: <a href="Status.cfm?year=#curyear#">Scope Letter, Follow Up, and Report Status</a><br>
 :: <a href="_prog.cfm?list=IQA&order=">IQA Program List</a><br>
 :: <a href="select_office.cfm">UL Offices</a><br>
 &nbsp;&nbsp; - SNAP, Notifications, Coverage, Plan<br>
<!---
 :: <a href="iReport_select.cfm">Internal Audit Summary Report</a><br>
 :: <a href="iReportProg_select.cfm">Program Audit Summary Report</a><br>
--->
 :: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
</td>
</tr>
</cfoutput>
</table>

<CFelseIF SESSION.Auth.accesslevel is "IQAAuditor">

Please use the "IQA Admin" menu on the horizontal (red) menu above. If you are missing any menu items, please contact Kai Huang.

<br><br>

<!--- for NON IE browsers --->
<!--[if !(IE)]><!--><hr width="50%" align="center"><br><!--><![endif]-->

<!--- for IE browser --->
<!--[if (IE)]><hr class='dash'><![endif]-->

<!---
<CFQUERY BLOCKFACTOR="100" NAME="ID" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE Auditor = '#SESSION.Auth.Name#'
</cfquery>


<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
<table width="600">
<tr>
<td width="300" class="blog-content" valign="top" align="left">
:: <a href="admin.cfm">Main</a><br>
<u>My Audits</u><br>
:: <a href="schedule.cfm?Year=#CurYear#&Auditor=#SESSION.AUTH.Name#&AuditedBy=IQA">Schedule</a><br>
:: <a href="calendar.cfm?type=auditor&type2=#SESSION.AUTH.Name#">Calendar</a><br>
:: <a href="Audit_List2.cfm?Month=#curmonth#&Year=#curyear#&type=auditor&type2=#SESSION.AUTH.Name#">Year List</a><br>
<u>All Audits</u><br>
:: <a href="schedule.cfm?Year=#curyear#&AuditedBy=IQA">Schedule</a><br>
:: <a href="calendar.cfm?type=all">Calendar</a><br>
:: <a href="Audit_List2.cfm?Year=#curyear#&type=all">Yearly List of Audits</a><br>
<u>SRs Generated by IQA Audits</u><br>
:: <a href="SRMenu.cfm">View</a><Br>
<cfif SESSION.Auth.Username is "Carlisle">
:: <a href="FUS2.cfm">IC Locations</a><br>
</cfif>
<u>Audit Related</u><br>
:: <a href="AuditNumber.cfm">Audit Lookup by Number</a><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
<u>Auditor Profiles</u><br>
:: <a href="AProfiles_detail.cfm?ID=#ID.ID#">My Auditor Profile</a><br>
:: <a href="AProfiles.cfm?view=all">View All</a><br>
<!---
 :: <a href="iReport_select.cfm">Internal Audit Summary Report</a><br>
 :: <a href="iReportProg_select.cfm">Program Audit Summary Report</a><br>
--->
</td>
<td width="300" class="blog-content" valign="top" align="left">
<u>Scope and Report Status</u><Br>
:: <a href="Status.cfm?year=#curyear#">Scope Letter, Follow Up, and Report Status</a><br>
<u>Scope and Report Completion Status</u><br>
:: <a href="Status2.cfm?year=#curyear#&month=#curmonth#">by Month</a><br>
:: <a href="Status2year.cfm?year=#curyear#">by Year</a><br>
<u>Other</u><br>
:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
:: <a href="calibration_index.cfm">IQA Calibration Meetings</a><br>
:: <a href="KBindex.cfm">Knowledge Base</a><br>
:: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
:: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a><br>
<u>Lists</u><br>
:: <a href="Audit_List2.cfm?Year=#curyear#&type=IQA">IQA Yearly Audit List</a><br>
:: <a href="select_office.cfm">UL Office Related</a> (SNAP, IC, Notifications, Coverage, Plans)<br>
<!---
<u>UL Accreditations</u><br />
:: <a href="AccredLocations/index.cfm">View</a><br />
--->
</td>
</tr>
</cfoutput>
</table>
--->

<cfelseif SESSION.Auth.AccessLevel is "RQM" or SESSION.Auth.AccessLevel is "OQM">

<cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#>
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">

<!--- get Auditor Profile ID --->
<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
SELECT ID
FROM AuditorList
WHERE Auditor = '#SESSION.Auth.Name#'
</cfquery>
<!--- /// --->

:: <a href="addaudit.cfm?AuditedBy=#SESSION.Auth.SubRegion#"><b>Add Audit for #SESSION.Auth.SubRegion# Region</b></a><br />
<!---:: <a href="ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a><br />--->
:: <a href="Accred.cfm">View/Add Accreditors</a><br>
:: <a href="Aprofiles.cfm?View=All">View/Manage Auditor List</a><br />

<cfif SESSION.Auth.Region NEQ "Medical" AND SESSION.Auth.Region NEQ "UL Environment">
:: <a href="Auditor_Req_View.cfm">Auditor Requests</a><br />
</cfif>

:: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br />

<!---
:: <a href="metrics.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#">Schedule Attainment Metrics</a><br />
--->

<!---
:: <a href="AccredLocations/index.cfm">UL Accreditations</a><br />
--->
:: <a href="Select_Office.cfm">UL Location Information / Site Profiles</a><br />

<cfif SESSION.Auth.Region Eq "Medical" OR SESSION.Auth.Region eq "UL Environment">
:: <a href="#IQADir#Calendar.cfm?Type=#Session.Auth.SubRegion#&Type2=#SESSION.Auth.SubRegion#">#SESSION.Auth.SubRegion# Audits - Calendar View</a><br />
<cfelse>
:: <a href="#IQADir#Calendar.cfm?Type=SubRegion&Type2=#SESSION.Auth.SubRegion#">#SESSION.Auth.SubRegion# Audits - Calendar View</a><br />
</cfif>

:: <a href="#IQADir#Audit_List2.cfm?Year=#CurYear#&Type=#Session.Auth.SubRegion#&Type2=#SESSION.Auth.SubRegion#">#SESSION.Auth.SubRegion# Audits - List View</a><br />
:: <a href="#IQADir#Schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&Auditor=All">#SESSION.Auth.SubRegion# Audits - Schedule View</a><br />

<cfif SESSION.Auth.Region NEQ "Medical" AND SESSION.Auth.Region NEQ "UL Environment">
	:: <a href="#IQADir#Audit_List2.cfm?Year=#CurYear#&Type=Auditor&Type2=#SESSION.Auth.Name#">Your Audits - #CurYear#</a><br />
</cfif>

<cfif AuditorProfile.recordCount eq 1>
:: <a href="AProfiles_Detail.cfm?ID=#AuditorProfile.ID#">Your Auditor Profile</a><br />
</cfif><br />

<!---
<a href="schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&auditor=All">Audit Schedule</a>
 :: <a href="calendar.cfm?type=all">Audit Calendar</a> :: <a href="Aprofiles.cfm?view=All">Auditor List</a> :: <a href="metrics_region.cfm">Metrics</a> :: <a href="Accred.cfm">View Accreditors</a><br>

<a href="NotApproved.cfm">Audits Awaiting Approval</a> :: <a href="KBindex.cfm">Knowledge Base</a> :: <a href="select_office.cfm">UL Location Information</a> :: <a href="Audit_List2.cfm?Year=#curyear#&type=all">Yearly List of Audits</a><br>

<a href="auditor_req_view.cfm">Auditor Requests</a> :: <a href="_prog.cfm?list=all">UL Programs Master List</a> :: <a href="AuditNumber.cfm">Audit Lookup</a>  :: <a href="AccredLocations/index.cfm">UL Accreditations</a> :: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a>

<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.Andon eq "Yes">
		 :: <a href="Andon_Add.cfm">Andon Audit Checklist</a>
	</cfif>
</cflock>
--->
</cfoutput>
</td>
</tr>
</table>

<cfelse>

<table width="600">
<!---
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="center">
<cfinclude template="../approval.cfm"><br />

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
&nbsp;&nbsp;<a href="admin.cfm">Main</a> :: <cfoutput><cfset CurYear = #Dateformat(now(), 'yyyy')#><a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&auditor=All">Audit Schedule</a> :: <a href="calendar.cfm?type=all">Audit Calendar</a> :: <a href="Aprofiles.cfm?View=All">Auditor List</a> :: <a href="FAQ.cfm">FAQ</a> :: <a href="KBindex.cfm">Knowledge Base</a><br>

<!---<a href="AccredLocations/index.cfm">UL Accreditations</a> :: --->
<!---<a href="alert_view.cfm">Auditor Alerts</a> :: --->
<a href="metrics_region.cfm">Metrics</a> <!--- 1/12/2009 :: <a href="TPTDP.cfm">TPTDP Locations and Certificates</a>---> :: <a href="auditor_req_view.cfm">Auditor Requests</a> :: <a href="Audit_List2.cfm?Year=#curyear#&type=all">Yearly List of Audits</a> <!---:: <cfoutput><a href="#CARDir#ASReports.cfm?Year=#curyear#">AS Reports</a></cfoutput>---><br>

<a href="AuditNumber.cfm">Audit Lookup</a> :: <A HREF="../webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a>

<cflock scope="Session" timeout="5">
		<cfif SESSION.Auth.AccessLevel eq "SU"
			OR SESSION.Auth.UserName eq "Fehrenbacher">
		:: <a href="CARFiles_AuditorPerformance.cfm">Auditor Performance</a>
		</cfif>
</cflock>

<cflock scope="Session" timeout="5">
		<cfif SESSION.Auth.AccessLevel eq "SU">
		:: <a href="CARFiles_CARAdminPerformance.cfm">CAR Administrator Performance</a>
		</cfif>
</cflock>

<!---
<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.Andon eq "Yes">
		 :: <a href="Andon_Add.cfm">Andon Audit Checklist</a>
	</cfif>
</cflock>
--->
</cfoutput>
</td>
</tr>--->
<tr>

<td>
Please use the "IQA Admin" menu on the horizontal (red) menu above. If you are missing any menu items, please contact Chris Nicastro.

<br><br>

<!--- for NON IE browsers --->
<!--[if !(IE)]><!--><hr width="50%" align="center"><br><!--><![endif]-->

<!--- for IE browser --->
<!--[if (IE)]><hr class='dash'><![endif]-->
</td>

<!---
<td width="300" class="blog-content" valign="top" align="left">
<cfoutput>
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
    <u>Scope and Report Status</u><Br>
    :: <a href="Status.cfm?year=#curyear#">Scope Letter, Follow Up, and Report Status</a><br>
    <u>Scope and Report Completion Status</u><br>
    :: <a href="Status2.cfm?year=#curyear#&month=#curmonth#">by Month</a><br>
    :: <a href="Status2year.cfm?year=#curyear#">by Year</a><br>
    <u>Other</u><br>
    <cfif SESSION.Auth.UserName eq "Fehrenbacher">
    :: <a href="../Planning/Distribution_2014.cfm?Type=Program">Yearly Audit Planning</a><br />
    </cfif>
    :: <a href="NotApproved.cfm">Audits Awaiting Approval</a><br>
    :: <a href="info_output.cfm">Information Request</a> (Archive)<br>
    :: <a href="calibration_index.cfm">IQA Calibration Meetings</a><Br>
        <cfif curyear lte 2012>
            :: <a href="DAP_SNAP_Coverage.cfm?Year=#curyear#">OSHA SNAP Coverage Table</a>
        <cfelse>
            :: <a href="DAP_SNAP_Coverage2013_currentYear.cfm?Year=#curyear#">OSHA SNAP Coverage Table</a>
        </cfif><br />
    <u>SRs Generated by IQA Audits</u><br>
    <cfoutput>
    :: <a href="SRMenu.cfm">View</a><Br>
    </cfoutput>
    <u>Source List Controls</u><br>
    :: <a href="viewControlPanel.cfm">Manage Lists</a> (Functions, Accreditors)<br>
    :: <a href="select_office.cfm">UL Office Related</a> (SNAP, IC, Notifications, Coverage, Plans)<br>
    <u>Lists</u><br>
    :: <a href="Audit_List2.cfm?Year=#curyear#&type=IQA">IQA Yearly Audit List</a><br>
    :: <a href="_prog.cfm?list=all">UL Programs Master List</a><br>
    :: <a href="AuditCoverage_Programs.cfm?list=IQA">IQA Audited Programs Coverage</a><br><br>
    <!---
    :: <a href="iReport_select.cfm">Internal Audit Summary Report</a><br>
    :: <a href="iReportProg_select.cfm">Program Audit Summary Report</a><br>
    --->
    </cfif>
</cflock>
</cfoutput>

<img src="../images/spacer.gif" width="300" height="0" border="0" align="left">

</td>
<td width="300" class="blog-content" valign="top" align="left">
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU">
<!---
:: <a href="backup.cfm">Backup Database</a><br>
:: <a href="file_upload_Admin.cfm">Upload Files</a> (<a href="file.cfm">multiple upload</a>)<br>
:: <a href="delete_file.cfm">Delete Files</a><br>
:: <a href="changelist.cfm">Change Log File List</a><br>
--->
<cfif SESSION.Auth.AccessLevel eq "SU">
<u>DB Query - SQL</u><br>
:: <a href="SQL.cfm">Run SQL (No Output - Update/Delete/Insert)</a><br>
:: <a href="SQL2.cfm">CFDUMP/SQL (Select)</a><br>
<u>Other Admin Items</u><br>
:: <a href="ViewUsers.cfm">Manage Accounts</a><br>
<!---
:: <a href="view_stats.cfm">Page Views</a><br>
--->
:: <a href="error_list.cfm">Error Reporting</a><br>
</cfif>
<cfoutput>
:: <a href="baseline.cfm?year=#curyear#">Schedule Baseline</a><br>
:: <a href="#IQARootDir#Planning/Distribution_2014.cfm?Type=Program">Yearly Audit Planning</a><br />
</cfoutput>
<!---
<u>IQA Emails</u><br />
:: <a href="SendEmail.cfm">Send Email</a><br />
:: <a href="SendEmail_View.cfm">View Emails</a><br>
--->
<u>QE Files / IQA Audit Plans</u><br />
:: <a href="ViewFileCategories.cfm">Audit and CAR Related Files</a><br>
:: <a href="CARFilesCategories.cfm">View/Add Categories for Audit and CAR Related Files</a><br>
<!---
<u>UL Accreditations</u><br />
:: <a href="AccredLocations/index.cfm">UL Accreditations</a><br />
--->
<!--- hidden since we ran this on 12/19/2008, for 2009
<br>
:: <a href="AutoAdd.cfm"><font color="red">Add 2008 Audits to 2009</font> *</a><br>
&nbsp;&nbsp; * do not reload this page
<--->
</cfif>
</cflock>

</td>--->

</tr>
</table>
</cfif>
</cflock>