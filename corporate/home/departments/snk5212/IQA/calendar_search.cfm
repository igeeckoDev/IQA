<cfset subTitle = "Audit Calendar Search Criteria">
<cfset indent = " &nbsp; &nbsp; - ">
<cfset indent2 = "&nbsp;&nbsp;&nbsp; ">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>Calendar Views:</b><Br />
<cfoutput>
#indent#<a href="calendar.cfm?type=All">All Audits</a><br>
#indent#<a href="calendar.cfm?type=IQA">IQA Audits</a><br>
#indent#<a href="select_site.cfm?page=calendar">Site/Regional Audits</a><br>
#indent#<a href="calendar.cfm?type=LAB">Laboratory Technical Audits</a><br>
#indent#<a href="calendar.cfm?type=VS">Verification Services Audits</a><br>
#indent#<a href="calendary.cfm?type=ULE">UL Environment Audits</a><br>
#indent#<a href="calendar.cfm?type=WiSE">WiSE Audits</a><br>
#indent#<a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Corporate Finance Audits</a><br>
#indent#<a href="calendar.cfm?type=FS&type2=FS">Field Service Regional Audits</a><br>
#indent#<a href="calendar.cfm?type=FS&type2=All">All Field Service Audits</a> (includes IQA Field Service Audits)<br>
#indent#<a href="calendar.cfm?type=Accred&type2=AS">Accreditation Services (AS) Audits</a><br>
#indent#<a href="calendar.cfm?type=Accred&type2=Non">Accreditation (non-AS) Audits</a><br>
#indent#<a href="calendar.cfm?type=Accred&type2=All">All Accreditation Audits</a><br>
#indent#<a href="calendar.cfm?type=CBTL">CBTL Audits</a><br>
#indent#<a href="select_auditor.cfm?page=calendar">View By Auditor</a> (Internal Audits Only)<br><Br>
</cfoutput>

* Month and Year List Views can be chosen on all Calendar pages<br>

<!---- 1/12/2009 removed <a href="calendar.cfm?type=TP">Third Party Test Data Program (TPTDP)*</a><br>--->

<!--- removed 11/17/2010
* - <font color="red">Note: For information on TPTDP Audits after 2007, please contact <a href="mailto:Jodine.E.Hepner@ul.com">Jodi Hepner</a>. Information about TPTDP Audits and Reports Cards from 2004-2007 has been archived. Please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher Nicastro</a> for information.</font><br><br>
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->