<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT ID,YEAR_ as "Year"
 FROM TPReport2
 WHERE ID = #URL.ID#  AND  Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif a.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO TPReport2(ID, Year, AuditedBy)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#URL.AuditedBy#')
</cfquery>
</cfif>
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE TPReport2
SET 

Comments1='#Form.e_Comments1#',
Comments2='#Form.e_Comments2#',
Comments3='#Form.e_Comments3#',
Comments4='#Form.e_Comments4#',
Comments5='#Form.e_Comments5#',
Comments6='#Form.e_Comments6#',
Comments7='#Form.e_Comments7#',
Comments8='#Form.e_Comments8#',
Comments9='#Form.e_Comments9#',
Comments10='#Form.e_Comments10#',
Comments11='#Form.e_Comments11#',
Comments12='#Form.e_Comments12#',
Comments13='#Form.e_Comments13#',
Comments14='#Form.e_Comments14#',
Comments15='#Form.e_Comments15#',
Comments16='#Form.e_Comments16#',
Comments17='#Form.e_Comments17#',
Comments18='#Form.e_Comments18#',
Comments19='#Form.e_Comments19#',
Comments20='#Form.e_Comments20#',
Effective1='#Form.Effective1#',
Effective2='#Form.Effective2#',
Effective3='#Form.Effective3#',
Effective4='#Form.Effective4#',
Effective5='#Form.Effective5#',
Effective6='#Form.Effective6#',
Effective7='#Form.Effective7#',
Effective8='#Form.Effective8#',
Effective9='#Form.Effective9#',
Effective10='#Form.Effective10#',
Effective11='#Form.Effective11#',
Effective12='#Form.Effective12#',
Effective13='#Form.Effective13#',
Effective14='#Form.Effective14#',
Effective15='#Form.Effective15#',
Effective16='#Form.Effective16#',
Effective17='#Form.Effective17#',
Effective18='#Form.Effective18#',
Effective19='#Form.Effective19#',
Effective20='#Form.Effective20#',
VCAR1='#Form.e_VCAR1#',
VCAR2='#Form.e_VCAR2#',
VCAR3='#Form.e_VCAR3#',
VCAR4='#Form.e_VCAR4#',
VCAR5='#Form.e_VCAR5#',
VCAR6='#Form.e_VCAR6#',
VCAR7='#Form.e_VCAR7#',
VCAR8='#Form.e_VCAR8#',
VCAR9='#Form.e_VCAR9#',
VCAR10='#Form.e_VCAR10#',
VCAR11='#Form.e_VCAR11#',
VCAR12='#Form.e_VCAR12#',
VCAR13='#Form.e_VCAR13#',
VCAR14='#Form.e_VCAR14#',
VCAR15='#Form.e_VCAR15#',
VCAR16='#Form.e_VCAR16#',
VCAR17='#Form.e_VCAR17#',
VCAR18='#Form.e_VCAR18#',
VCAR19='#Form.e_VCAR19#',
VCAR20='#Form.e_VCAR20#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='2'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT3
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>		
<script language="JavaScript" src="validate.js">
</script>

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
                             Add Report (3) - Repeat CARs</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<cfoutput>
<cfset var2=ArrayNew(2)>				  
<CFSET var2[1][1] = '#Form.e_VCAR1#'>
<CFSET var2[2][1] = '#Form.e_VCAR2#'>
<CFSET var2[3][1] = '#Form.e_VCAR3#'>
<CFSET var2[4][1] = '#Form.e_VCAR4#'>
<CFSET var2[5][1] = '#Form.e_VCAR5#'>
<CFSET var2[6][1] = '#Form.e_VCAR6#'>
<CFSET var2[7][1] = '#Form.e_VCAR7#'>
<CFSET var2[8][1] = '#Form.e_VCAR8#'>
<CFSET var2[9][1] = '#Form.e_VCAR9#'>
<CFSET var2[10][1] = '#Form.e_VCAR10#'>
<CFSET var2[11][1] = '#Form.e_VCAR11#'>
<CFSET var2[12][1] = '#Form.e_VCAR12#'>
<CFSET var2[13][1] = '#Form.e_VCAR13#'>
<CFSET var2[14][1] = '#Form.e_VCAR14#'>
<CFSET var2[15][1] = '#Form.e_VCAR15#'>
<CFSET var2[16][1] = '#Form.e_VCAR16#'>
<CFSET var2[17][1] = '#Form.e_VCAR17#'>
<CFSET var2[18][1] = '#Form.e_VCAR18#'>
<CFSET var2[19][1] = '#Form.e_VCAR19#'>
<CFSET var2[20][1] = '#Form.e_VCAR20#'>

<CFSET var2[1][2] = '#Form.Effective1#'>
<CFSET var2[2][2] = '#Form.Effective2#'>
<CFSET var2[3][2] = '#Form.Effective3#'>
<CFSET var2[4][2] = '#Form.Effective4#'>
<CFSET var2[5][2] = '#Form.Effective5#'>
<CFSET var2[6][2] = '#Form.Effective6#'>
<CFSET var2[7][2] = '#Form.Effective7#'>
<CFSET var2[8][2] = '#Form.Effective8#'>
<CFSET var2[9][2] = '#Form.Effective9#'>
<CFSET var2[10][2] = '#Form.Effective10#'>
<CFSET var2[11][2] = '#Form.Effective11#'>
<CFSET var2[12][2] = '#Form.Effective12#'>
<CFSET var2[13][2] = '#Form.Effective13#'>
<CFSET var2[14][2] = '#Form.Effective14#'>
<CFSET var2[15][2] = '#Form.Effective15#'>
<CFSET var2[16][2] = '#Form.Effective16#'>
<CFSET var2[17][2] = '#Form.Effective17#'>
<CFSET var2[18][2] = '#Form.Effective18#'>
<CFSET var2[19][2] = '#Form.Effective19#'>
<CFSET var2[20][2] = '#Form.Effective20#'>
</cfoutput>

<cfset var=ArrayNew(3)>
<CFSET var[1][1][1] = 'RCAR1'>
<CFSET var[2][1][1] = 'RCAR2'>
<CFSET var[3][1][1] = 'RCAR3'>
<CFSET var[4][1][1] = 'RCAR4'>
<CFSET var[5][1][1] = 'RCAR5'>
<CFSET var[6][1][1] = 'RCAR6'>
<CFSET var[7][1][1] = 'RCAR7'>
<CFSET var[8][1][1] = 'RCAR8'>
<CFSET var[9][1][1] = 'RCAR9'>
<CFSET var[10][1][1] = 'RCAR10'>
<CFSET var[11][1][1] = 'RCAR11'>
<CFSET var[12][1][1] = 'RCAR12'>
<CFSET var[13][1][1] = 'RCAR13'>
<CFSET var[14][1][1] = 'RCAR14'>
<CFSET var[15][1][1] = 'RCAR15'>
<CFSET var[16][1][1] = 'RCAR16'>
<CFSET var[17][1][1] = 'RCAR17'>
<CFSET var[18][1][1] = 'RCAR18'>
<CFSET var[19][1][1] = 'RCAR19'>
<CFSET var[20][1][1] = 'RCAR20'>

<CFSET var[1][2][2] = 'Comments1'>
<CFSET var[2][2][2] = 'Comments2'>
<CFSET var[3][2][2] = 'Comments3'>
<CFSET var[4][2][2] = 'Comments4'>
<CFSET var[5][2][2] = 'Comments5'>
<CFSET var[6][2][2] = 'Comments6'>
<CFSET var[7][2][2] = 'Comments7'>
<CFSET var[8][2][2] = 'Comments8'>
<CFSET var[9][2][2] = 'Comments9'>
<CFSET var[10][2][2] = 'Comments10'>
<CFSET var[11][2][2] = 'Comments11'>
<CFSET var[12][2][2] = 'Comments12'>
<CFSET var[13][2][2] = 'Comments13'>
<CFSET var[14][2][2] = 'Comments14'>
<CFSET var[15][2][2] = 'Comments15'>
<CFSET var[16][2][2] = 'Comments16'>
<CFSET var[17][2][2] = 'Comments17'>
<CFSET var[18][2][2] = 'Comments18'>
<CFSET var[19][2][2] = 'Comments19'>
<CFSET var[20][2][2] = 'Comments20'>

<CFSET var[1][3][3] = 'NewCAR1'>
<CFSET var[2][3][3] = 'NewCAR2'>
<CFSET var[3][3][3] = 'NewCAR3'>
<CFSET var[4][3][3] = 'NewCAR4'>
<CFSET var[5][3][3] = 'NewCAR5'>
<CFSET var[6][3][3] = 'NewCAR6'>
<CFSET var[7][3][3] = 'NewCAR7'>
<CFSET var[8][3][3] = 'NewCAR8'>
<CFSET var[9][3][3] = 'NewCAR9'>
<CFSET var[10][3][3] = 'NewCAR10'>
<CFSET var[11][3][3] = 'NewCAR11'>
<CFSET var[12][3][3] = 'NewCAR12'>
<CFSET var[13][3][3] = 'NewCAR13'>
<CFSET var[14][3][3] = 'NewCAR14'>
<CFSET var[15][3][3] = 'NewCAR15'>
<CFSET var[16][3][3] = 'NewCAR16'>
<CFSET var[17][3][3] = 'NewCAR17'>
<CFSET var[18][3][3] = 'NewCAR18'>
<CFSET var[19][3][3] = 'NewCAR19'>
<CFSET var[20][3][3] = 'NewCAR20'>

<cfoutput query="Audit">		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport4.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
</cfoutput>
						  
<table>
<tr>
<td class="blog-title">Old CAR/Audit Finding Number</td>
<td class="blog-title">New CAR/Audit Finding Number</td>
<td class="blog-title">Comments</td>
</tr>
<cfloop index="i" to="20" from="1">
<cfoutput>
<tr>
<td valign="top">
<input type="text" name="e_#var[i][1][1]#" value="<cfif var2[i][1] is NOT "0" AND var2[i][2] is "No">#var2[i][1]#<cfelse>0</cfif>" size="10" displayname="#var[i][1][1]#">
</td>
<td valign="top">
<input type="text" name="e_#var[i][3][3]#" value="0" size="10" displayname="#var[i][3][3]#">
</td>
<td valign="top">
<textarea WRAP="PHYSICAL" ROWS="3" COLS="60" name="e_#var[i][2][2]#" displayname="#var[i][2][2]#">N/A</textarea>
</td>
</tr>
</cfoutput>
</cfloop>
</table>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
	
 
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->