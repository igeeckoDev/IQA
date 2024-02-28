<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<!--- 8/29/2007 updated findings/obs table to include new key processes for 9/2007 audits, if/then for old audits, also if/then for extra queries for new KP --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT ID,YEAR_ as "Year", AuditedBy, AuditType
 FROM AuditSchedule
 WHERE ID = #URL.ID#
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditedBy = '#URL.AuditedBy#'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<!--- if this is a TPTDP Audit, go to TP Report Output Page --->
<cfif Check.AuditType is "TPTDP">
	<cflocation url="TPReport_Output_All.cfm?#CGI.Query_String#" addtoken="no">
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.Month, AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.RD, AuditSchedule.AuditType, AuditSchedule.AuditType2, AuditSchedule.Report, AuditSchedule.Desk, Report.Scope, Report.ReportDate, Report.KCInfo, Report.KCInfo2, Report.Summary, Report.BestPrac, Report.Offices, Report.Programs, Report.Attach, Report.Sectors
 FROM REPORT, AuditSchedule
 WHERE Report.ID = #URL.ID# 
 AND  Report.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
 AND  AuditSchedule.ID = #URL.ID# 
 AND  AuditSchedule.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
 AND  Report.AuditedBy = '#URL.AuditedBy#'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View1">
SELECT * FROM REPORT
WHERE Report.ID = #URL.ID# 
AND Report.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  
AND Report.AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# 
AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  
AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<cfif Audit.Year is 2008>
	<cfif Audit.Month gte 10>
	<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  CAR_SECTOR  "SECTOR" ORDER BY Sector

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>
	</cfif>
<cfelseif Audit.Year gt 2008>
	<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  CAR_SECTOR  "SECTOR" ORDER BY Sector

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>
</cfif>

<!--- 8/22/2007 - 9/2007 audits and forward will use an expanded list of Key Processes.--->
<!--- Old list retained for past audits --->
<cfif Audit.Year is 2007>
	<cfif Audit.Month gte 9>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
		SELECT * FROM KP_Report_2
		ORDER BY Alpha
		</CFQUERY>
	<cfelse>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
		SELECT * FROM KP_Report
		ORDER BY Alpha
		</CFQUERY>
	</cfif>
<cfelseif Audit.Year gt 2007>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
	SELECT * FROM KP_Report_2
	ORDER BY Alpha
	</CFQUERY>
<cfelseif Audit.Year lt 2007>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
	SELECT * FROM KP_Report
	ORDER BY Alpha
	</CFQUERY>
</cfif>		

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View2">
SELECT * FROM REPORT2
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View3">
SELECT * FROM REPORT3
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<cfquery name="Output" Datasource="Corporate">
SELECT * FROM Query
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditType2, ID,YEAR_ as "Year", AuditedBy
 FROM AuditSchedule
 WHERE ID = #URL.ID#  AND  Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  AND  AuditedBy = '#URL.AuditedBy#'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="Check">
<cfif AuditType2 is "Field Services" or AuditType2 is "Local Function FS">
<cfquery name="OutputFS" Datasource="Corporate">
SELECT * FROM Report5
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID = #URL.ID#
</cfquery>
</cfif>
</cfoutput>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=300,height=300,left = 490,top = 412');");
}
// End -->
</script>	

</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput>
<!-- End UL Net Header--> 
	
		<div align="left">
			<table width="750" border="0" cellpadding="0" cellspacing="0" bgcolor="#cecece" class="table-main">
			<tr>
			<td>
			<div align="center">
			<table class="table-main" width="675" border="0" cellspacing="0" cellpadding="0" bgcolor="#cecece">
				<tr>
					<td class="table-bookend-top">&nbsp;</td>
				</tr>
				<tr>
					<td class="table-masthead" align="right" valign="middle"><div align="center">&nbsp;</div></td>

				</tr>
				<tr>
					
              <td class="table-menu" valign="top"><div align="center">&nbsp;</div></td>
				</tr>
				<tr>

					
              <td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	<cfinclude template="adminmenu.cfm">
                          </td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              <cfoutput>Audit Report - #url.Year#-#url.ID#-#url.AuditedBy#</cfoutput></p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<!--- if the audit report exists --->
<cfif Check.RecordCount eq 1 AND View1.RecordCount eq 1>
						  
<table width="750"><tr><td class="blog-content">
						  
<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A><br>
Audit Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div>	  
						  
<cfoutput query="View" group="ID">
<br>
:: <a href="Report_Print.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">Print</a> Report<br>
<cfif Report is "Completed">
:: Report Published<br>
<cfelse>
:: <a href="Report_Publish_Confirm.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">Publish</a> Report<br>
:: <a href="Report_Edit1.cfm?#CGI.Query_String#">Edit</a> Report<br>
</cfif>
<br>
</cfoutput>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
    SELECT * FROM ReportAttach
    WHERE ID = #URL.ID# AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>
    
    <cfif AttachCheck.recordcount gt 0>
   	<b>Attachments</b><br>
    	<cfoutput query="AttachCheck">
        	:: 
			<cfif filelabel is "">
				#filename# - <a href="../Reports/#filename#">View</a>
			<cfelse>
            	#fileLabel# - <a href="../Reports/#filename#">View</a>
			</cfif><br>
        </cfoutput><br>
    </cfif>
    
<cfoutput>
    :: <a href="Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#URL.AuditedBy#">Upload Report Attachment File(s)</a><br><br>
</cfoutput>

<cfoutput query="View" group="ID">
<b><u>General Information and New CARs</u></b><br><br>

<B>Audit Report Number</b><br>
#Year#-#ID#-#AuditedBy#<br><br>

<b>Location</b><br>
#OfficeName#<br>
<cfif AuditType2 is "Field Services">
#Area#<br>
Audit Area: #AuditArea#<br>
<cfelse>
	<cfif Trim(AuditArea) is "">
	<cfelse>
	Audit Area: #AuditArea#<br>
	#Area#<br>
	</cfif>
</cfif><br>

<!--- 1/14/2009 changed 'verification' to 'a sampling' for Locations, Sectors, and Progams below --->

<b>Other Locations Included in Audit</b><br>
This Audit included a sampling of the program/process activities associated with the following sites:<br>
--------<br>
<cfif Offices is "">
None Listed
<cfelse>
<cfset OfficeDump = #replace(Offices, "!!,", "<br>", "All")#>
<cfset OfficeDump2 = #replace(OfficeDump, "!!", "", "All")#>
<cfset OfficeDump3 = #replace(OfficeDump2, "NoChanges,", "", "All")#>
<cfset OfficeDump4 = #replace(OfficeDump3, "None,", "", "All")#>
#OfficeDump4#
</cfif><br><br>

<cfif Audit.Year is 2009 OR Audit.Year is 2008 AND Audit.Month gte 10>
<b>Sectors</b><br>
This Audit included a sampling of the process activities associated with the following Sectors:<br>
--------<br>
<cfif Sectors is "">
None Listed
<cfelse>
<cfset SectorDump = #replace(Sectors, "!!,", "<br>", "All")#>
<cfset SectorDump2 = #replace(SectorDump, "!!", "", "All")#>
<cfset SectorDump3 = #replace(SectorDump2, "NoChanges,", "", "All")#>
<cfset SectorDump4 = #replace(SectorDump3, "None,", "", "All")#>
#SectorDump4#
</cfif><br><br>
</cfif>

<cfif AuditType2 is NOT "Program">
<b>Programs Included in Audit</b><br>
This Audit included a sampling of the program/process activities associated with the following Programs:<br>
--------<br>
<cfif Programs is "">
None Listed
<cfelse>
<cfset ProgDump = #replace(Programs, "!!,", "<br>", "All")#>
<cfset ProgDump2 = #replace(ProgDump, "!!", "", "All")#>
<cfset ProgDump3 = #replace(ProgDump2, "NoChanges,", "", "All")#>
<cfset ProgDump4 = #replace(ProgDump3, "None,", "", "All")#>
#ProgDump4#
</cfif><br><br>
</cfif>

<b>Audit Date(s)</b><br>
<cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">No dates scheduled<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
	</cfif>
</cfif><br>

<b>Report Date</b><br>
#Dateformat(ReportDate, 'mmmm dd, yyyy')#<br><br>

<b>Auditor(s)</b><br>
<cfif Trim(LeadAuditor) is "" or Trim(LeadAuditor) is "- None -">
	<cfif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
	No Auditors Listed<br>
	<cfelse>
	#Auditor#<br>
	</cfif>
<cfelseif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
#LeadAuditor#, Lead<br>
<CFELSE>
#LeadAuditor#, Lead<br>
#Auditor#<br>
</cfif><br>

<b>Audit Type</b><br>
#AuditType#, #AuditType2#<br><br>

<cfif year gt 2009 OR year eq 2009 AND month gte 4>
	<b>Primary Contact</b><br>
	<cfset Dump = #replace(KCInfo, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	#Dump1#
	<br><br>
	
	<b>Other Contacts</b><br>
	<cfset Dump = #replace(KCInfo2, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	<cfif len(Dump1)>
		#Dump1#
	<cfelse>
		None Listed
	</cfif>
	<br><br>
<cfelse>
	<b>Contact(s) Email</b><br>
	<cfset Dump = #replace(KCInfo, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	#Dump1#
	<br><br>
</cfif>

<b>Scope</b><br>
#Scope#<br><br>

<!--- Reference Documents --->					
<cfinclude template="../incRD.cfm">

<b>Summary</b><br>
#Summary#<br><br>
</cfoutput>

<cfset var=ArrayNew(3)>
<cfset varnew=ArrayNew(3)>

<CFSET varnew[1][1][1] = 'General/Organization'>
<CFSET varnew[2][1][1] = 'Quality System'>
<CFSET varnew[3][1][1] = 'Document Control'>
<CFSET varnew[4][1][1] = 'Review of Requests, Tenders, and Contracts'>
<CFSET varnew[5][1][1] = 'Subcontracting'>
<CFSET varnew[6][1][1] = 'Purchasing'>
<CFSET varnew[7][1][1] = 'Condifentiality'>
<CFSET varnew[8][1][1] = 'Complaints'>
<CFSET varnew[9][1][1] = 'Control of Non-Conforming Tests and Calibrations'>
<CFSET varnew[10][1][1] = 'Improvement'>
<CFSET varnew[11][1][1] = 'Corrective Action'>
<CFSET varnew[12][1][1] = 'Preventive Action'>
<CFSET varnew[13][1][1] = 'Records'>
<CFSET varnew[14][1][1] = 'Internal Audits'>
<CFSET varnew[15][1][1] = 'Management Review'>
<CFSET varnew[16][1][1] = 'Global Technical Requirements'>
<CFSET varnew[17][1][1] = 'Personnel'>
<CFSET varnew[18][1][1] = 'Accomodation, Facilities, Eqiupment and Environmental Conditions'>
<CFSET varnew[19][1][1] = 'Test and Calibration Methods and Method Validation'>
<CFSET varnew[20][1][1] = 'Equipment'>
<CFSET varnew[21][1][1] = 'Measuring Traceability'>
<CFSET varnew[22][1][1] = 'Sampling'>
<CFSET varnew[23][1][1] = 'Handling of Test and Calibration Items'>
<CFSET varnew[24][1][1] = 'Assuring the Quality of Test and Calibration Results'>
<CFSET varnew[25][1][1] = 'Reports'>
<CFSET varnew[26][1][1] = 'Conditions and Procedures for Granting, Maintaining, Extending, Suspending And Withdrawing Certification'>
<CFSET varnew[27][1][1] = 'Application for Certification'>
<CFSET varnew[28][1][1] = 'Preparation for Evaluation'>
<CFSET varnew[29][1][1] = 'Evaluation'>
<CFSET varnew[30][1][1] = 'Decision on Certification'>
<CFSET varnew[31][1][1] = 'Surveillance'>
<CFSET varnew[32][1][1] = 'Use of Licenses, Certificates, Marks and Logos'>
<CFSET varnew[33][1][1] = 'Complaints to Suppliers'>
<CFSET varnew[34][1][1] = 'Cooperation'>
<CFSET varnew[35][1][1] = 'Change in Certification Requirements'>

<CFSET var[1][1][1] = 'Contracts'>
<CFSET var[2][1][1] = 'Control of Customer Property and Samples'>
<CFSET var[3][1][1] = 'Corrective and Preventive Action'>

<CFSET var[4][1][1] = 'Document Control'>
<CFSET var[5][1][1] = 'HR and Personnel'>
<CFSET var[6][1][1] = 'Inspection Program'>
<CFSET var[7][1][1] = 'Internal Quality Audits'>
<CFSET var[8][1][1] = 'Laboratory'>
<CFSET var[9][1][1] = 'Management Review'>
<CFSET var[10][1][1] = 'Nonconforming Test or Product'>
<CFSET var[11][1][1] = 'Program Specific'>
<CFSET var[12][1][1] = 'Purchasing'>
<CFSET var[13][1][1] = 'Quality System'>
<CFSET var[14][1][1] = 'Records'>
<CFSET var[15][1][1] = 'Subcontracting'>
<CFSET var[16][1][1] = 'Training and Competency'>
<CFSET var[17][1][1] = 'Certification Decision'>
<CFSET var[18][1][1] = 'Complaints and Appeals'>
<CFSET var[19][1][1] = 'Customer Service'>
<CFSET var[20][1][1] = 'Evaluation Process'>
<CFSET var[21][1][1] = 'Industry File Review'>
<CFSET var[22][1][1] = 'Surveillance'> 
<CFSET var[23][1][1] = 'Other'> 

<cfoutput query="View1">
<CFSET var[1][2][2] = '#CAR1#'>
<CFSET var[2][2][2] = '#CAR2#'>
<CFSET var[3][2][2] = '#CAR3#'>
<CFSET var[4][2][2] = '#CAR4#'>
<CFSET var[5][2][2] = '#CAR5#'>
<CFSET var[6][2][2] = '#CAR6#'>
<CFSET var[7][2][2] = '#CAR7#'>
<CFSET var[8][2][2] = '#CAR8#'>
<CFSET var[9][2][2] = '#CAR9#'>
<CFSET var[10][2][2] = '#CAR10#'>
<CFSET var[11][2][2] = '#CAR11#'>
<CFSET var[12][2][2] = '#CAR12#'>
<CFSET var[13][2][2] = '#CAR13#'>
<CFSET var[14][2][2] = '#CAR14#'>
<CFSET var[15][2][2] = '#CAR15#'>
<CFSET var[16][2][2] = '#CAR16#'>
<CFSET var[17][2][2] = '#CAR17#'>
<CFSET var[18][2][2] = '#CAR18#'>
<CFSET var[19][2][2] = '#CAR19#'>
<CFSET var[20][2][2] = '#CAR20#'>
<CFSET var[21][2][2] = '#CAR21#'>
<CFSET var[22][2][2] = '#CAR22#'>
<CFSET var[23][2][2] = '#CAR23#'>
<CFSET var[24][2][2] = '#CAR24#'>
<CFSET var[25][2][2] = '#CAR25#'>
<CFSET var[26][2][2] = '#CAR26#'>
<CFSET var[27][2][2] = '#CAR27#'>
<CFSET var[28][2][2] = '#CAR28#'>
<CFSET var[29][2][2] = '#CAR29#'>
<CFSET var[30][2][2] = '#CAR30#'>
<CFSET var[31][2][2] = '#CAR31#'>
<CFSET var[32][2][2] = '#CAR32#'>
<CFSET var[33][2][2] = '#CAR33#'>
<CFSET var[34][2][2] = '#CAR34#'>
<CFSET var[35][2][2] = '#CAR35#'>
<CFSET var[36][2][2] = '#CAROther#'>

<CFSET var[1][3][3] = '#Count1#'>
<CFSET var[2][3][3] = '#Count2#'>
<CFSET var[3][3][3] = '#Count3#'>
<CFSET var[4][3][3] = '#Count4#'>
<CFSET var[5][3][3] = '#Count5#'>
<CFSET var[6][3][3] = '#Count6#'>
<CFSET var[7][3][3] = '#Count7#'>
<CFSET var[8][3][3] = '#Count8#'>
<CFSET var[9][3][3] = '#Count9#'>
<CFSET var[10][3][3] = '#Count10#'>
<CFSET var[11][3][3] = '#Count11#'>
<CFSET var[12][3][3] = '#Count12#'>
<CFSET var[13][3][3] = '#Count13#'>
<CFSET var[14][3][3] = '#Count14#'>
<CFSET var[15][3][3] = '#Count15#'>
<CFSET var[16][3][3] = '#Count16#'>
<CFSET var[17][3][3] = '#Count17#'>
<CFSET var[18][3][3] = '#Count18#'>
<CFSET var[19][3][3] = '#Count19#'>
<CFSET var[20][3][3] = '#Count20#'>
<CFSET var[21][3][3] = '#Count21#'>
<CFSET var[22][3][3] = '#Count22#'>
<CFSET var[23][3][3] = '#Count23#'>
<CFSET var[24][3][3] = '#Count24#'>
<CFSET var[25][3][3] = '#Count25#'>
<CFSET var[26][3][3] = '#Count26#'>
<CFSET var[27][3][3] = '#Count27#'>
<CFSET var[28][3][3] = '#Count28#'>
<CFSET var[29][3][3] = '#Count29#'>
<CFSET var[30][3][3] = '#Count30#'>
<CFSET var[31][3][3] = '#Count31#'>
<CFSET var[32][3][3] = '#Count32#'>
<CFSET var[33][3][3] = '#Count33#'>
<CFSET var[34][3][3] = '#Count34#'>
<CFSET var[35][3][3] = '#Count35#'>
<CFSET var[36][3][3] = '#CountOther#'>
</cfoutput>

<cfset var2=ArrayNew(1)>
<cfoutput query="View1">
<CFSET var2[1] = '#OCount1#'>
<CFSET var2[2] = '#OCount2#'>
<CFSET var2[3] = '#OCount3#'>
<CFSET var2[4] = '#OCount4#'>
<CFSET var2[5] = '#OCount5#'>
<CFSET var2[6] = '#OCount6#'>
<CFSET var2[7] = '#OCount7#'>
<CFSET var2[8] = '#OCount8#'>
<CFSET var2[9] = '#OCount9#'>
<CFSET var2[10] = '#OCount10#'>
<CFSET var2[11] = '#OCount11#'>
<CFSET var2[12] = '#OCount12#'>
<CFSET var2[13] = '#OCount13#'>
<CFSET var2[14] = '#OCount14#'>
<CFSET var2[15] = '#OCount15#'>
<CFSET var2[16] = '#OCount16#'>
<CFSET var2[17] = '#OCount17#'>
<CFSET var2[18] = '#OCount18#'>
<CFSET var2[19] = '#OCount19#'>
<CFSET var2[20] = '#OCount20#'>
<CFSET var2[21] = '#OCount21#'>
<CFSET var2[22] = '#OCount22#'>
<CFSET var2[23] = '#OCount23#'>
<CFSET var2[24] = '#OCount24#'>
<CFSET var2[25] = '#OCount25#'>
<CFSET var2[26] = '#OCount26#'>
<CFSET var2[27] = '#OCount27#'>
<CFSET var2[28] = '#OCount28#'>
<CFSET var2[29] = '#OCount29#'>
<CFSET var2[30] = '#OCount30#'>
<CFSET var2[31] = '#OCount31#'>
<CFSET var2[32] = '#OCount32#'>
<CFSET var2[33] = '#OCount33#'>
<CFSET var2[34] = '#OCount34#'>
<CFSET var2[35] = '#OCount35#'>
<CFSET var2[36] = '#OCountOther#'>
</cfoutput>

<b>Non-Conformances</b><br>
<cfif Audit.Year is 2009 OR Audit.Year is 2008 AND Audit.Month gte 10>
<u>Update - October 2008</u><br><a href="matrix.cfm" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage<Br>
</cfif>
<table border="1">
<tr>
<td class="blog-title">Key Processes / Standard Categories</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR/Audit Finding Number(s)*</td>
</tr>
<!--- year of audit is 2007 --->
<cfif Audit.Year is 2007>
<!--- 9/2007 till 12/2007 --->
	<cfif Audit.Month gte 9>
		<CFloop index="i" from="1" to="22">
			<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
<!--- 1/2007 to 9/2007 --->	
	<cfelse>
		<CFloop index="i" from="1" to="16">
			<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
		<!--- this covers the other field --->
			<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[23][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[36][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[36]#</td>
<Td class="blog-content" align="center">#replace(var[36][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
	</cfif>
<!--- before 2007 --->
<cfelseif Audit.Year lt 2007>
	<CFloop index="i" from="1" to="16">
		<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
		</cfoutput>
	</cfloop>
		<!--- this covers the other field --->
			<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[23][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[36][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[36]#</td>
<Td class="blog-content" align="center">#replace(var[36][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>	
<!--- 1/2008 through 9/2008 --->
<cfelseif Audit.Year eq 2008>
	<cfif Audit.Month lte 9>
		<CFloop index="i" from="1" to="22">
			<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
<!--- 10/2008 through 12/2008 --->
	<cfelseif Audit.Month gte 10>
		<CFloop index="i" from="1" to="34">
			<cfoutput query="view1" group="ID">
<!--- other is excluded --->
<tr>
<td class="blog-content" valign="top">#varnew[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
	</cfif>
<cfelseif Audit.Year gte 2009>
	<CFloop index="i" from="1" to="35">
		<cfoutput query="view1" group="ID">
<!--- other is excluded --->
<tr>
<td class="blog-content" valign="top">#varnew[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
		</cfoutput>
	</CFloop>	
<!--- end --->
</cfif>

</table><br>		
		
<cfoutput query="View" group="ID">
<b>Positive Observations</b><br>
#BestPrac#<br>
</cfoutput>
	
<br><b><u>Verified CARs</u></b><br><br>

<cfset var2=ArrayNew(2)>

<cfoutput query="View2">
<CFSET var2[1][1] = #VCAR1#>
<CFSET var2[2][1] = #VCAR2#>
<CFSET var2[3][1] = #VCAR3#>
<CFSET var2[4][1] = #VCAR4#>
<CFSET var2[5][1] = #VCAR5#>
<CFSET var2[6][1] = #VCAR6#>
<CFSET var2[7][1] = #VCAR7#>
<CFSET var2[8][1] = #VCAR8#>
<CFSET var2[9][1] = #VCAR9#>
<CFSET var2[10][1] = #VCAR10#>
<CFSET var2[11][1] = #VCAR11#>
<CFSET var2[12][1] = #VCAR12#>
<CFSET var2[13][1] = #VCAR13#>
<CFSET var2[14][1] = #VCAR14#>
<CFSET var2[15][1] = #VCAR15#>
<CFSET var2[16][1] = #VCAR16#>
<CFSET var2[17][1] = #VCAR17#>
<CFSET var2[18][1] = #VCAR18#>
<CFSET var2[19][1] = #VCAR19#>
<CFSET var2[20][1] = #VCAR20#>

<CFSET var2[1][2] = #Comments1#>
<CFSET var2[2][2] = #Comments2#>
<CFSET var2[3][2] = #Comments3#>
<CFSET var2[4][2] = #Comments4#>
<CFSET var2[5][2] = #Comments5#>
<CFSET var2[6][2] = #Comments6#>
<CFSET var2[7][2] = #Comments7#>
<CFSET var2[8][2] = #Comments8#>
<CFSET var2[9][2] = #Comments9#>
<CFSET var2[10][2] = #Comments10#>
<CFSET var2[11][2] = #Comments11#>
<CFSET var2[12][2] = #Comments12#>
<CFSET var2[13][2] = #Comments13#>
<CFSET var2[14][2] = #Comments14#>
<CFSET var2[15][2] = #Comments15#>
<CFSET var2[16][2] = #Comments16#>
<CFSET var2[17][2] = #Comments17#>
<CFSET var2[18][2] = #Comments18#>
<CFSET var2[19][2] = #Comments19#>
<CFSET var2[20][2] = #Comments20#>
</cfoutput>						  
					  
<table border="1">
<tr>
<td class="blog-title" width="30%">CAR/Audit Finding Number</td>
<td class="blog-title" width="70%">Verification Comments</td>
</tr>
<cfset count = 0>
<cfloop index="i" to="20" from="1">
<cfoutput query="View2">
<cfif var2[i][1] is 0>
<cfset count = count + 1>
<cfif i is 20 and count is 20>
<tr>
<td class="blog-content" valign="top">There are no records</td>
<td class="blog-content" valign="top">&nbsp;</td>
</tr>
</cfif>
<cfelse>
<tr>
<td class="blog-content" valign="top">#var2[i][1]#</td>
<td class="blog-content" valign="top">#var2[i][2]#</td>
</tr>
</cfif>
</cfoutput>
</cfloop>
</table>

<cfif View.Desk is "Yes" AND View.AuditType2 is "Global Function/Process">
<cfelse>
<br><b><u>Program Effectiveness</u></b><br><br>

<cfoutput query="View3" group="ID">		  
<u>Document Control implementation effective?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=1')">[View Effectiveness Criteria]</A>
<br>
<b>#DC#</b><br> 
Comments: #DCComments#
<br><br>

<u>Management Review implementation effective?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=2')">[View Effectiveness Criteria]</A>
<br>
<b>#MR#</b><br>
Comments: #MRComments#
<br><br>

<u>Corrective Action implementation effective?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=3')">[View Effectiveness Criteria]</A>
<br>
<b>#CA#</b><br> 
Comments: #CAComments#
<br><br>

<u>Records implementation effective?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=4')">[View Effectiveness Criteria]</A>
<br>
<b>#RE#</b><br> 
Comments: #REComments#
<br><br>

<u>Internal Audits implementation effective?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=5')">[View Effectiveness Criteria]</A>
<br>
<b>#IA#</b><br> 
Comments: #IAComments#
<br><br>

<!--- added 2/4/2009 --->
<u>Does the Site have access to files and records via the UL Network?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=7')">[View Effectiveness Criteria]</A>
<br>
<b>#Net#</b><br> 
Comments: #NetComments#
<br><br>

<!--- removed 3/5/2009
<u>External Calibration included in Audit?</u><br>
<A HREF="javascript:popUp('help.cfm?ID=8')">[View Effectiveness Criteria]</A>
<br>
<b>#Cal#</b><br> 
Comments: #CalComments#
<br><br>
--->
<!--- // --->
</cfoutput>
</cfif>

<br><b><u>Audit Coverage</u></b><br>
<cfoutput query="output" group="Area">Audit Area - #Area#</cfoutput>
<br><br>

<cfif Audit.Year gte 2009>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses_2009Jan1
	ORDER BY ID
	</cfquery>
<cfelseif Audit.Year lt 2009>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses
	ORDER BY ID
	</cfquery>
</cfif>

<Table width="700">
<tr>
<td class="blog-content">

<Table border="1" width="620">
<tr><td class="blog-content"><b><a href="matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="Clauses">
	<tr><td class="blog-content">
	#title#
	</td></tr> 
</cfoutput>
</table>

</td>
<td class="blog-content">

	<cfif audit.year lt 2009>
<Table border="1" width="80">
<tr><td class="blog-content"><b><cfoutput>#url.year#-#url.id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "035" OR col is "Area" or col is "comments" or col is "Year" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "placeholder">
<cfelse>
 <cfoutput query="Output">
<tr><td class="blog-content">
  <cfif output[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
 </cfoutput>
</cfif>  
</cFLOOP>
</TABLE>
	<cfelseif audit.year gte 2009>
<Table border="1" width="80">
<tr><td class="blog-content"><b><cfoutput>#url.year#-#url.id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "placeholder">
<cfelse>
 <cfoutput query="Output">
<tr><td class="blog-content">
  <cfif output[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
 </cfoutput>
</cfif>  
</cFLOOP>
</TABLE>
	</cfif>

</td>
</tr>
</TABLE>

<table>
<tr>
<td colspan="2" class="blog-content">
<br><u>Audit Coverage Comments</u>:<br>
<cfoutput query="output">
#Comments#
</cfoutput>
<br><br>
</td>
</tr>
</table>

<cfif Check.AuditType2 is "Field Services" or Check.AuditType2 is "Local Function FS">
<cfif view.year lt 2008 OR view.year eq 1008 AND view.month lt 10>
<br><b><u>Audit Coverage - Field Services</u></b><br>

<cfquery name="Clauses" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  A17020  "17020" ORDER BY ID

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<Table width="700">
<tr>
<td class="blog-content">

<Table border="1" width="600">
<tr><td class="blog-content">&nbsp;</td></tr>
<cfoutput query="Clauses">
<tr><td class="blog-content">
	#Clause#
</td></tr> 
</cfoutput>

</table>

</td>
<td class="blog-content">
<Table border="1" width="100">
<tr><td class="blog-content"><b><cfoutput>#url.year#-#url.id#</cfoutput></b></td></tr>
<cfloop list="#outputfs.ColumnList#" index="col">
<cfif col is "comments" or col is "Year" or col is "ID" or col is "auditedby" or col is "Placeholder">
<cfelse>
<cfoutput query="outputfs">
<tr><td class="blog-content">
  <cfif outputfs[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--
  </cfif> 
</td></tr> 
 </cfoutput>
</cfif>  
</cFLOOP>
</TABLE>

</td>
</tr>
</TABLE>

<table>
<tr>
<td colspan="2" class="blog-content">
<br><u>Audit Coverage Comments</u>:<br>
<cfoutput query="outputfs">
#Comments#
</cfoutput>
<br><br>
</td>
</tr>
</table>
</cfif>
</cfif>

<cfoutput>
Return to <a href="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#">Audit Details</a> page.
</cfoutput>

</td></tr></table>

<cfelseif Check.RecordCount eq 1 AND View1.RecordCount eq 0>
	<cfoutput>
	<!--- If the audit report does not exist --->
	<br>
	Audit Report #URL.Year#-#URL.ID#-#URL.AuditedBy# has not been published.<br><br>
	:: <a href="AuditDetails.cfm?#CGI.Query_String#">Audit Details</a>
	</cfoutput>
<cfelseif Check.RecordCount eq 0>
	<cfoutput>
	<!--- If the audit report does not exist --->
	<br>
	Audit #URL.Year#-#URL.ID#-#URL.AuditedBy# does not exist.
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

