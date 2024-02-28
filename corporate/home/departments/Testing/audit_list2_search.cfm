<cfset subTitle = "Yearly Audit List Search Criteria">
<cfset indent = " &nbsp; &nbsp; - ">
<cfset indent2 = "&nbsp;&nbsp;&nbsp; ">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>Audit Views:</b><Br />
<cfoutput>
#indent#<a href="audit_list2.cfm?type=All&year=#curyear#">All Audits</a><br>
#indent#<a href="audit_list2.cfm?type=IQA&year=#curyear#">IQA Audits</a><br>
#indent#<a href="select_site.cfm?page=audit_list2">Site/Regional Audits</a><br>
#indent#<a href="audit_list2.cfm?type=Medical&year=#curyear#">Medical Audits</a><br>
#indent#<a href="audit_list2.cfm?type=LAB&year=#curyear#">Laboratory Technical Audits</a><br>
#indent#<a href="audit_list2.cfm?type=VS&year=#curyear#">Verification Services Audits</a><br>
#indent#<a href="audit_list2.cfm?type=ULE&year=#curyear#">UL Environment Audits</a><br>
#indent#<a href="audit_list2.cfm?type=WiSE&year=#curyear#">WiSE Audits</a><br>
#indent#<a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Corporate Finance Audits</a><br>
#indent#<a href="audit_list2.cfm?type=FS&type2=FS&year=#curyear#">Field Service Regional Audits</a><br>
#indent#<a href="audit_list2.cfm?type=FS&type2=All&year=#curyear#">All Field Service Audits</a> (includes IQA Field Service Audits)<br>
#indent#<a href="audit_list2.cfm?type=Accred&type2=AS&year=#curyear#">Accreditation Services (AS) Audits</a><br>
#indent#<a href="audit_list2.cfm?type=Accred&type2=Non&year=#curyear#">Accreditation (non-AS) Audits</a><br>
#indent#<a href="audit_list2.cfm?type=Accred&type2=All&year=#curyear#">All Accreditation Audits</a><br>
#indent#<a href="audit_list2.cfm?type=CBTL&year=#curyear#">CBTL Audits</a><br>
#indent#<a href="select_auditor.cfm?page=audit_list2">View By Auditor</a> (Internal Audits Only (Corporate, Regional, and Field Services))<br><Br>
</cfoutput>

* Month and Year List Views can be chosen on all Calendar pages<br>

<!---- 1/12/2009 removed <a href="calendar.cfm?type=TP">Third Party Test Data Program (TPTDP)*</a><br>--->

<!--- removed 11/17/2010
* - <font color="red">Note: For information on TPTDP Audits after 2007, please contact <a href="mailto:Jodine.E.Hepner@ul.com">Jodi Hepner</a>. Information about TPTDP Audits and Reports Cards from 2004-2007 has been archived. Please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher Nicastro</a> for information.</font><br><br>
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->