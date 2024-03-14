<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<cfoutput>
	<title>#Request.SiteTitle#</title>
	<META NAME="description" CONTENT="#Request.MetaDescription#">
	<META NAME="keywords" CONTENT="#Request.MetaKeywords#">
	<link rel="stylesheet" type="text/css" media="screen" href="#SiteDir#Siteshared/cr_style.css" />
	<link rel="stylesheet" type="text/css" media="print" href="#SiteDir#Siteshared/cr_style.css" />
	<link rel="stylesheet" type="text/css" href="/header/ulnetheader.css" />
    <link rel="stylesheet" type="text/css" href="about/IE8.css" />
	</cfoutput>

<style type="text/css">
#dropmenudiv{
position:absolute;
border:1px solid black;
border-bottom-width: 0;
font:normal 10px Verdana;
line-height:18px;
z-index:100;
}

#dropmenudiv a{
width: 100%;
display: block;
border-bottom: 1px solid black;
padding: 0px;
text-decoration: none;
}

#dropmenudiv a:hover{ /*hover background color*/
background-color: #e8e8e8;
}
</style>

<cfoutput>

<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND this.Name eq "IQA">
	<cfif SESSION.Auth.AccessLevel eq "Admin" OR SESSION.Auth.AccessLevel eq "IQAAuditor" OR SESSION.Auth.AccessLevel eq "SU">
        <CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
        SELECT ID 
        FROM AuditorList
        WHERE Auditor = '#SESSION.Auth.Name#'
        </cfquery>
	</cfif>
</cfif>

<script type="text/javascript">
//Contents for QE menu
var qemenu=new Array()
qemenu[0]='<a href="#SiteDir#QualityEngineering/index.cfm">QE - Home</a>'
qemenu[1]='<a href="#SiteDir#QualityEngineering/AboutQE.cfm">About Quality Engineering</a>'
<!---qemenu[2]='<a href="#SiteDir#QE/Calibration_Index.cfm">Calibration Meetings</a>'--->
qemenu[3]='<a href="#SiteDir#QualityEngineering/KBIndex.cfm">Knowledge Base</a>'
qemenu[4]='<a href="#SiteDir#QE/Alerts.cfm">Quality Alerts</a>'
qemenu[5]='<a href="#SiteDir#IQA/audit_req.cfm">Request an Audit</a>'
qemenu[6]='<a href="#SiteDir#IQA/getEmpNo.cfm?page=auditor_req">Request to be an Auditor</a>'
qemenu[7]='<a href="#SiteDir#QE/getEmpNo.cfm?page=Request">Request to be a CAR Administrator</a>'
qemenu[8]='<a href="#SiteDir#IQA/matrix.cfm">Standard Category Matrix</a>'
qemenu[9]='<a href="#SiteDir#IQA/_prog.cfm?list=CPO">UL Programs Master List</a>'
qemenu[10]='<a href="#SiteDir#IQA/webhelp/webhelp_showMaxRev.cfm?Type=inLine">Web Help</a>'

//Contents for Audit menu
var IQAmenu=new Array()
IQAmenu[0]='<a href="#SiteDir#IQA/index.cfm">Audits - Home</a>'
IQAmenu[1]='<a href="#SiteDir#IQA/Activity_Coverage_Menu.cfm">Audit Activity and Coverage</a>'
IQAmenu[2]='<a href="#SiteDir#IQA/CARFiles.cfm?Category=Plans">Audit Plans</a>'
IQAmenu[3]='<a href="#SiteDir#IQA/Metrics_Region.cfm">Audit Schedule Attainment</a>'
IQAmenu[4]='<a href="#SiteDir#IQA/AProfiles.cfm">Auditors</a>'
IQAmenu[5]='<a href="#SiteDir#IQA/FAQ.cfm">IQA FAQ</a>'
IQAmenu[6]='<a href="#SiteDir#IQA/KBIndex.cfm">Knowledge Base</a>'
IQAmenu[7]='<a href="#SiteDir#IQA/_prog.cfm?list=CPO">UL Programs Master List</a>'
IQAmenu[8]='<a href="#SiteDir#IQA/viewAudits.cfm">View Audits</a>'
IQAmenu[9]='<a href="#SiteDir#IQA/webhelp/webhelp_showMaxRev.cfm?Type=inLine">Web Help</a>'

//Contents for CAR menu
var CARmenu=new Array()
CARmenu[0]='<a href="#SiteDir#QE/index.cfm">CAR Process - Home</a>'
CARmenu[1]='<a href="#SiteDir#QE/FAQ.cfm">CAR Process FAQ</a>'
CARmenu[2]='<a href="notes:///86256F150051C1B0/">Link to CAR Database</a>'
CARmenu[3]='<a href="#SiteDir#QE/CARAdmin_Menu.cfm">CAR Administrator Related Pages</a>'
CARmenu[4]='<a href="#SiteDir#QE/KBIndex.cfm">Knowledge Base</a>'
CARmenu[5]='<a href="#SiteDir#QE/Links.cfm">Links</a>'
CARmenu[6]='<a href="#SiteDir#QE/training.cfm">Training Aids</a>'

//Contents for GCAR Metrics menu
var GCARMetricsmenu=new Array()
GCARMetricsmenu[0]='<a href="#SiteDir#GCARMetrics/index.cfm">GCAR Metrics - Home</a>'
GCARMetricsmenu[1]='<a href="#SiteDir#GCARMetrics/Overview.cfm">GCAR Metrics - Application Overview</a>'
GCARMetricsmenu[2]='<a href="#SiteDir#GCARMetrics/Glossary.cfm">GCAR Metrics - Glossary of Terms</a>'

//Contents for FAQ menu
var FAQmenu=new Array()
FAQmenu[0]='<a href="#SiteDir#FAQ/index.cfm">FAQ - Home</a>'
FAQmenu[1]='<a href="#SiteDir#QE/FAQ.cfm">CAR Process FAQ - Full</a>'
FAQmenu[2]='<a href="#SiteDir#QE/carAdmins.cfm">CAR Process FAQ - CAR Admin Related</a>'
FAQmenu[3]='<a href="#SiteDir#QE/carOwners.cfm">CAR Process FAQ - CAR Owner Related</a>'
FAQmenu[4]='<a href="#SiteDir#QE/FAQ_RH.cfm">CAR Process FAQ - Revision History</a>'
FAQmenu[5]='<a href="#SiteDir#GCARMetrics/Overview.cfm">GCAR Metrics - Application Overview</a>'
FAQmenu[6]='<a href="#SiteDir#GCARMetrics/Glossary.cfm?ID=All">GCAR Metrics - Glossary of Terms</a>'
FAQmenu[7]='<a href="#SiteDir#IQA/FAQ.cfm">IQA FAQ</a>'
FAQmenu[8]='<a href="#SiteDir#FAQ/SiteFAQ.cfm">Site FAQ (Navigation, Menus, etc)</a>'
FAQmenu[9]='<a href="#SiteDir#IQA/webhelp/webhelp_showMaxRev.cfm?Type=inLine">Web Help</a>'

//Contents for About menu
var Helpmenu=new Array()
Helpmenu[0]='<a href="#SiteDir#QualityEngineering/AboutQE.cfm">About QE</a>'
Helpmenu[1]='<a href="#SiteDir#IQA/webhelp/webhelp_showMaxRev.cfm?Type=InLine">Web Help</a>'

<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND this.Name eq "QE">
	<cfif SESSION.Auth.AccessLevel eq "SU">
	//Contents for CAR Admin Logged In Menu
		var CAR_AdminMenu=new Array()
		CAR_AdminMenu[0]='<a href="#SiteDir#QE/Admin/index.cfm">CAR Process Admin - Super User Menu</a>'
		CAR_AdminMenu[1]='<a href="#SiteDir#QE/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a>'
		CAR_AdminMenu[2]='<a href="#SiteDir#QE/Admin/CM/Calibration_Index.cfm">Calibration Meetings</a>'
		CAR_AdminMenu[3]='<a href="#SiteDir#QE/Admin/CARAdmin_Menu.cfm">CAR Administrator Related</a>'
		CAR_AdminMenu[4]='<a href="#SiteDir#QE/FAQ.cfm">CAR Process FAQ</a>'
		CAR_AdminMenu[4]='<a href="#SiteDir#QE/FAQ_RH.cfm">CAR Process FAQ - View Revision History</a>'
		CAR_AdminMenu[5]='<a href="#SiteDir#QE/CARTrainingFiles.cfm">CAR Training Related</a>'
		CAR_AdminMenu[6]='<a href="#SiteDir#QE/Admin/CARSource_View.cfm">FAQ 12 / CAR Sources</a>'
		CAR_AdminMenu[7]='<a href="#SiteDir#QE/Admin/RootCause_Add.cfm">FAQ 26 / Root Cause Categories</a>'
		CAR_AdminMenu[8]='<a href="#SiteDir#IQA/GF.cfm">Global Functions/Processes</a>'
		CAR_AdminMenu[9]='<a href="#SiteDir#QE/Admin/KBIndex.cfm">Manage Knowledge Base</a>'
		CAR_AdminMenu[10]='<a href="#SiteDir#QE/Admin/CARFilesCategories.cfm">QE Related Files - View/Add Categories</a>'
		CAR_AdminMenu[11]='<a href="#SiteDir#QE/Admin/CARFiles.cfm">QE Related Files - View/Add Files</a>'
		CAR_AdminMenu[12]='<a href="#SiteDir#QE/Alerts.cfm">Quality Alerts - View</a>'
		<cfif SESSION.Auth.AccessLevel eq "SU">
			CAR_AdminMenu[13]='<a href="#SiteDir#QE/Admin/EmailCheck.cfm">Verify IQA/etc Emails</a>'
			CAR_AdminMenu[14]='<a href="#SiteDir#QE/Admin/TrainerLogin.cfm">Verify CAR Trainer Logins</a>'
			CAR_AdminMenu[15]='<a href="#SiteDir#QE/Admin/archive/directory_listing.cfm">Archived Documents</a>'			
		</cfif>
	<cfelseif SESSION.Auth.AccessLevel eq "CAR">
		var CAR_AdminMenu=new Array()
		CAR_AdminMenu[0]='<a href="#SiteDir#QE/CARTrainingFiles.cfm">CAR Process Admin - CAR Trainer Menu</a>'
		CAR_AdminMenu[1]='<a href="#SiteDir#QE/Calibration_Index.cfm">Calibration Meetings</a>'
		<cfif SESSION.Auth.UserName eq "Konigsfeld">
			CAR_AdminMenu[2]='<a href="#SiteDir#QE/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a>'
		</cfif>
	</cfif>
</cfif>

<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND this.Name eq "IQA">

<!--- query to see if accesslevel RQM is also a corp iqa auditor, to view calibration meetings --->
<cfquery name="checkAuditor" datasource="Corporate">
select IQA, Auditor 
FROM AuditorList
WHERE Auditor = '#SESSION.Auth.Name#'
</cfquery>
<!--- /// --->

	<cfif SESSION.Auth.AccessLevel eq "SU">
//Contents for IQA Admin Logged In Menu
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/Index.cfm">IQA Admin - Super User Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/addaudit.cfm?AuditedBy=IQA">Add IQA Audit</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Aprofiles.cfm?View=All">Auditor List and Profiles</a>'		
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/CARFiles_AuditorPerformance.cfm">Auditor Performance</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/Auditor_Req_View.cfm">Auditor Requests</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/viewStatusPages.cfm">Audit Status Pages</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[8]='<a href="#SiteDir#IQA/Admin/Calibration_Index.cfm">Calibration Meetings</a>'
		IQA_AdminMenu[9]='<a href="#SiteDir#IQA/Admin/CARFiles_CARAdminPerformance.cfm">CAR Administrator Performance</a>'
		IQA_AdminMenu[10]='<a href="#SiteDir#IQA/Admin/_Quals.cfm">Corporate IQA Auditor Qualifications</a>'
		IQA_AdminMenu[11]='<a href="#SiteDir#IQA/Admin/viewControlPanel.cfm">Database Controls (Lists, Settings)</a>'
		IQA_AdminMenu[12]='<a href="#SiteDir#IQA/Admin/DAP_SNAP_Coverage.cfm?Year=#curyear#">DAP SNAP Coverage</a>'
		IQA_AdminMenu[13]='<a href="#SiteDir#IQA/Admin/KBIndex.cfm">Manage Knowledge Base</a>'
		IQA_AdminMenu[14]='<a href="#SiteDir#IQA/Admin/SRMenu.cfm">Service Requests</a>'
		IQA_AdminMenu[15]='<a href="#SiteDir#IQA/Admin/AccredLocations/index.cfm">UL Accreditations</a>'
		IQA_AdminMenu[16]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=CPO">UL Programs Master List</a>'
		IQA_AdminMenu[17]='<a href="#SiteDir#IQA/viewAudits.cfm">View Audits</a>'
		IQA_AdminMenu[18]='<a href="#SiteDir#IQA/Planning/Distribution.cfm?Type=Program">Yearly Audit Planning</a>'
		IQA_AdminMenu[19]='<a href="#SiteDir#IQA/Admin/Baseline.cfm?year=#curyear#">Audit Schedule Baseline</a>'
		IQA_AdminMenu[20]='<a href="#SiteDir#IQA/Admin/select_office.cfm">Site Profiles</a>'
		IQA_AdminMenu[21]='<a href="#SiteDir#IQA/Admin/ViewUsers.cfm">View Users</a>'
		IQA_AdminMenu[22]='<a href="#SiteDir#IQA/Admin/error_list.cfm">View Error List</a>'
		IQA_AdminMenu[23]='<a href="#SiteDir#IQA/Admin/SQL.cfm">Run Update/Delete/Insert SQL, no output</a>'
		IQA_AdminMenu[24]='<a href="#SiteDir#IQA/Admin/SQL2.cfm">RUN Select SQL, output CFDUMP</a>'
		IQA_AdminMenu[25]='<a href="#SiteDir#IQA/Admin/Applications.cfm">Application / Module Overview</a>'
		IQA_AdminMenu[26]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=Auditor&Type2=#SESSION.Auth.Name#">Your Audits - #CurYear#</a>'
		IQA_AdminMenu[27]='<a href="#SiteDir#IQA/Admin/AProfiles_Detail.cfm?ID=#AuditorProfile.ID#">Your Auditor Profile</a>'
	<cfelseif SESSION.AUTH.AccessLevel eq "Admin">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/Index.cfm">IQA Admin - Admin Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/addaudit.cfm?AuditedBy=IQA">Add IQA Audit</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Aprofiles.cfm?View=All">Auditor List and Profiles</a>'		
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/viewStatusPages.cfm">Audit Status Pages</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Calibration_Index.cfm">Calibration Meetings</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/DAP_SNAP_Coverage.cfm?Year=#curyear#">DAP SNAP Coverage</a>'
		IQA_AdminMenu[8]='<a href="#SiteDir#IQA/Admin/viewControlPanel.cfm">Database Controls (Lists, Settings)</a>'
		IQA_AdminMenu[9]='<a href="#SiteDir#IQA/Admin/KBIndex.cfm">Manage Knowledge Base</a>'
		IQA_AdminMenu[10]='<a href="#SiteDir#IQA/Admin/SRMenu.cfm">Service Requests</a>'
		IQA_AdminMenu[11]='<a href="#SiteDir#IQA/Admin/AccredLocations/index.cfm">UL Accreditations</a>'
		IQA_AdminMenu[12]='<a href="#SiteDir#IQA/Planning/Distribution.cfm?Type=Program">Yearly Audit Planning</a>'
		IQA_AdminMenu[13]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=Auditor&Type2=#SESSION.Auth.Name#">Your Audits - #CurYear#</a>'
		IQA_AdminMenu[14]='<a href="#SiteDir#IQA/Admin/AProfiles_Detail.cfm?ID=#AuditorProfile.ID#">Your Auditor Profile</a>'
		IQA_AdminMenu[15]='<a href="#SiteDir#IQA/Admin/select_office.cfm">Site Profiles</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "IQAAuditor">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - IQA Auditor Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/addaudit.cfm?AuditedBy=IQA">Add IQA Audit</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Aprofiles.cfm?View=All">Auditor List and Profiles</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/viewStatusPages.cfm">Audit Status Pages</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Calibration_Index.cfm">Calibration Meetings</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/DAP_SNAP_Coverage.cfm?Year=#curyear#">DAP SNAP Coverage</a>'
		IQA_AdminMenu[8]='<a href="#SiteDir#IQA/Admin/KBIndex.cfm">Manage Knowledge Base</a>'
		IQA_AdminMenu[9]='<a href="#SiteDir#IQA/Admin/SRMenu.cfm">Service Requests</a>'
		IQA_AdminMenu[10]='<a href="#SiteDir#IQA/Admin/AccredLocations/index.cfm">UL Accreditations</a>'
		IQA_AdminMenu[11]='<a href="#SiteDir#IQA/Planning/Distribution.cfm?Type=Program">Yearly Audit Planning</a>'
		IQA_AdminMenu[12]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=Auditor&Type2=#SESSION.Auth.Name#">Your Audits - #CurYear#</a>'
		IQA_AdminMenu[13]='<a href="#SiteDir#IQA/Admin/AProfiles_Detail.cfm?ID=#AuditorProfile.ID#">Your Auditor Profile</a>'
		IQA_AdminMenu[14]='<a href="#SiteDir#IQA/Admin/select_office.cfm">Site Profiles</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "RQM">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - RQM Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/addaudit.cfm?AuditedBy=#SESSION.Auth.SubRegion#">Add #SESSION.Auth.SubRegion# Audit</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Aprofiles.cfm?View=All">Auditor List and Profiles</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/Auditor_Req_View.cfm">Auditor Requests</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/metrics.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#">Schedule Attainment Metrics</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/AccredLocations/index.cfm">UL Accreditations</a>'
		IQA_AdminMenu[8]='<a href="#SiteDir#IQA/Admin/Select_Office.cfm">UL Location Information</a>'
		IQA_AdminMenu[9]='<a href="#SiteDir#IQA/Admin/Accred.cfm">View Accreditors</a>'
		IQA_AdminMenu[10]='<a href="#SiteDir#IQA/Admin/Calendar.cfm?Type=SubRegion&Type2=#SESSION.Auth.SubRegion#">View Audits - Calendar View</a>'
		IQA_AdminMenu[11]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=SubRegion&Type2=#SESSION.Auth.SubRegion#">View Audits - List View</a>'
		IQA_AdminMenu[12]='<a href="#SiteDir#IQA/Admin/Schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&Auditor=All">View Audits - Schedule View</a>'
		<!--- some RQMs may be corp IQA Auditors, if so they need to be able to see the Calibration Meetings index --->
		<cfif checkAuditor.recordCount eq 1>
			<cfif SESSION.Auth.Name eq "#checkAuditor.Auditor#" AND checkAuditor.IQA eq "Yes">
				IQA_AdminMenu[13]='<a href="#SiteDir#IQA/Admin/Calibration_Index.cfm">Calibration Meetings</a>'
			</cfif>
		</cfif>
	<cfelseif SESSION.Auth.AccessLevel eq "Field Services">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - Field Services Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/AProfiles.cfm?view=Field Services">Auditor List and Profiles</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/AuditNumber.cfm">Audit Lookup (by Audit Number)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/FSPlan.cfm">Field Service Audit Plan</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/fus2.cfm">IC Locations</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/calendar.cfm?type=FS&type2=FS">View Audits - Calendar View</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#curyear#&type=FS&type2=FS">View Audits - List View</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/schedule.cfm?Year=#curyear#&AuditedBy=Field Services&auditor=All">View Audits - Schedule View</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "AS">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - Accreditation Services Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/AuditNumber.cfm">Audit Lookup (by Audit Number)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Calendar.cfm?Type=Accred&Type2=AS">View Audits - Calendar View</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=Accred&Type2=AS">View Audits - List View</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/Schedule.cfm?Year=#CurYear#&AuditedBy=AS&Auditor=All">View Audits - Schedule View</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/ASAccred.cfm">Manage AS Accreditor List</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/ASContact.cfm">Manage AS Contacts</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "Finance">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - Finance Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/FContacts.cfm">Auditor List</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/AuditNumber.cfm">Audit Lookup (by Audit Number)</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/metrics_finance.cfm?Year=#curYear#&AuditedBy=Finance">Schedule Attainment Metrics</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/Calendar.cfm?Type=Finance">View Audits - Calendar View</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=Finance">View Audits - List View</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Schedule.cfm?Year=#CurYear#&AuditedBy=Finance&Auditor=All">View Audits - Schedule View</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "CPO">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=CPO">CPO Programs</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=CPCMR">CPC-MR Programs</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=Silver">Silver/Bronze Programs</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=IQA">Programs Audited by IQA</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=All">All Programs (CPO, CPC-MR, Silver/Bronze)</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/_prog.cfm?list=Removed">Removed Programs</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/_progRhLog.cfm">Revision History - by Program</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/_progRhLog2.cfm">Revision History - by Revision Date</a>'
		IQA_AdminMenu[8]='<a href="#SiteDir#IQA/Admin/_prog_rh_master.cfm">Revision History - Application Changes</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "Laboratory Technical Audit">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - Laboratory Technical Audit Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/LTA_AddAudit.cfm">Add Laboratory Technical Audit (LTA)</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Auditors.cfm?Type=LTA">LTA Auditor List'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/AuditNumber.cfm">Audit Lookup (by Audit Number)</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/Calendar.cfm?Type=LAB">View Audits - Calendar View</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=LAB">View Audits - List View</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/Schedule.cfm?Year=#CurYear#&AuditedBy=LAB&Auditor=All">View Audits - Schedule View</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "Verification Services">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - VS Menu</a>'
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/addaudit.cfm?AuditedBy=VS">Add VS Audit</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/Auditors.cfm?Type=VS">VS Auditor List'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/AuditNumber.cfm">Audit Lookup (by Audit Number)</a>'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/Calendar.cfm?Type=VS">View Audits - Calendar View</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=VS">View Audits - List View</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/Schedule.cfm?Year=#CurYear#&AuditedBy=VS&Auditor=All">View Audits - Schedule View</a>'
	<cfelseif SESSION.Auth.AccessLevel eq "WiSE">
		var IQA_AdminMenu=new Array()
		IQA_AdminMenu[0]='<a href="#SiteDir#IQA/Admin/index.cfm">IQA Admin - WiSE Menu</a>'	
		IQA_AdminMenu[1]='<a href="#SiteDir#IQA/Admin/WiSe_AddAudit.cfm">Add WiSE Technical Audit</a>'
		IQA_AdminMenu[2]='<a href="#SiteDir#IQA/Admin/Accred_AddAudit.cfm?AuditedBy=WiSE">Add WiSE Accreditor Audit</a>'
		IQA_AdminMenu[3]='<a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a>'
		IQA_AdminMenu[4]='<a href="#SiteDir#IQA/Admin/Auditors.cfm?Type=WiSE">WiSE Auditor List'
		IQA_AdminMenu[5]='<a href="#SiteDir#IQA/Admin/AuditNumber.cfm">Audit Lookup (by Audit Number)</a>'
		IQA_AdminMenu[6]='<a href="#SiteDir#IQA/Admin/Calendar.cfm?Type=WiSE">View Audits - Calendar View</a>'
		IQA_AdminMenu[7]='<a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=WiSE">View Audits - List View</a>'
		IQA_AdminMenu[8]='<a href="#SiteDir#IQA/Admin/Schedule.cfm?Year=#CurYear#&AuditedBy=WiSE&Auditor=All">View Audits - Schedule View</a>'
		IQA_AdminMenu[9]='<a href="#SiteDir#IQA/Admin/accred.cfm">View Accreditors</a>'
		IQA_AdminMenu[10]='<a href="#SiteDir#IQA/webhelp/webhelp_showMaxRev.cfm?Type=inLine">IQA Web Help</a>'
	</cfif>
</cfif>

//Contents for CAR Login Menu
var CAR_Login=new Array()
CAR_Login[0]='<a href="#SiteDir#QE/admin/global_login.cfm">CAR Process Admin - Home</a>'

//Contents for IQA Login Menu
var IQA_Login=new Array()
IQA_Login[0]='<a href="#SiteDir#IQA/Admin/global_login.cfm">IQA Admin - Home</a>'

var menuwidth='167px' //default menu width
var menubgcolor='white'  //menu bgcolor
var disappeardelay=250  //menu disappear speed onMouseout (in miliseconds)
var hidemenu_onclick="no" //hide menu when user clicks within menu?

/////No further editting needed
var ie4=document.all
var ns6=document.getElementById&&!document.all

if (ie4||ns6)
document.write('<div id="dropmenudiv" style="visibility:hidden;width:'+menuwidth+';background-color:'+menubgcolor+'" onMouseover="clearhidemenu()" onMouseout="dynamichide(event)"></div>')

function getposOffset(what, offsettype){
var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
var parentEl=what.offsetParent;
while (parentEl!=null){
totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
parentEl=parentEl.offsetParent;
}
return totaloffset;
}


function showhide(obj, e, visible, hidden, menuwidth){
if (ie4||ns6)
dropmenuobj.style.left=dropmenuobj.style.top="-500px"
if (menuwidth!=""){
dropmenuobj.widthobj=dropmenuobj.style
dropmenuobj.widthobj.width=menuwidth
}
if (e.type=="click" && obj.visibility==hidden || e.type=="mouseover")
obj.visibility=visible
else if (e.type=="click")
obj.visibility=hidden
}

function iecompattest(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function clearbrowseredge(obj, whichedge){
var edgeoffset=0
if (whichedge=="rightedge"){
var windowedge=ie4 && !window.opera? iecompattest().scrollLeft+iecompattest().clientWidth-15 : window.pageXOffset+window.innerWidth-15
dropmenuobj.contentmeasure=dropmenuobj.offsetWidth
if (windowedge-dropmenuobj.x < dropmenuobj.contentmeasure)
edgeoffset=dropmenuobj.contentmeasure-obj.offsetWidth
}
else{
var topedge=ie4 && !window.opera? iecompattest().scrollTop : window.pageYOffset
var windowedge=ie4 && !window.opera? iecompattest().scrollTop+iecompattest().clientHeight-15 : window.pageYOffset+window.innerHeight-18
dropmenuobj.contentmeasure=dropmenuobj.offsetHeight
if (windowedge-dropmenuobj.y < dropmenuobj.contentmeasure){ //move up?
edgeoffset=dropmenuobj.contentmeasure+obj.offsetHeight
if ((dropmenuobj.y-topedge)<dropmenuobj.contentmeasure) //up no good either?
edgeoffset=dropmenuobj.y+obj.offsetHeight-topedge
}
}
return edgeoffset
}

function populatemenu(what){
if (ie4||ns6)
dropmenuobj.innerHTML=what.join("")
}


function dropdownmenu(obj, e, menucontents, menuwidth){
if (window.event) event.cancelBubble=true
else if (e.stopPropagation) e.stopPropagation()
clearhidemenu()
dropmenuobj=document.getElementById? document.getElementById("dropmenudiv") : dropmenudiv
populatemenu(menucontents)

if (ie4||ns6){
showhide(dropmenuobj.style, e, "visible", "hidden", menuwidth)
dropmenuobj.x=getposOffset(obj, "left")
dropmenuobj.y=getposOffset(obj, "top")
dropmenuobj.style.left=dropmenuobj.x-clearbrowseredge(obj, "rightedge")+"px"
dropmenuobj.style.top=dropmenuobj.y-clearbrowseredge(obj, "bottomedge")+obj.offsetHeight+"px"
}

return clickreturnvalue()
}

function clickreturnvalue(){
if (ie4||ns6) return false
else return true
}

function contains_ns6(a, b) {
while (b.parentNode)
if ((b = b.parentNode) == a)
return true;
return false;
}

function dynamichide(e){
if (ie4&&!dropmenuobj.contains(e.toElement))
delayhidemenu()
else if (ns6&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))
delayhidemenu()
}

function hidemenu(e){
if (typeof dropmenuobj!="undefined"){
if (ie4||ns6)
dropmenuobj.style.visibility="hidden"
}
}

function delayhidemenu(){
if (ie4||ns6)
delayhide=setTimeout("hidemenu()",disappeardelay)
}

function clearhidemenu(){
if (typeof delayhide!="undefined")
clearTimeout(delayhide)
}

if (hidemenu_onclick=="yes")
document.onclick=hidemenu
</script>
</cfoutput>

</head>
<body>
<cfoutput>
<!-- Begin UL Net Header -->
<SCRIPT language=JavaScript src="#request.serverProtocol##request.serverDomain#/header/header.js"></SCRIPT>
<!-- End UL Net Header-->
</cfoutput>

<div id="header">
  <table border="0" cellspacing="0" cellpadding="0" width="776">
    <tr>
      <cfoutput><td align="left" valign="top" colspan="2"><img src="#HeaderImage#" alt="#HeaderAlt#" width="776" height="70" border="0"></td></cfoutput>
    </tr>
    <tr>
      <td align="center" valign="middle" width="158">
        <div class="navdate">
			<cfoutput>
				#dateformat(now(), "MMMM d, yyyy")#
        	</cfoutput>
		</div>
	</td>
<td align="left" valign="middle" width="618" height="23">
<cfoutput>
	<!--- Quality Engineering --->
	<a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, qemenu, '250px')" onMouseout="delayhidemenu()">
		<img src="#SiteDir#SiteImages/nav_QE.jpg" alt="Quality Engineering" width="125" height="23" border="0">
	</a>
	
	<!--- Audits --->
	<a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, IQAmenu, '250px')" onMouseout="delayhidemenu()">
		<img src="#SiteDir#SiteImages/nav_Audits.jpg" alt="Audits" width="94" height="23" border="0">
	</a>
	
	<!--- CAR Process --->
	<a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, CARmenu, '250px')" onMouseout="delayhidemenu()">
		<img src="#SiteDir#SiteImages/nav_CAR_Process.jpg" alt="CAR Process" width="94" height="23" border="0">
	</a>
	
	<!--- GCAR Metrics --->
	<a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, GCARMetricsmenu, '250px')" onMouseout="delayhidemenu()">
		<img src="#SiteDir#SiteImages/nav_GCAR_Metrics.jpg" alt="GCAR Metrics" width="94" height="23" border="0">
	</a>
	
	<!--- FAQ --->
	<a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, FAQmenu, '250px')" onMouseout="delayhidemenu()">
		<img src="#SiteDir#SiteImages/nav_FAQ.jpg" alt="FAQ" width="94" height="23" border="0">
	</a>

<cfif this.name eq "QE">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
		<!--- CAR Process Admin Menu / Log In Button --->
        <a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, CAR_AdminMenu, '250px')" onMouseout="delayhidemenu()">
            <img src="#SiteDir#SiteImages/nav_AdminMenu.jpg" alt="CAR Process Admin Menu" width="94" height="23" border="0">
        </a>
    <cfelse>
		<!--- CAR Process Admin Menu / Log In Button --->
        <a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, CAR_Login, '250px')" onMouseout="delayhidemenu()">
            <img src="#SiteDir#SiteImages/nav_Login.jpg" alt="CAR Process - Login" width="94" height="23" border="0">
        </a>
    </cfif>
<cfelseif this.Name eq "IQA">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
		<!--- IQA ADMIN MENU / Log In Button --->
        <a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, IQA_AdminMenu, '250px')" onMouseout="delayhidemenu()">
            <img src="#SiteDir#SiteImages/nav_AdminMenu.jpg" alt="IQA Admin Menu" width="94" height="23" border="0">
        </a>
    <cfelse>
        <!--- CAR Process Admin Menu / Log In Button --->
        <a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, IQA_Login, '250px')" onMouseout="delayhidemenu()">
            <img src="#SiteDir#SiteImages/nav_Login.jpg" alt="IQA - Login" width="94" height="23" border="0">
        </a>
	</cfif>
<cfelse>
	<!--- About QE --->
	<a href="" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, Helpmenu, '250px')" onMouseout="delayhidemenu()">
		<img src="#SiteDir#SiteImages/nav_Help.jpg" alt="Web Help" width="94" height="23" border="0">
	</a>
</cfif>
</cfoutput>
</td>
    </tr>
  </table>
</div>