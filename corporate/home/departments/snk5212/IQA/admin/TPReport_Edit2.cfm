<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TP">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#Audit.ExternalLocation#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Contact">
UPDATE ExternalLocation
SET 

KC='#Form.e_KC#',
KCEmail='#Form.e_KCEmail#',
KCPhone='#Form.e_KCPhone#'

WHERE ExternalLocation = '#Audit.ExternalLocation#'
</cfquery>
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE TPReport
SET 

<cfif Form.e_Recommend is "NoChanges">
<cfelse>
Recommend=#Form.e_Recommend#,
</cfif>
Count1=#Form.e_Count1#,
Count2=#Form.e_Count2#,
Count3=#Form.e_Count3#,
Count4=#Form.e_Count4#,
Count5=#Form.e_Count5#,
Count6=#Form.e_Count6#,
Count7=#Form.e_Count7#,
Count8=#Form.e_Count8#,
Count9=#Form.e_Count9#,
Count10=#Form.e_Count10#,
Count11=#Form.e_Count11#,
Count12=#Form.e_Count12#,
Count13=#Form.e_Count13#,
Count14=#Form.e_Count14#,
Count15=#Form.e_Count15#,
Count16=#Form.e_Count16#,
Count17=#Form.e_Count17#,
Count18=#Form.e_Count18#,
Count19=#Form.e_Count19#,
Count20=#Form.e_Count20#,
Count21=#Form.e_Count21#,
Count22=#Form.e_Count22#,
Count23=#Form.e_Count23#,
Count24=#Form.e_Count24#,
Count25=#Form.e_Count25#,
CountOther=#Form.e_CountOther#,
OCount1=#Form.e_OCount1#,
OCount2=#Form.e_OCount2#,
OCount3=#Form.e_OCount3#,
OCount4=#Form.e_OCount4#,
OCount5=#Form.e_OCount5#,
OCount6=#Form.e_OCount6#,
OCount7=#Form.e_OCount7#,
OCount8=#Form.e_OCount8#,
OCount9=#Form.e_OCount9#,
OCount10=#Form.e_OCount10#,
OCount11=#Form.e_OCount11#,
OCount12=#Form.e_OCount12#,
OCount13=#Form.e_OCount13#,
OCount14=#Form.e_OCount14#,
OCount15=#Form.e_OCount15#,
OCount16=#Form.e_OCount16#,
OCount17=#Form.e_OCount17#,
OCount18=#Form.e_OCount18#,
OCount19=#Form.e_OCount19#,
OCount20=#Form.e_OCount20#,
OCount21=#Form.e_OCount21#,
OCount22=#Form.e_OCount22#,
OCount23=#Form.e_OCount23#,
OCount24=#Form.e_OCount24#,
OCount25=#Form.e_OCount25#,
OCountOther=#Form.e_OCountOther#,
CAR1='#Form.e_CAR1#',
CAR2='#Form.e_CAR2#',
CAR3='#Form.e_CAR3#',
CAR4='#Form.e_CAR4#',
CAR5='#Form.e_CAR5#',
CAR6='#Form.e_CAR6#',
CAR7='#Form.e_CAR7#',
CAR8='#Form.e_CAR8#',
CAR9='#Form.e_CAR9#',
CAR10='#Form.e_CAR10#',
CAR11='#Form.e_CAR11#',
CAR12='#Form.e_CAR12#',
CAR13='#Form.e_CAR13#',
CAR14='#Form.e_CAR14#',
CAR15='#Form.e_CAR15#',
CAR16='#Form.e_CAR16#',
CAR17='#Form.e_CAR17#',
CAR18='#Form.e_CAR18#',
CAR19='#Form.e_CAR19#',
CAR20='#Form.e_CAR20#',
CAR21='#Form.e_CAR21#',
CAR22='#Form.e_CAR22#',
CAR23='#Form.e_CAR23#',
CAR24='#Form.e_CAR24#',
CAR25='#Form.e_CAR25#',
CAROther='#Form.e_CAROther#',
ReportDate='#FORM.e_ReportDate#',
LabCert='#Form.e_LabCert#',
LabCertNotes='#Form.e_LabCertNotes#',
ProjectsCompleted=#Form.ProjectsCompleted#,
PeopleInFacility=#Form.PeopleInFacility#,
<cfif form.bestprac is "">
<cfelse>
<cfset BP = #ReplaceNoCase(Form.BestPrac,chr(13),"<br>", "ALL")#>
<cfset BP2 = #ReplaceNoCase(BP,chr(39),"&rsquo;", "ALL")#>
<cfset BP3 = #ReplaceNoCase(BP2,chr(34),"&quot;", "ALL")#>
BestPrac='#BP3#',
</cfif>
<cfset Sc = #ReplaceNoCase(Form.e_Scope,chr(13),"<br>", "ALL")#>
<cfset Sc2 = #ReplaceNoCase(Sc,chr(39),"&rsquo;", "ALL")#>
<cfset Sc3 = #ReplaceNoCase(Sc2,chr(34),"&quot;", "ALL")#>
Scope='#Sc3#',
<cfset SU = #ReplaceNoCase(Form.e_Summary,chr(13),"<br>", "ALL")#>
<cfset SU2 = #ReplaceNoCase(SU,chr(39),"&rsquo;", "ALL")#>
<cfset SU3 = #ReplaceNoCase(SU2,chr(34),"&quot;", "ALL")#>
Summary='#SU3#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfif TP.Type is "CAP-EA/AA" or TP.Type is "CAP-AA">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAAadd">
UPDATE TPReportCAPAA
SET 

AACount1=#Form.e_AACount1#,
AACount2=#Form.e_AACount2#,
AACount3=#Form.e_AACount3#,
AACount4=#Form.e_AACount4#,
AACount5=#Form.e_AACount5#,
AACount6=#Form.e_AACount6#,
AACount7=#Form.e_AACount7#,
AACount8=#Form.e_AACount8#,
AACount9=#Form.e_AACount9#,
AACount10=#Form.e_AACount10#,
AACount11=#Form.e_AACount11#,
AACount12=#Form.e_AACount12#,
AACount13=#Form.e_AACount13#,
AACount14=#Form.e_AACount14#,
CAPAA1='#Form.e_CAPAA1#',
CAPAA2='#Form.e_CAPAA2#',
CAPAA3='#Form.e_CAPAA3#',
CAPAA4='#Form.e_CAPAA4#',
CAPAA5='#Form.e_CAPAA5#',
CAPAA6='#Form.e_CAPAA6#',
CAPAA7='#Form.e_CAPAA7#',
CAPAA8='#Form.e_CAPAA8#',
CAPAA9='#Form.e_CAPAA9#',
CAPAA10='#Form.e_CAPAA10#',
CAPAA11='#Form.e_CAPAA11#',
CAPAA12='#Form.e_CAPAA12#',
CAPAA13='#Form.e_CAPAA13#',
CAPAA14='#Form.e_CAPAA14#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT2
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
<script language="JavaScript" src="validate.js"></script>		

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
                             Add Report (2) - Verified CARs</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<cfset var=ArrayNew(3)>

<CFSET var[1][1][1] = 'VCAR1'>
<CFSET var[2][1][1] = 'VCAR2'>
<CFSET var[3][1][1] = 'VCAR3'>
<CFSET var[4][1][1] = 'VCAR4'>
<CFSET var[5][1][1] = 'VCAR5'>
<CFSET var[6][1][1] = 'VCAR6'>
<CFSET var[7][1][1] = 'VCAR7'>
<CFSET var[8][1][1] = 'VCAR8'>
<CFSET var[9][1][1] = 'VCAR9'>
<CFSET var[10][1][1] = 'VCAR10'>
<CFSET var[11][1][1] = 'VCAR11'>
<CFSET var[12][1][1] = 'VCAR12'>
<CFSET var[13][1][1] = 'VCAR13'>
<CFSET var[14][1][1] = 'VCAR14'>
<CFSET var[15][1][1] = 'VCAR15'>
<CFSET var[16][1][1] = 'VCAR16'>
<CFSET var[17][1][1] = 'VCAR17'>
<CFSET var[18][1][1] = 'VCAR18'>
<CFSET var[19][1][1] = 'VCAR19'>
<CFSET var[20][1][1] = 'VCAR20'>

<CFSET var[1][2][1] = 'Comments1'>
<CFSET var[2][2][1] = 'Comments2'>
<CFSET var[3][2][1] = 'Comments3'>
<CFSET var[4][2][1] = 'Comments4'>
<CFSET var[5][2][1] = 'Comments5'>
<CFSET var[6][2][1] = 'Comments6'>
<CFSET var[7][2][1] = 'Comments7'>
<CFSET var[8][2][1] = 'Comments8'>
<CFSET var[9][2][1] = 'Comments9'>
<CFSET var[10][2][1] = 'Comments10'>
<CFSET var[11][2][1] = 'Comments11'>
<CFSET var[12][2][1] = 'Comments12'>
<CFSET var[13][2][1] = 'Comments13'>
<CFSET var[14][2][1] = 'Comments14'>
<CFSET var[15][2][1] = 'Comments15'>
<CFSET var[16][2][1] = 'Comments16'>
<CFSET var[17][2][1] = 'Comments17'>
<CFSET var[18][2][1] = 'Comments18'>
<CFSET var[19][2][1] = 'Comments19'>
<CFSET var[20][2][1] = 'Comments20'>

<CFSET var[1][3][1] = 'Effective1'>
<CFSET var[2][3][1] = 'Effective2'>
<CFSET var[3][3][1] = 'Effective3'>
<CFSET var[4][3][1] = 'Effective4'>
<CFSET var[5][3][1] = 'Effective5'>
<CFSET var[6][3][1] = 'Effective6'>
<CFSET var[7][3][1] = 'Effective7'>
<CFSET var[8][3][1] = 'Effective8'>
<CFSET var[9][3][1] = 'Effective9'>
<CFSET var[10][3][1] = 'Effective10'>
<CFSET var[11][3][1] = 'Effective11'>
<CFSET var[12][3][1] = 'Effective12'>
<CFSET var[13][3][1] = 'Effective13'>
<CFSET var[14][3][1] = 'Effective14'>
<CFSET var[15][3][1] = 'Effective15'>
<CFSET var[16][3][1] = 'Effective16'>
<CFSET var[17][3][1] = 'Effective17'>
<CFSET var[18][3][1] = 'Effective18'>
<CFSET var[19][3][1] = 'Effective19'>
<CFSET var[20][3][1] = 'Effective20'>

<cfset var2=ArrayNew(3)>

<cfoutput query="View">
<CFSET var2[1][1][1] = '#VCAR1#'>
<CFSET var2[2][1][1] = '#VCAR2#'>
<CFSET var2[3][1][1] = '#VCAR3#'>
<CFSET var2[4][1][1] = '#VCAR4#'>
<CFSET var2[5][1][1] = '#VCAR5#'>
<CFSET var2[6][1][1] = '#VCAR6#'>
<CFSET var2[7][1][1] = '#VCAR7#'>
<CFSET var2[8][1][1] = '#VCAR8#'>
<CFSET var2[9][1][1] = '#VCAR9#'>
<CFSET var2[10][1][1] = '#VCAR10#'>
<CFSET var2[11][1][1] = '#VCAR11#'>
<CFSET var2[12][1][1] = '#VCAR12#'>
<CFSET var2[13][1][1] = '#VCAR13#'>
<CFSET var2[14][1][1] = '#VCAR14#'>
<CFSET var2[15][1][1] = '#VCAR15#'>
<CFSET var2[16][1][1] = '#VCAR16#'>
<CFSET var2[17][1][1] = '#VCAR17#'>
<CFSET var2[18][1][1] = '#VCAR18#'>
<CFSET var2[19][1][1] = '#VCAR19#'>
<CFSET var2[20][1][1] = '#VCAR20#'>

<CFSET var2[1][2][1] = '#Comments1#'>
<CFSET var2[2][2][1] = '#Comments2#'>
<CFSET var2[3][2][1] = '#Comments3#'>
<CFSET var2[4][2][1] = '#Comments4#'>
<CFSET var2[5][2][1] = '#Comments5#'>
<CFSET var2[6][2][1] = '#Comments6#'>
<CFSET var2[7][2][1] = '#Comments7#'>
<CFSET var2[8][2][1] = '#Comments8#'>
<CFSET var2[9][2][1] = '#Comments9#'>
<CFSET var2[10][2][1] = '#Comments10#'>
<CFSET var2[11][2][1] = '#Comments11#'>
<CFSET var2[12][2][1] = '#Comments12#'>
<CFSET var2[13][2][1] = '#Comments13#'>
<CFSET var2[14][2][1] = '#Comments14#'>
<CFSET var2[15][2][1] = '#Comments15#'>
<CFSET var2[16][2][1] = '#Comments16#'>
<CFSET var2[17][2][1] = '#Comments17#'>
<CFSET var2[18][2][1] = '#Comments18#'>
<CFSET var2[19][2][1] = '#Comments19#'>
<CFSET var2[20][2][1] = '#Comments20#'>

<CFSET var2[1][3][1] = '#Effective1#'>
<CFSET var2[2][3][1] = '#Effective2#'>
<CFSET var2[3][3][1] = '#Effective3#'>
<CFSET var2[4][3][1] = '#Effective4#'>
<CFSET var2[5][3][1] = '#Effective5#'>
<CFSET var2[6][3][1] = '#Effective6#'>
<CFSET var2[7][3][1] = '#Effective7#'>
<CFSET var2[8][3][1] = '#Effective8#'>
<CFSET var2[9][3][1] = '#Effective9#'>
<CFSET var2[10][3][1] = '#Effective10#'>
<CFSET var2[11][3][1] = '#Effective11#'>
<CFSET var2[12][3][1] = '#Effective12#'>
<CFSET var2[13][3][1] = '#Effective13#'>
<CFSET var2[14][3][1] = '#Effective14#'>
<CFSET var2[15][3][1] = '#Effective15#'>
<CFSET var2[16][3][1] = '#Effective16#'>
<CFSET var2[17][3][1] = '#Effective17#'>
<CFSET var2[18][3][1] = '#Effective18#'>
<CFSET var2[19][3][1] = '#Effective19#'>
<CFSET var2[20][3][1] = '#Effective20#'>
</cfoutput>	  

<cfoutput query="Audit">		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport_edit3.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
</cfoutput>
						  
<table>
<tr>
<td class="blog-title">CAR/Audit Finding Number</td>
<td class="blog-title">Effective Implementation?</td>
<td class="blog-title">Verification Comments</td>
</tr>
<cfloop index="i" to="20" from="1">
<cfoutput>
<tr>
<td valign="top"><input type="text" name="e_#var[i][1][1]#" value="#var2[i][1][1]#" size="10" displayname="#var[i][1][1]#"></td>
<td align="center" valign="top">
<SELECT NAME="#var[i][3][1]#">
   <cfswitch expression="#var2[i][3][1]#">
   <cfcase value="Yes">
		<OPTION value="Yes" SELECTED>Yes
		<OPTION value="No">No
   </cfcase>
   <cfcase value="No">
		<OPTION value="Yes">Yes
		<OPTION value="No" SELECTED>No
   </cfcase>
   <cfcase value="">
		<OPTION value="Yes">Yes
		<OPTION value="No">No
   </cfcase>	   	
   </cfswitch> 
</Select>
</td>
<td valign="top"><textarea WRAP="PHYSICAL" ROWS="3" COLS="60" name="e_#var[i][2][1]#" displayname="#var[i][2][1]#">#htmleditformat(var2[i][2][1])#</textarea></td>
</tr>
</cfoutput>
</cfloop>
</table>
<br>
<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
	
 
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->