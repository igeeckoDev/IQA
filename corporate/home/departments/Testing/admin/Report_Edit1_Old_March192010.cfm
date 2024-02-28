<!--- 8/29/2007 updated findings/obs table to include new key processes for 9/2007 audits, if/then for old audits, also if/then for extra queries for new KP --->

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View"> 
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.Month, AuditSchedule.OfficeName, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, AuditSchedule.AuditType, AuditSchedule.AuditType2, AuditSchedule.Email, AuditSchedule.Email2, Report.Scope, Report.ReportDate, Report.KCInfo, Report.KCInfo2, Report.Summary, Report.BestPrac, Report.Offices, Report.Programs, Report.Sectors

FROM REPORT, AuditSchedule

WHERE Report.ID = #URL.ID# 
AND Report.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = #URL.ID# 
AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND Report.AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year FROM AuditSchedule
WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  
AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<!--- addition of sector drop down for 9/2008 audits and forward --->

<cfif Audit.Year is 2008>
	<cfif Audit.Month gte 9>
	<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate"> 
SELECT * 
FROM CAR_SECTOR "SECTOR" 
ORDER BY Sector
</cfquery>
	</cfif>
<cfelseif Audit.Year gt 2008>
	<CFQUERY BLOCKFACTOR="100" NAME="Sector" DataSource="Corporate"> 
SELECT * 
FROM CAR_SECTOR "SECTOR" 
ORDER BY Sector
</cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View2">
SELECT Report.*, Report.Year_ as Year FROM REPORT
WHERE Report.ID = #URL.ID# 
AND Report.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  
AND Report.AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
SELECT * FROM KP_Report
ORDER BY Alpha
</cfquery>

<CFQUERY name="Programs" Datasource="Corporate">
SELECT IQA, Program FROM ProgDev
WHERE IQA = 1
ORDER BY Program
</CFQUERY>

<cflock scope="SESSION" timeout="60">
	<cfif SESSION.Auth.accesslevel is "RQM">
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Offices">
        SELECT * FROM IQAtblOffices
        WHERE Exist <> 'No'
        AND SubRegion = '#Session.Auth.SubRegion#'
        ORDER BY OfficeName
        </CFQUERY>
    <cfelse>
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Offices">
        SELECT * FROM IQAtblOffices
        WHERE Exist <> 'No'
        ORDER BY OfficeName
        </CFQUERY>
    </cfif>
</cflock>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="date.js"></script>			

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput>
<!-- End UL Net Header--> 
	
		<div align="left">
			<table width="756" border="0" cellpadding="0" cellspacing="0" bgcolor="#cecece" class="table-main">
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
						  
<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A></div>
						  
<cfoutput query="View">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report_Edit2.cfm?#CGI.QUERY_STRING#">

<b><u>General Information and New CARs</u></b><br><br>

<B>Audit Report Number</b><br>
#Year#-#ID#<br><br>

<b>Location</b><br>
#OfficeName#<br>
<cfif AuditType is "Field Services">
#Area#<br>
Audit Area: #AuditArea#<br>
<cfelse>
	<cfif Trim(AuditArea) is "">
	<cfelse>
	Audit Area: #AuditArea#<br>
	#Area#<br>
	</cfif>
</cfif><br>

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
</cfoutput>
<SELECT NAME="Offices" multiple="multiple" size="6" displayname="Additional Offices">
		<OPTION VALUE="NoChanges" selected>No Changes
		<OPTION VALUE="None">- None -		
		<OPTION VALUE="None">----
<CFOUTPUT QUERY="Offices">
		<OPTION VALUE="#OfficeName#!!">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<cfif Audit.Year gt 2008 OR Audit.Year eq 2008 AND Audit.Month gte 9>
<cfoutput query="View">
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
</cfif>
<br><br>
</cfoutput>
<SELECT NAME="Sector" multiple="multiple" size="6" displayname="Sector">
		<OPTION VALUE="NoChanges" selected>No Changes
		<OPTION VALUE="None">- None -
		<OPTION VALUE="None">----
	<CFOUTPUT QUERY="Sector">
		<OPTION VALUE="#Sector#!!">#Sector#
	</CFOUTPUT>
</SELECT><br><br>
<cfelse>
<input type="hidden" name="Sector" value="N/A">
</cfif>

<cfif Audit.AuditType2 is NOT "Program">
<cfoutput query="View">
<b>Programs Sampled During Audit</b><br>
This Audit was conducted on the specified process/location. (See Location/Audit Area above)<br>
The following programs were active at the time of the audit and randomly sampled as a representation of process/location activities.<br>
--------<br>
<cfif Programs is "">
None Listed
<cfelse>
<cfset ProgDump = #replace(Programs, "!!,", "<br>", "All")#>
<cfset ProgDump2 = #replace(ProgDump, "!!", "", "All")#>
<cfset ProgDump3 = #replace(ProgDump2, "NoChanges,", "", "All")#>
<cfset ProgDump4 = #replace(ProgDump3, "None,", "", "All")#>
#ProgDump4#
</cfif>
<br><br>
</cfoutput>
<SELECT NAME="Programs" multiple="multiple" size="6" displayname="Additional Programs">
		<OPTION VALUE="NoChanges" selected>No Changes
		<OPTION VALUE="None">- None -		
		<OPTION VALUE="None">----
<CFOUTPUT QUERY="Programs">
<cfif Program is NOT "_test">
		<OPTION VALUE="#Program#!!">#Program#
</cfif>
</CFOUTPUT>
</SELECT>
<br><br>
</cfif>

<cfoutput query="View">
<b>Audit Dates</b><br>
<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">
    
	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>
	
	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>
    
    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#<Br /><br>

<b>Report Date</b><br>
<input type="text" name="e_ReportDate" value="#Dateformat(ReportDate, 'mm/dd/yyyy')#" displayname="Report Date">
<br><br>

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

<b>Scope</b><br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="90" NAME="Scope" displayname="Scope">#Scope#</textarea>
<br><br>

<cfif year gt 2009 OR year eq 2009 AND month gte 4>
	<b>Primary Contact</b><br>
	<INPUT TYPE="hidden" NAME="KCInfo" VALUE="#KCInfo#">
	<cfset Dump = #replace(KCInfo, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	#Dump1#
	<br><br>
	
	<b>Other Contacts</b><br>
	<INPUT TYPE="hidden" NAME="KCInfo2" VALUE="#KCInfo2#">
	<cfset Dump = #replace(KCInfo2, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	<cfif len(Dump1)>
		#Dump1#
	<cfelse>
		None Listed
	</cfif>
	<br><br>
<cfelse>
	<b>Contact Email</b><br>
	<INPUT TYPE="TEXT" NAME="e_KCInfo" size="110" VALUE="#KCInfo#" displayname="Contact Email">
	<INPUT TYPE="hidden" NAME="KCInfo2" VALUE="#KCInfo2#">
	<br><br>
</cfif>

<b>Audit Summary</b><br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="90" NAME="Summary" displayname="Audit Summary">#Summary# </textarea>
<br><br>
</cfoutput>						  
						  
<cfset var=ArrayNew(3)>
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

<cfoutput query="View2">
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
</cfoutput>

<cfset var2=ArrayNew(2)>

<CFSET var2[1][1] = 'CAR1'>
<CFSET var2[2][1] = 'CAR2'>
<CFSET var2[3][1] = 'CAR3'>
<CFSET var2[4][1] = 'CAR4'>
<CFSET var2[5][1] = 'CAR5'>
<CFSET var2[6][1] = 'CAR6'>
<CFSET var2[7][1] = 'CAR7'>
<CFSET var2[8][1] = 'CAR8'>
<CFSET var2[9][1] = 'CAR9'>
<CFSET var2[10][1] = 'CAR10'>
<CFSET var2[11][1] = 'CAR11'>
<CFSET var2[12][1] = 'CAR12'>
<CFSET var2[13][1] = 'CAR13'>
<CFSET var2[14][1] = 'CAR14'>
<CFSET var2[15][1] = 'CAR15'>
<CFSET var2[16][1] = 'CAR16'>
<CFSET var2[17][1] = 'CAR17'>
<CFSET var2[18][1] = 'CAR18'>
<CFSET var2[19][1] = 'CAR19'>
<CFSET var2[20][1] = 'CAR20'>
<CFSET var2[21][1] = 'CAR21'>
<CFSET var2[22][1] = 'CAR22'>
<CFSET var2[23][1] = 'CAR23'>
<CFSET var2[24][1] = 'CAR24'>
<CFSET var2[25][1] = 'CAR25'>
<CFSET var2[26][1] = 'CAR26'>
<CFSET var2[27][1] = 'CAR27'>
<CFSET var2[28][1] = 'CAR28'>
<CFSET var2[29][1] = 'CAR29'>
<CFSET var2[30][1] = 'CAR30'>
<CFSET var2[31][1] = 'CAR31'>
<CFSET var2[32][1] = 'CAR32'>
<CFSET var2[33][1] = 'CAR33'>
<CFSET var2[34][1] = 'CAR34'>
<CFSET var2[35][1] = 'CAR35'>

<CFSET var2[1][2] = 'Count1'>
<CFSET var2[2][2] = 'Count2'>
<CFSET var2[3][2] = 'Count3'>
<CFSET var2[4][2] = 'Count4'>
<CFSET var2[5][2] = 'Count5'>
<CFSET var2[6][2] = 'Count6'>
<CFSET var2[7][2] = 'Count7'>
<CFSET var2[8][2] = 'Count8'>
<CFSET var2[9][2] = 'Count9'>
<CFSET var2[10][2] = 'Count10'>
<CFSET var2[11][2] = 'Count11'>
<CFSET var2[12][2] = 'Count12'>
<CFSET var2[13][2] = 'Count13'>
<CFSET var2[14][2] = 'Count14'>
<CFSET var2[15][2] = 'Count15'>
<CFSET var2[16][2] = 'Count16'>
<CFSET var2[17][2] = 'Count17'>
<CFSET var2[18][2] = 'Count18'>
<CFSET var2[19][2] = 'Count19'>
<CFSET var2[20][2] = 'Count20'>
<CFSET var2[21][2] = 'Count21'>
<CFSET var2[22][2] = 'Count22'>
<CFSET var2[23][2] = 'Count23'>
<CFSET var2[24][2] = 'Count24'>
<CFSET var2[25][2] = 'Count25'>
<CFSET var2[26][2] = 'Count26'>
<CFSET var2[27][2] = 'Count27'>
<CFSET var2[28][2] = 'Count28'>
<CFSET var2[29][2] = 'Count29'>
<CFSET var2[30][2] = 'Count30'>
<CFSET var2[31][2] = 'Count31'>
<CFSET var2[32][2] = 'Count32'>
<CFSET var2[33][2] = 'Count33'>
<CFSET var2[34][2] = 'Count34'>
<CFSET var2[35][2] = 'Count35'>

<cfset var3=ArrayNew(2)>
<cfoutput query="View2">
<CFSET var3[1][1] = '#OCount1#'>
<CFSET var3[2][1] = '#OCount2#'>
<CFSET var3[3][1] = '#OCount3#'>
<CFSET var3[4][1] = '#OCount4#'>
<CFSET var3[5][1] = '#OCount5#'>
<CFSET var3[6][1] = '#OCount6#'>
<CFSET var3[7][1] = '#OCount7#'>
<CFSET var3[8][1] = '#OCount8#'>
<CFSET var3[9][1] = '#OCount9#'>
<CFSET var3[10][1] = '#OCount10#'>
<CFSET var3[11][1] = '#OCount11#'>
<CFSET var3[12][1] = '#OCount12#'>
<CFSET var3[13][1] = '#OCount13#'>
<CFSET var3[14][1] = '#OCount14#'>
<CFSET var3[15][1] = '#OCount15#'>
<CFSET var3[16][1] = '#OCount16#'>
<CFSET var3[17][1] = '#OCount17#'>
<CFSET var3[18][1] = '#OCount18#'>
<CFSET var3[19][1] = '#OCount19#'>
<CFSET var3[20][1] = '#OCount20#'>
<CFSET var3[21][1] = '#OCount21#'>
<CFSET var3[22][1] = '#OCount22#'>
<CFSET var3[23][1] = '#OCount23#'>
<CFSET var3[24][1] = '#OCount24#'>
<CFSET var3[25][1] = '#OCount25#'>
<CFSET var3[26][1] = '#OCount26#'>
<CFSET var3[27][1] = '#OCount27#'>
<CFSET var3[28][1] = '#OCount28#'>
<CFSET var3[29][1] = '#OCount29#'>
<CFSET var3[30][1] = '#OCount30#'>
<CFSET var3[31][1] = '#OCount31#'>
<CFSET var3[32][1] = '#OCount32#'>
<CFSET var3[33][1] = '#OCount33#'>
<CFSET var3[34][1] = '#OCount34#'>
<CFSET var3[35][1] = '#OCount35#'>

<CFSET var3[1][2] = 'OCount1'>
<CFSET var3[2][2] = 'OCount2'>
<CFSET var3[3][2] = 'OCount3'>
<CFSET var3[4][2] = 'OCount4'>
<CFSET var3[5][2] = 'OCount5'>
<CFSET var3[6][2] = 'OCount6'>
<CFSET var3[7][2] = 'OCount7'>
<CFSET var3[8][2] = 'OCount8'>
<CFSET var3[9][2] = 'OCount9'>
<CFSET var3[10][2] = 'OCount10'>
<CFSET var3[11][2] = 'OCount11'>
<CFSET var3[12][2] = 'OCount12'>
<CFSET var3[13][2] = 'OCount13'>
<CFSET var3[14][2] = 'OCount14'>
<CFSET var3[15][2] = 'OCount15'>
<CFSET var3[16][2] = 'OCount16'>
<CFSET var3[17][2] = 'OCount17'>
<CFSET var3[18][2] = 'OCount18'>
<CFSET var3[19][2] = 'OCount19'>
<CFSET var3[20][2] = 'OCount20'>
<CFSET var3[21][2] = 'OCount21'>
<CFSET var3[22][2] = 'OCount22'>
<CFSET var3[23][2] = 'OCount23'>
<CFSET var3[24][2] = 'OCount24'>
<CFSET var3[25][2] = 'OCount25'>
<CFSET var3[26][2] = 'OCount26'>
<CFSET var3[27][2] = 'OCount27'>
<CFSET var3[28][2] = 'OCount28'>
<CFSET var3[29][2] = 'OCount29'>
<CFSET var3[30][2] = 'OCount30'>
<CFSET var3[31][2] = 'OCount31'>
<CFSET var3[32][2] = 'OCount32'>
<CFSET var3[33][2] = 'OCount33'>
<CFSET var3[34][2] = 'OCount34'>
<CFSET var3[35][2] = 'OCount35'>
</cfoutput>

<b>Non-Conformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR numbers with a comma
<cfif Audit.Year is 2009 OR Audit.Year is 2008 AND Audit.Month gte 10>
<br><br>
<u>Update - October 2008</u><br><a href="../matrix.cfm" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage
</cfif><br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes / Standard Categories</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR/Audit Finding Number(s)*</td>
</tr>
<cfif Audit.Year is 2007>
	<cfif Audit.Month gte 9>
<CFloop index="i" from="1" to="22">
<cfoutput query="view2">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var2[i][2]#" value="#var[i][3][3]#" size="3" displayname="#var[i][1][1]# Number of Findings" validate="integer" message="#var[i][1][1]# Number of Findings - Please Enter a Number"></td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var3[i][2]#" value="#var3[i][1]#" size="3" displayname="#var[i][1][1]# Number of Observations" validate="integer" message="#var[i][1][1]# Number of Observations - Please Enter a Number"></td>
<Td class="blog-content" align="center"><input type="text" name="e_#var2[i][1]#" value="#var[i][2][2]#" size="25" displayname="#var[i][1][1]# CAR Numbers"></td>
</tr>
</cfoutput>
</CFloop>
	<cfelse><!--- 1/2007 to 8/2007 --->
<CFloop index="i" from="1" to="16">
<cfoutput query="view2">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var2[i][2]#" value="#var[i][3][3]#" size="3" displayname="#var[i][1][1]# Number of Findings" validate="integer" message="#var[i][1][1]# Number of Findings - Please Enter a Number"></td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var3[i][2]#" value="#var3[i][1]#" size="3" displayname="#var[i][1][1]# Number of Observations" validate="integer" message="#var[i][1][1]# Number of Observations - Please Enter a Number"></td>
<Td class="blog-content" align="center"><input type="text" name="e_#var2[i][1]#" value="#var[i][2][2]#" size="25" displayname="#var[i][1][1]# CAR Numbers"></td>
</tr>
</cfoutput>
</CFloop>
	</cfif>
<cfelseif Audit.Year lt 2007>
<CFloop index="i" from="1" to="16">
<cfoutput query="view2">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var2[i][2]#" value="#var[i][3][3]#" size="3" displayname="#var[i][1][1]# Number of Findings" validate="integer" message="#var[i][1][1]# Number of Findings - Please Enter a Number"></td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var3[i][2]#" value="#var3[i][1]#" size="3" displayname="#var[i][1][1]# Number of Observations" validate="integer" message="#var[i][1][1]# Number of Observations - Please Enter a Number"></td>
<Td class="blog-content" align="center"><input type="text" name="e_#var2[i][1]#" value="#var[i][2][2]#" size="25" displayname="#var[i][1][1]# CAR Numbers"></td>
</tr>
</cfoutput>
</CFloop>
<cfelseif Audit.Year eq 2008>
	<cfif Audit.Month lt 10>
<CFloop index="i" from="1" to="22">
<cfoutput query="view2">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var2[i][2]#" value="#var[i][3][3]#" size="3" displayname="#var[i][1][1]# Number of Findings" validate="integer" message="#var[i][1][1]# Number of Findings - Please Enter a Number"></td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var3[i][2]#" value="#var3[i][1]#" size="3" displayname="#var[i][1][1]# Number of Observations" validate="integer" message="#var[i][1][1]# Number of Observations - Please Enter a Number"></td>
<Td class="blog-content" align="center"><input type="text" name="e_#var2[i][1]#" value="#var[i][2][2]#" size="25" displayname="#var[i][1][1]# CAR Numbers"></td>
</tr>
</cfoutput>
</CFloop>
	<cfelseif Audit.Month gte 10>
<CFloop index="i" from="1" to="34">
<cfoutput query="view2">
<tr>
<td class="blog-content" valign="top">#varnew[i][1][1]#</td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var2[i][2]#" value="#var[i][3][3]#" size="3" displayname="#varNew[i][1][1]# Number of Findings" validate="integer" message="#varNew[i][1][1]# Number of Findings - Please Enter a Number"></td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var3[i][2]#" value="#var3[i][1]#" size="3" displayname="#varNew[i][1][1]# Number of Observations" validate="integer" message="#varNew[i][1][1]# Number of Observations - Please Enter a Number"></td>
<Td class="blog-content" align="center"><input type="text" name="e_#var2[i][1]#" value="#var[i][2][2]#" size="25" displayname="#varNew[i][1][1]# CAR Numbers"></td>
</tr>
</cfoutput>
</CFloop>	
	</cfif>
<!--- 2009 and future --->
<cfelseif Audit.Year gte 2009>
<CFloop index="i" from="1" to="35">
<cfoutput query="view2">
<tr>
<td class="blog-content" valign="top">#varnew[i][1][1]#</td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var2[i][2]#" value="#var[i][3][3]#" size="3" displayname="#varNew[i][1][1]# Number of Findings" validate="integer" message="#varNew[i][1][1]# Number of Findings - Please Enter a Number"></td>
<td class="blog-content" valign="top" align="center"><input type="text" name="e_#var3[i][2]#" value="#var3[i][1]#" size="3" displayname="#varNew[i][1][1]# Number of Observations" validate="integer" message="#varNew[i][1][1]# Number of Observations - Please Enter a Number"></td>
<Td class="blog-content" align="center"><input type="text" name="e_#var2[i][1]#" value="#var[i][2][2]#" size="25" displayname="#varNew[i][1][1]# CAR Numbers"></td>
</tr>
</cfoutput>
</CFloop>
</cfif>
</table><br>		
		
<cfoutput query="View" group="ID">
<b>Positive Observations</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="BestPrac">#BestPrac#</textarea>
<br><br>
</cfoutput>
	
<br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM><br><br>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

