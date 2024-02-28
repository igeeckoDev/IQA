<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID, AuditSchedule.AuditedBy,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Auditor, AuditSchedule.LeadAuditor, AuditSchedule.AuditType, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.KCPhone, ExternalLocation.ExternalLocation, ExternalLocation.Type
 FROM AuditSchedule, ExternalLocation
 WHERE AuditSchedule.ID = #URL.ID# 
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAA">
SELECT * FROM CAPAA
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View_AA">
SELECT * FROM TPReportCAPAA
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View2">
SELECT * FROM TPREPORT2
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View3">
SELECT * FROM TPREPORT3
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View4">
SELECT * FROM TPREPORT4
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
<table>
<tr>	
<td class="blog-content" align="left" width="600"><p align="left">

<b>Section 1 - General Information and Nonconformances</b><br><br>		
						  
<cfoutput query="Audit">		
<B>Audit Report Number</b><br>
#Year#-#ID#<br><br>

<b>Location</b><br>
#ExternalLocation#<br><br>

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
</cfoutput>

<cfoutput query="View">
<b>Audit Report Date</b><br>
#DateFormat(ReportDate, 'mmmm dd, yyyy')#<br><br>
</cfoutput>

<cfoutput query="Audit">
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
#AuditType#, #Type#<br><br>
</cfoutput>

<cfoutput query="View">
<b>Scope</b><br>
#Scope#<br><br>
</cfoutput>

<cfoutput query="Audit">
<b>Key Contact</b><br>
#KC#<br><br>
<b>Contact Email</b><br>
#KCEmail#<br><br>
<b>Contact Phone</b><br>
#KCPhone#<br><br>
</cfoutput>

<cfoutput query="View">
<b>Laboratory Certifications?</b><br>
#LabCert#<br><br>

<b>Laboratory Certifications Comments</b><br>
#LabCertNotes#<br><br>

<b>Number of Projects Submitted (since previous GALO)</b><br>
#ProjectsCompleted#<br><br>

<b>Number of People in Facility</b><br>
#PeopleInFacility#<br><br>

<b>Audit Summary</b><br>
#Summary#<br><br>
</cfoutput>

<cfset var=ArrayNew(3)>

<CFSET var[1][1][1] = '4.1 Organization'>
<CFSET var[2][1][1] = '4.2 Quality System'>
<CFSET var[3][1][1] = '4.3 Document Control'>
<CFSET var[4][1][1] = '4.4 Review of Requests, Tenders, and Contracts'>
<CFSET var[5][1][1] = '4.5 Sub-Contracting of Tests and Calibrations'>
<CFSET var[6][1][1] = '4.6 Purchasing Services and Supplies'>
<CFSET var[7][1][1] = '4.7 Service to Client'>
<CFSET var[8][1][1] = '4.8 Complaints'>
<CFSET var[9][1][1] = '4.9 Control of Non-Conforming Tests and Calibrations'>
<CFSET var[10][1][1] = '4.10 Improvement'>
<CFSET var[11][1][1] = '4.11 Corrective Action'>
<CFSET var[12][1][1] = '4.12 Preventive Action'>
<CFSET var[13][1][1] = '4.13 Control of Records'>
<CFSET var[14][1][1] = '4.14 Internal Audits'>
<CFSET var[15][1][1] = '4.15 Management Review'>
<CFSET var[16][1][1] = '5.1 General Technical Requirements'>
<CFSET var[17][1][1] = '5.2 Personnel'>
<CFSET var[18][1][1] = '5.3 Accommodation and Environmental Conditions'>
<CFSET var[19][1][1] = '5.4 Test and Calibration Methods and Method Validation'>
<CFSET var[20][1][1] = '5.5 Equipment'>
<CFSET var[21][1][1] = '5.6 Measuring Traceability'>
<CFSET var[22][1][1] = '5.7 Sampling'>
<CFSET var[23][1][1] = '5.8 Handling of Test and Calibration Items'>
<CFSET var[24][1][1] = '5.9 Assuring the Quality of Test and Calibration Results'>
<CFSET var[25][1][1] = '5.10 Reporting Results'>
<CFSET var[26][1][1] = 'Other'>

<cfoutput query="View">
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
<CFSET var[26][2][2] = '#CAROther#'>

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
<CFSET var[26][3][3] = '#CountOther#'>

<cfset var4=ArrayNew(1)>
<CFSET var4[1] = '#OCount1#'>
<CFSET var4[2] = '#OCount2#'>
<CFSET var4[3] = '#OCount3#'>
<CFSET var4[4] = '#OCount4#'>
<CFSET var4[5] = '#OCount5#'>
<CFSET var4[6] = '#OCount6#'>
<CFSET var4[7] = '#OCount7#'>
<CFSET var4[8] = '#OCount8#'>
<CFSET var4[9] = '#OCount9#'>
<CFSET var4[10] = '#OCount10#'>
<CFSET var4[11] = '#OCount11#'>
<CFSET var4[12] = '#OCount12#'>
<CFSET var4[13] = '#OCount13#'>
<CFSET var4[14] = '#OCount14#'>
<CFSET var4[15] = '#OCount15#'>
<CFSET var4[16] = '#OCount16#'>
<CFSET var4[17] = '#OCount17#'>
<CFSET var4[18] = '#OCount18#'>
<CFSET var4[19] = '#OCount19#'>
<CFSET var4[20] = '#OCount20#'>
<CFSET var4[21] = '#OCount21#'>
<CFSET var4[22] = '#OCount22#'>
<CFSET var4[23] = '#OCount23#'>
<CFSET var4[24] = '#OCount24#'>
<CFSET var4[25] = '#OCount25#'>
<CFSET var4[26] = '#OCountOther#'>
</cfoutput>

<cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">
<cfset var2=ArrayNew(3)>

<CFSET var2[1][1][1] = '6.0 Ethical Considerations'>
<CFSET var2[2][1][1] = '7.0 Communication Control and Review'>
<CFSET var2[3][1][1] = '8.0 Submittal Control and Review'>
<CFSET var2[4][1][1] = '9.0 Corrective Action'>
<CFSET var2[5][1][1] = '10.0 Records'>
<CFSET var2[6][1][1] = '11.0 Training'>
<CFSET var2[7][1][1] = '12.1 Specific Responsibilities - General'>
<CFSET var2[8][1][1] = '12.2 Specific Responsibilities - Applications and Agreements'>
<CFSET var2[9][1][1] = '12.3 Specific Responsibilities - Product Submittals'>
<CFSET var2[10][1][1] = '12.4 Specific Responsibilities - Factory var2iation Notices'>
<CFSET var2[11][1][1] = '12.5 Specific Responsibilities - Eng. and Follow-Up Test Samples'>
<CFSET var2[12][1][1] = '12.6 Specific Responsibilities - Accounting and Billing'>
<CFSET var2[13][1][1] = '12.7 Specific Responsibilities - UL Mark Handling'>
<CFSET var2[14][1][1] = '12.8 Specific Responsibilities - UL Certificated Agency Symbol'>

<cfoutput query="View_AA">
<CFSET var2[1][2][2] = '#CAPAA1#'>
<CFSET var2[2][2][2] = '#CAPAA2#'>
<CFSET var2[3][2][2] = '#CAPAA3#'>
<CFSET var2[4][2][2] = '#CAPAA4#'>
<CFSET var2[5][2][2] = '#CAPAA5#'>
<CFSET var2[6][2][2] = '#CAPAA6#'>
<CFSET var2[7][2][2] = '#CAPAA7#'>
<CFSET var2[8][2][2] = '#CAPAA8#'>
<CFSET var2[9][2][2] = '#CAPAA9#'>
<CFSET var2[10][2][2] = '#CAPAA10#'>
<CFSET var2[11][2][2] = '#CAPAA11#'>
<CFSET var2[12][2][2] = '#CAPAA12#'>
<CFSET var2[13][2][2] = '#CAPAA13#'>
<CFSET var2[14][2][2] = '#CAPAA14#'>

<CFSET var2[1][3][3] = '#AACount1#'>
<CFSET var2[2][3][3] = '#AACount2#'>
<CFSET var2[3][3][3] = '#AACount3#'>
<CFSET var2[4][3][3] = '#AACount4#'>
<CFSET var2[5][3][3] = '#AACount5#'>
<CFSET var2[6][3][3] = '#AACount6#'>
<CFSET var2[7][3][3] = '#AACount7#'>
<CFSET var2[8][3][3] = '#AACount8#'>
<CFSET var2[9][3][3] = '#AACount9#'>
<CFSET var2[10][3][3] = '#AACount10#'>
<CFSET var2[11][3][3] = '#AACount11#'>
<CFSET var2[12][3][3] = '#AACount12#'>
<CFSET var2[13][3][3] = '#AACount13#'>
<CFSET var2[14][3][3] = '#AACount14#'>

<cfset var3=ArrayNew(1)>
<CFSET var3[1] = '#OAACount1#'>
<CFSET var3[2] = '#OAACount2#'>
<CFSET var3[3] = '#OAACount3#'>
<CFSET var3[4] = '#OAACount4#'>
<CFSET var3[5] = '#OAACount5#'>
<CFSET var3[6] = '#OAACount6#'>
<CFSET var3[7] = '#OAACount7#'>
<CFSET var3[8] = '#OAACount8#'>
<CFSET var3[9] = '#OAACount9#'>
<CFSET var3[10] = '#OAACount10#'>
<CFSET var3[11] = '#OAACount11#'>
<CFSET var3[12] = '#OAACount12#'>
<CFSET var3[13] = '#OAACount13#'>
<CFSET var3[14] = '#OAACount14#'>
</cfoutput>
</cfif>

<b>Nonconformances</b><br><br>
*Responses to findings should be sent to ULLABCAR@ul.com<br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR Number(s)*</td>
</tr>
<CFloop index="i" from="1" to="25">
<cfoutput query="view" group="ID">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#&nbsp;</td>
<td class="blog-content" valign="top" align="center">#var4[i]#&nbsp;</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#&nbsp;</td>
</tr>
</cfoutput>
</CFloop>

<cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">
<tr>
<td colspan="4" class="blog-title">CAP AA Requirements</td>
</tr>
<CFloop index="i" from="1" to="14">
<cfoutput query="view_AA" group="ID">
<tr>
<td class="blog-content" valign="top">#var2[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var2[i][3][3]#&nbsp;</td>
<td class="blog-content" valign="top" align="center">#var3[i]#&nbsp;</td>
<Td class="blog-content" align="center">#replace(var2[i][2][2], ",", "<br>", "All")#&nbsp;</td>
</tr>
</cfoutput>
</CFloop>
</cfif>

<cfoutput query="View">
<tr>
<td class="blog-content">&nbsp;</td>
<td class="blog-content">&nbsp;</td>
<td class="blog-content">&nbsp;</td>
<td class="blog-content">&nbsp;</td>
</tr>
<tr>
<td class="blog-content" valign="top">Other</td>
<td class="blog-content" valign="top" align="center">#CountOther#</td>
<td class="blog-content" valign="top" align="center">#OCountOther#</td>
<Td class="blog-content" align="center">#replace(CAROther, ",", "<br>", "All")#&nbsp;</td>
</tr>
</table><br>

<b>Positive Observations or Best Practices</b><br>
#BestPrac#<br><br>
</cfoutput>

</td></tr></table>
</body>
</html>
