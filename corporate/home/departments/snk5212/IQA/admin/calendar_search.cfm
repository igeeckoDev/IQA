<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Calendar Search">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<b><u>Search</u></b>:<br>
- <a href="calendar.cfm?type=All">All Audits</a><br>
- <a href="calendar.cfm?type=IQA">IQA Audits</a><br>
- <a href="select_site.cfm?page=calendar">Site/Region</a><br>
- <a href="calendar.cfm?type=LAB">Laboratory Technical Audits</a><br>
- <a href="calendar.cfm?type=VS">Verification Services Audits</a><br>
- <a href="calendar.cfm?type=ULE">UL Environment Audits</a><br>
- <a href="calendar.cfm?type=WiSE">WiSE Audits</a><br>
- <a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Corporate Finance Audits</a><br>
- <a href="calendar.cfm?type=FS&type2=FS">Field Service Regional Audits</a><br>
- <a href="calendar.cfm?type=FS&type2=All">All Field Service Audits</a><br>
- <a href="calendar.cfm?type=Accred&type2=AS">Accreditation Services (AS) Audits</a><br>
- <a href="calendar.cfm?type=Accred&type2=Non">External Accreditation (non-AS)</a><br>
- <a href="calendar.cfm?type=Accred&type2=All">All External Accreditation</a><br>
<!--- removed 11/17/2010 - <a href="calendar.cfm?type=TP">Third Party Test Data Program (TPTDP)</a><br>--->
- <a href="calendar.cfm?type=CBTL">CBTL Audits</a><br>
- <a href="calendar.cfm?type=QRS">QRS Internal Audits</a><br>
- <a href="select_auditor.cfm?page=calendar">By Auditor</a><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->