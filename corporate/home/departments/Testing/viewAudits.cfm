<cfset subTitle = "View Audits">
<cfset indent = " &nbsp; &nbsp; - ">
<cfset indent2 = "&nbsp;&nbsp;&nbsp; ">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
Select Audit View:<br /><Br />

<b>Schedule Views</b><br />
#indent#<a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&auditor=All">Internal Quality Audits / IQA</a><Br />
#indent#<a href="schedule_view.cfm">View Audit Schedule for a Site/Region</a><br />
#indent#<a href="schedule.cfm?Year=#CurYear#&AuditedBy=Medical&auditor=All">Medical Audits</a><br />
<!---#indent#<a href="schedule.cfm?Year=#CurYear#&AuditedBy=LAB&auditor=All">Laboratory Technical Audit</a><br />--->
#indent#<a href="Schedule.cfm?Year=#CurYear#&AuditedBy=VS&Auditor=All">Verification Services (VS)</a><br />
#indent#<a href="Schedule.cfm?Year=#CurYear#&AuditedBy=ULE&Auditor=All">UL Environment (ULE)</a><br />
#indent#<a href="Schedule.cfm?Year=#CurYear#&AuditedBy=WiSE&Auditor=All">WiSE</a><br />
#indent#<a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Global Finance Internal Audit Schedule</a><br />
#indent#<a href="schedule.cfm?Year=#CurYear#&AuditedBy=Field Services&auditor=All">Field Services</a><br />
#indent#<a href="select_auditor.cfm?page=schedule">View Schedule By Auditor</a> (Internal Audits Only (Corporate, Regional, and Field Services))<br>
#indent2#<u>Accreditation Audits</u><br>
#indent#<a href="schedule.cfm?Year=#CurYear#&AuditedBy=AS&Auditor=All">Accreditation Services (AS) Audits</a> (ANSI / OSHA / SCC, Certification Related)<br />
#indent#<a href="schedule.cfm?Year=#CurYear#&AuditedBy=AllAccred&Auditor=All">All Accreditation Audits</a><Br /><br />

<b>List View - by Month/Year</b><Br />
#indent#<a href="Audit_List2.cfm?Year=#curyear#&type=all">All Audits</a><br>
#indent#<a href="Audit_List2.cfm?Year=#curyear#&type=IQA">Internal Quality Audits / IQA Audits</a><br>
#indent#<a href="Audit_List2_search.cfm">Select Search Criteria for Yearly List View</a><br>
<Br>

* Year can be selected on the above pages<br />
** List View criteria can be selected by choosing a Calendar View below, then selecting 'Year View - Audit List'<br><br />

<b>Audit Schedule Matrix for IQA/DAP Audits (new - 2015+ audits)</b><br>
#indent#<a href="AuditMatrix.cfm?Year=#curYear#">IQA Audits</a><br>
#indent#<a href="AuditMatrix_DAP.cfm?Year=#curYear#">DAP Audits</a><br><br>

Note - the Audit Schedule Matrix can be filtered by Office, Program/Scheme, Audit Type, Month, and Auditor.<br><br>

<b>Audit Lookup by Audit Number</b><br />
#indent#<a href="AuditNumber.cfm">Audit Lookup by Audit Number</a><br><br />

<b>Calendar Views:</b><Br />
#indent#<a href="calendar.cfm?type=All">All Audits</a><br>
#indent#<a href="calendar.cfm?type=IQA">Internal Quality Audits / IQA Audits</a><br>
#indent#<a href="select_site.cfm?page=calendar">Site/Regional Audits</a><br>
#indent#<a href="calendar.cfm?type=Medical">Medical Audits</a><br>
#indent#<a href="calendar.cfm?type=LAB">Laboratory Technical Audits (LAB)</a><br>
#indent#<a href="calendar.cfm?type=VS">Verification Services (VS) Audits</a><br>
#indent#<a href="calendar.cfm?type=ULE">UL Environment (ULE) Audits</a><br>
#indent#<a href="calendar.cfm?type=WiSE">WiSE Audits</a><br>
#indent#<a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Internal Audit / Corporate Finance Audits</a><br>
#indent#<a href="calendar.cfm?type=FS&type2=FS">Field Service Regional Audits</a><br>
#indent#<a href="calendar.cfm?type=FS&type2=All">All Field Service Audits</a> (includes IQA Field Service Audits)<br>
#indent#<a href="calendar.cfm?type=Accred&type2=AS">Accreditation Services (AS) Audits (ANSI / OSHA / SCC, Certification Related)</a><br>
#indent#<a href="calendar.cfm?type=Accred&type2=Non">Accreditation (non-AS) Audits</a><br>
#indent#<a href="calendar.cfm?type=Accred&type2=All">All Accreditation Audits</a><br>
#indent#<a href="calendar.cfm?type=CBTL">CBTL Audits</a><br>
#indent#<a href="select_auditor.cfm?page=calendar">View By Auditor</a> (Internal Audits Only (Corporate, Regional, and Field Services))<br><Br>

* Month and Year List Views can be chosen on all Calendar pages<br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->