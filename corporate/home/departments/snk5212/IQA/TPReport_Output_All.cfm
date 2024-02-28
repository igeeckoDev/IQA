<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT AuditSchedule.ID, AuditSchedule.AuditedBy,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Auditor, AuditSchedule.LeadAuditor, AuditSchedule.AuditType, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.KCPhone, ExternalLocation.ExternalLocation, ExternalLocation.Type
FROM AuditSchedule, ExternalLocation
WHERE AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND  AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAA">
SELECT * FROM CAPAA
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View_AA">
SELECT TPReportCAPAA.*, TPReportCAPAA.Yaer_ AS "Year" FROM TPReportCAPAA
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT TPReport.*, TPReport.Year_ AS "Year" FROM TPREPORT
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ViewRecommend"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT TPReport.ID,"TPREPORT".YEAR_ as "Year", TPReport.Recommend, Recommend.ID, Recommend.Recommend, Recommend.Text
FROM Recommend, TPReport
WHERE TPReport.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND  TPReport.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND  TPReport.Recommend = Recommend.ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View2">
SELECT TPReport2.*, TPReport2.Year_ AS "Year" 
FROM TPREPORT2
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View3">
SELECT TPReport3.*, TPReport3.Year_ AS "Year"
FROM TPREPORT3
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View4">
SELECT TPReport4.*, TPReport4.Year_ AS "Year"
FROM TPREPORT4
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "TPTDP Audit Report - <cfoutput>#url.year#-#url.id#-#url.auditedby#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->
		
<br>
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
<b>Other Laboratory Certifications/Accreditations?</b><br>
#LabCert#<br><br>

<b>Other Laboratory Certifications/Accreditations Comments</b><br>
#LabCertNotes#<br><br>

<b>Number of Projects Completed Last Year</b><br>
#ProjectsCompleted#<br><br>

<b>Number of People in Facility</b><br>
#PeopleInFacility#<br><br>

<b>Audit Summary</b><br>
#Summary#<br><br>
</cfoutput>

<cfoutput query="ViewRecommend">
<b>Recommendation</b><br>
#text#<br><br>
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

<b>Nonconformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR numbers with a comma<br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR/Audit Finding Number(s)*</td>
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

<hr>

<b>Section 2 - Verified CARs</b>

<br><br>
<cfset var=ArrayNew(3)>

<cfoutput query="View2">
<CFSET var[1][1][1] = '#VCAR1#'>
<CFSET var[2][1][1] = '#VCAR2#'>
<CFSET var[3][1][1] = '#VCAR3#'>
<CFSET var[4][1][1] = '#VCAR4#'>
<CFSET var[5][1][1] = '#VCAR5#'>
<CFSET var[6][1][1] = '#VCAR6#'>
<CFSET var[7][1][1] = '#VCAR7#'>
<CFSET var[8][1][1] = '#VCAR8#'>
<CFSET var[9][1][1] = '#VCAR9#'>
<CFSET var[10][1][1] = '#VCAR10#'>
<CFSET var[11][1][1] = '#VCAR11#'>
<CFSET var[12][1][1] = '#VCAR12#'>
<CFSET var[13][1][1] = '#VCAR13#'>
<CFSET var[14][1][1] = '#VCAR14#'>
<CFSET var[15][1][1] = '#VCAR15#'>
<CFSET var[16][1][1] = '#VCAR16#'>
<CFSET var[17][1][1] = '#VCAR17#'>
<CFSET var[18][1][1] = '#VCAR18#'>
<CFSET var[19][1][1] = '#VCAR19#'>
<CFSET var[20][1][1] = '#VCAR20#'>

<CFSET var[1][2][2] = '#Comments1#'>
<CFSET var[2][2][2] = '#Comments2#'>
<CFSET var[3][2][2] = '#Comments3#'>
<CFSET var[4][2][2] = '#Comments4#'>
<CFSET var[5][2][2] = '#Comments5#'>
<CFSET var[6][2][2] = '#Comments6#'>
<CFSET var[7][2][2] = '#Comments7#'>
<CFSET var[8][2][2] = '#Comments8#'>
<CFSET var[9][2][2] = '#Comments9#'>
<CFSET var[10][2][2] = '#Comments10#'>
<CFSET var[11][2][2] = '#Comments11#'>
<CFSET var[12][2][2] = '#Comments12#'>
<CFSET var[13][2][2] = '#Comments13#'>
<CFSET var[14][2][2] = '#Comments14#'>
<CFSET var[15][2][2] = '#Comments15#'>
<CFSET var[16][2][2] = '#Comments16#'>
<CFSET var[17][2][2] = '#Comments17#'>
<CFSET var[18][2][2] = '#Comments18#'>
<CFSET var[19][2][2] = '#Comments19#'>
<CFSET var[20][2][2] = '#Comments20#'>

<CFSET var[1][3][3] = '#Effective1#'>
<CFSET var[2][3][3] = '#Effective2#'>
<CFSET var[3][3][3] = '#Effective3#'>
<CFSET var[4][3][3] = '#Effective4#'>
<CFSET var[5][3][3] = '#Effective5#'>
<CFSET var[6][3][3] = '#Effective6#'>
<CFSET var[7][3][3] = '#Effective7#'>
<CFSET var[8][3][3] = '#Effective8#'>
<CFSET var[9][3][3] = '#Effective9#'>
<CFSET var[10][3][3] = '#Effective10#'>
<CFSET var[11][3][3] = '#Effective11#'>
<CFSET var[12][3][3] = '#Effective12#'>
<CFSET var[13][3][3] = '#Effective13#'>
<CFSET var[14][3][3] = '#Effective14#'>
<CFSET var[15][3][3] = '#Effective15#'>
<CFSET var[16][3][3] = '#Effective16#'>
<CFSET var[17][3][3] = '#Effective17#'>
<CFSET var[18][3][3] = '#Effective18#'>
<CFSET var[19][3][3] = '#Effective19#'>
<CFSET var[20][3][3] = '#Effective20#'>
</cfoutput>	  
					  
					
<br>
					  
<table border="1">
<tr>
<td class="blog-title">CAR/Audit Finding Number</td>
<td class="blog-title">Effective Implementation?</td>
<td class="blog-title">Verification Comments</td>
</tr>
<cfloop index="i" to="20" from="1">
<cfoutput query="View2">
<cfif var[i][1][1] is 0>
<cfelse>
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top">#var[i][3][3]#&nbsp;</td>
<td class="blog-content" valign="top">#var[i][2][2]#&nbsp;</td>
</tr>
</cfif>
</cfoutput>
</cfloop>
</table>

<hr>

<b>Section 3 - Repeat CARs</b>
<br><br>

<cfset var=ArrayNew(3)>

<cfoutput query="View3">
<CFSET var[1][1][1] = '#RCAR1#'>
<CFSET var[2][1][1] = '#RCAR2#'>
<CFSET var[3][1][1] = '#RCAR3#'>
<CFSET var[4][1][1] = '#RCAR4#'>
<CFSET var[5][1][1] = '#RCAR5#'>
<CFSET var[6][1][1] = '#RCAR6#'>
<CFSET var[7][1][1] = '#RCAR7#'>
<CFSET var[8][1][1] = '#RCAR8#'>
<CFSET var[9][1][1] = '#RCAR9#'>
<CFSET var[10][1][1] = '#RCAR10#'>
<CFSET var[11][1][1] = '#RCAR11#'>
<CFSET var[12][1][1] = '#RCAR12#'>
<CFSET var[13][1][1] = '#RCAR13#'>
<CFSET var[14][1][1] = '#RCAR14#'>
<CFSET var[15][1][1] = '#RCAR15#'>
<CFSET var[16][1][1] = '#RCAR16#'>
<CFSET var[17][1][1] = '#RCAR17#'>
<CFSET var[18][1][1] = '#RCAR18#'>
<CFSET var[19][1][1] = '#RCAR19#'>
<CFSET var[20][1][1] = '#RCAR20#'>

<CFSET var[1][2][2] = '#Comments1#'>
<CFSET var[2][2][2] = '#Comments2#'>
<CFSET var[3][2][2] = '#Comments3#'>
<CFSET var[4][2][2] = '#Comments4#'>
<CFSET var[5][2][2] = '#Comments5#'>
<CFSET var[6][2][2] = '#Comments6#'>
<CFSET var[7][2][2] = '#Comments7#'>
<CFSET var[8][2][2] = '#Comments8#'>
<CFSET var[9][2][2] = '#Comments9#'>
<CFSET var[10][2][2] = '#Comments10#'>
<CFSET var[11][2][2] = '#Comments11#'>
<CFSET var[12][2][2] = '#Comments12#'>
<CFSET var[13][2][2] = '#Comments13#'>
<CFSET var[14][2][2] = '#Comments14#'>
<CFSET var[15][2][2] = '#Comments15#'>
<CFSET var[16][2][2] = '#Comments16#'>
<CFSET var[17][2][2] = '#Comments17#'>
<CFSET var[18][2][2] = '#Comments18#'>
<CFSET var[19][2][2] = '#Comments19#'>
<CFSET var[20][2][2] = '#Comments20#'>

<CFSET var[1][3][3] = '#NewCAR1#'>
<CFSET var[2][3][3] = '#NewCAR2#'>
<CFSET var[3][3][3] = '#NewCAR3#'>
<CFSET var[4][3][3] = '#NewCAR4#'>
<CFSET var[5][3][3] = '#NewCAR5#'>
<CFSET var[6][3][3] = '#NewCAR6#'>
<CFSET var[7][3][3] = '#NewCAR7#'>
<CFSET var[8][3][3] = '#NewCAR8#'>
<CFSET var[9][3][3] = '#NewCAR9#'>
<CFSET var[10][3][3] = '#NewCAR10#'>
<CFSET var[11][3][3] = '#NewCAR11#'>
<CFSET var[12][3][3] = '#NewCAR12#'>
<CFSET var[13][3][3] = '#NewCAR13#'>
<CFSET var[14][3][3] = '#NewCAR14#'>
<CFSET var[15][3][3] = '#NewCAR15#'>
<CFSET var[16][3][3] = '#NewCAR16#'>
<CFSET var[17][3][3] = '#NewCAR17#'>
<CFSET var[18][3][3] = '#NewCAR18#'>
<CFSET var[19][3][3] = '#NewCAR19#'>
<CFSET var[20][3][3] = '#NewCAR20#'>
</cfoutput>	  

<br>
					  
<table border="1">
<tr>
<td class="blog-title">Old CAR/Audit Finding Number</td>
<td class="blog-title">New CAR/Audit Finding Number</td>
<td class="blog-title">Verification Comments</td>
</tr>
<cfloop index="i" to="20" from="1">
<cfoutput query="View3">
<cfif var[i][1][1] is 0>
<cfelse>
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top">#var[i][3][3]#</td>
<td class="blog-content" valign="top">#var[i][2][2]#&nbsp;</td>
</tr>
</cfif>
</cfoutput>
</cfloop>
</table>


<hr>

<b>Section 4 - Program Implementation</b>
<br><br>

<cfoutput query="View4" group="ID">		  
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

<u>Overall Quality System Implementation Effectiveness</u><br>
<A HREF="javascript:popUp('help.cfm?ID=6')">[View Effectiveness Criteria]</A>
<br>
<b>#Overall#</b><br> 
Comments: #OverallComments#
<br><br>
</cfoutput>

<hr>

<b>Section 5 - Audit Coverage</b>
<br><br>

<cfquery name="Output" Datasource="Corporate">
SELECT TPReport5.*, TPReport5.Year_ AS "Year" 
FROM TPReport5
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ID
</CFQUERY>

<Table width="700">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="620" valign="top">
<tr><td class="blog-content" valign="top">&nbsp;</td></tr>
<cfoutput query="ISO17025" startrow="1" maxrows="25">
<tr><td class="blog-content">
<cfset Dump1 = #replace(ISO_17025_2005, "Clause ", "", "All")#>
#Dump1#
</td></tr> 
</cfoutput>

</table>

</td>
<td class="blog-content" valign="top">

<Table border="1" width="80" valign="top">
<tr><td class="blog-content" valign="top"><b><cfoutput>#year#-#id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Comments" or col is "Year" or col is "ID" or col is "AuditedBy" or col is "Year_">
<cfelse>
 <cfoutput query="output" startrow="1" maxrows="25">
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

</td>
</tr>
</TABLE>


<Cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">

<hr>

<b>Section 6 - CAP AA Audit Coverage</b><br><br>

<cfquery name="OutputFS" Datasource="Corporate">
SELECT TPReport6.*, TPReport.Year_ AS "Year"
FROM TPReport6
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAA">
SELECT * FROM CAPAA
ORDER BY ID
</CFQUERY>

<Table width="700">
<tr>
<td class="blog-content">

<Table border="1" width="620">
<tr><td class="blog-content">&nbsp;</td></tr>
<cfoutput query="CAPAA" startrow="1" maxrows="15">
<tr><td class="blog-content">
#CAPAA#
</td></tr> 
</cfoutput>

</table>

</td>
<td class="blog-content">

<Table border="1" width="80">
<tr><td class="blog-content"><b><cfoutput>#year#-#id#</cfoutput></b></td></tr>
<cfloop list="#outputfs.ColumnList#" index="col">
<cfif col is "Year_" or col is "ID" or col is "Comments" or col is "AuditedBy" or col is "Year">
<cfelse>
 <cfoutput query="outputfs">
<tr><td class="blog-content">
  <cfif outputfs[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
 </cfoutput>
</cfif>  
</cFLOOP>
</TABLE>

</td>
</tr>
</TABLE>

</cfif>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->