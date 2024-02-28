<!--- April 29, 2009
Tested menu for CF8/Oracle
Added paths for revision history pages (_progrhlog.cfm, _progrhlog2.cfm, _prog_rh_master.cfm so prog menu appears on these pages
--->

<cfoutput>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<script language="JavaScript" src="webhelp/webhelp.js"></script>

<div align="center">
&nbsp;&nbsp;<a href="index.cfm">Main</a> :: <a href="calendar.cfm?type=All">Audit Calendar</a> :: <a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&auditor=All">Audit Schedule</a> :: <a href="Aprofiles.cfm?view=All">Auditor List</a> :: <a href="FAQ.cfm">FAQ</a> :: <a href="metrics_region.cfm">Metrics</a> :: <A HREF="javascript:popUp('webhelp/webhelp.cfm')">IQA Web Help</a><br>

<a href="_prog.cfm?list=all">UL Programs Master List</a> <!---:: 1/12/2009 <a href="TPTDP.cfm">TPTDP Certificates</a>---> :: <a href="admin/global_login.cfm">Login</a> :: <a href="audit_req.cfm">Request Audit</a> :: <a href="KBindex.cfm">Knowledge Base</a> :: <a href="CARFiles.cfm?Category=Plans">IQA Audit Plans</a><br>

<a href="Audit_List2.cfm?Year=#curyear#&type=all">Yearly List of Audits</a> :: <a href="getEmpNo.cfm?page=auditor_req">Request to be an Auditor</a> :: <a href="AuditNumber.cfm">Audit Lookup</a> :: <a href="../GCARMetrics/"><b>GCAR Metrics</b></a> :: <a href="AuditCoverage.cfm?year=#curyear#">IQA Coverage</a><br>
                              <br>
							  </div>
							  
	<cfif cgi.path_translated is "#path#_prog.cfm" or cgi.path_tranlated is "#path#_prog_detail.cfm" or cgi.path_translated is "#path#_ProgRHLog.cfm" or cgi.path_translated is "#path#_progRHLog2.cfm" or cgi.path_translated is "#path#_prog_rh_master.cfm">
<u>UL Programs Master List</u><br>
:: <a href="_prog.cfm?list=CPO">CPO Programs</a> (Certification Programs Office)<br>
:: <a href="_prog.cfm?list=CPCMR">CPC Programs</a> (Certification Programs Council)<br>
:: <a href="_prog.cfm?list=Silver">Silver/Bronze Programs</a><br>
:: <a href="_prog.cfm?list=IQA">Programs Audited by IQA</a><br>
:: <a href="_prog.cfm?list=All">All Programs (CPO, CPC-MR, Silver/Bronze)</a><br>
:: Revision History<br>
&nbsp; &nbsp; - <a href="_progRhLog.cfm">by Program</a><br>
&nbsp; &nbsp; - <a href="_progRhLog2.cfm">by Date</a><br>
&nbsp; &nbsp; - <a href="_prog_rh_master.cfm">Application Changes</a><br>
	</cfif>
</cfoutput><br />

<!--- toggle to Admin --->
<cfinclude template="incToggle.cfm">