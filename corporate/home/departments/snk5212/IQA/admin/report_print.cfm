<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.StartDate,
AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditType, AuditSchedule.AuditType2, Report.Scope, Report.ReportDate,
Report.KCInfo, Report.Summary, Report.BestPrac, Report.Offices
FROM REPORT, AuditSchedule, AuditSchedule.SME

WHERE Report.ID = #URL.ID#
AND  Report.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND  AuditSchedule.ID = #URL.ID#
AND  AuditSchedule.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND  Report.AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View1">
SELECT * FROM REPORT
WHERE Report.ID = #URL.ID#
AND Report.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Report.AuditedBy = '#URL.AuditedBy#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
SELECT * FROM KP_Report
ORDER BY Alpha
</cfquery>

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
SELECT AuditType2, ID,YEAR_ as "Year", AuditedBy
FROM AuditSchedule
WHERE ID = #URL.ID#  AND  Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  AND  AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfoutput query="Check">
	<cfif AuditType2 is "Field Services">
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
<td class="blog-content" align="left">

<cfoutput query="View" group="ID">
<br>
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

<cfif Offices is NOT "">
<b>Other Locations Included in Audit</b><br>
This Audit included program/process verification of the following sites:<br>
<cfset OfficeDump = #replace(Offices, "!!,", "<br>", "All")#>
<cfset OfficeDump2 = #replace(OfficeDump, "!!", "", "All")#>
#OfficeDump2#<br><br>
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

<cfif Offices is NOT "">
<b>Other Locations Included in Audit</b><br>
This Audit included program/process verification of the following sites:<br>
<cfset Dump12 = #replace(Offices, "!!", " - <br>", "All")#>
#Dump12#<br><br>
</cfif>

<b>Audit Type</b><br>
#AuditType#, #AuditType2#<br><br>

<b>Contact(s) Email</b><br>
#KCInfo#<br><br>

<b>Scope</b><br>
#Scope#<br><br>

<b>Summary</b><br>
#Summary#<br><br>
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
<CFSET var[17][1][1] = 'Other'>

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
<CFSET var[17][2][2] = '#CAROther#'>

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
<CFSET var[17][3][3] = '#CountOther#'>
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
<CFSET var2[17] = '#OCountOther#'>
</cfoutput>

<b>Nonconformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR numbers with a comma<br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR Number(s)*</td>
</tr>
<CFloop index="i" from="1" to="17">
<cfoutput query="view1" group="ID">
<tr>
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
</cfoutput>
</CFloop>
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

<br>

<table border="1" width="600">
<tr>
<td class="blog-title" width="30%">Car Number</td>
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

<br><b><u>Program Effectiveness</u></b><br><br>

<cfoutput query="View3" group="ID">
<u>Document Control implementation effective?</u><br>
<b>#DC#</b><br>
Comments: #DCComments#
<br><br>

<u>Management Review implementation effective?</u><br>
<b>#MR#</b><br>
Comments: #MRComments#
<br><br>

<u>Corrective Action implementation effective?</u><br>
<b>#CA#</b><br>
Comments: #CAComments#
<br><br>

<u>Records implementation effective?</u><br>
<b>#RE#</b><br>
Comments: #REComments#
<br><br>

<u>Internal Audits implementation effective?</u><br>
<b>#IA#</b><br>
Comments: #IAComments#
<br><br>
</cfoutput>

<br><b><u>Audit Coverage</u></b><br>
<cfoutput query="output" group="Area">Audit Area - #Area#</cfoutput>
<br><br>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses
ORDER BY ID
</cfquery>

<Table width="700">
<tr>
<td class="blog-content">

<Table border="1" width="620">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="Clauses" startrow="1" maxrows="34">
<tr><td class="blog-content">
#title#
</td></tr>
</cfoutput>

</table>

</td>
<td class="blog-content">

<Table border="1" width="80">
<tr><td class="blog-content"><b><cfoutput>#year#-#id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year" or col is "ID" or col is "OfficeName">
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

</td>
</tr>
</TABLE>

<cfif Check.AuditType2 is "Field Services">
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
<tr><td class="blog-content"><b><cfoutput>#year#-#id#</cfoutput></b></td></tr>
<cfloop list="#outputfs.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year" or col is "ID" or col is "OfficeName" or col is "auditedby">
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

</td></tr></table>
</body>
</html>