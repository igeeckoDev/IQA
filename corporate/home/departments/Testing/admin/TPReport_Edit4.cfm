<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE TPReport3
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
RCAR1='#Form.e_RCAR1#',
RCAR2='#Form.e_RCAR2#',
RCAR3='#Form.e_RCAR3#',
RCAR4='#Form.e_RCAR4#',
RCAR5='#Form.e_RCAR5#',
RCAR6='#Form.e_RCAR6#',
RCAR7='#Form.e_RCAR7#',
RCAR8='#Form.e_RCAR8#',
RCAR9='#Form.e_RCAR9#',
RCAR10='#Form.e_RCAR10#',
RCAR11='#Form.e_RCAR11#',
RCAR12='#Form.e_RCAR12#',
RCAR13='#Form.e_RCAR13#',
RCAR14='#Form.e_RCAR14#',
RCAR15='#Form.e_RCAR15#',
RCAR16='#Form.e_RCAR16#',
RCAR17='#Form.e_RCAR17#',
RCAR18='#Form.e_RCAR18#',
RCAR19='#Form.e_RCAR19#',
RCAR20='#Form.e_RCAR20#',
NewCAR1='#Form.e_NewCAR1#',
NewCAR2='#Form.e_NewCAR2#',
NewCAR3='#Form.e_NewCAR3#',
NewCAR4='#Form.e_NewCAR4#',
NewCAR5='#Form.e_NewCAR5#',
NewCAR6='#Form.e_NewCAR6#',
NewCAR7='#Form.e_NewCAR7#',
NewCAR8='#Form.e_NewCAR8#',
NewCAR9='#Form.e_NewCAR9#',
NewCAR10='#Form.e_NewCAR10#',
NewCAR11='#Form.e_NewCAR11#',
NewCAR12='#Form.e_NewCAR12#',
NewCAR13='#Form.e_NewCAR13#',
NewCAR14='#Form.e_NewCAR14#',
NewCAR15='#Form.e_NewCAR15#',
NewCAR16='#Form.e_NewCAR16#',
NewCAR17='#Form.e_NewCAR17#',
NewCAR18='#Form.e_NewCAR18#',
NewCAR19='#Form.e_NewCAR19#',
NewCAR20='#Form.e_NewCAR20#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT4
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
		
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=300,height=300,left = 490,top = 412');");
}
// End -->
</script>			

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="radioboxes.js"></script>
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
                             Add Report (4) - Quality System Implementation Effectiveness</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<br>
<cfoutput query="View">		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport_Edit5.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">

Document Control effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=1')">[View Effectiveness Criteria]</A><br>
   <cfswitch expression="#DC#">
   <cfcase value="Yes">
   Yes <input type="Radio" Name="DC" Value="Yes" checked> No <INPUT TYPE="Radio" NAME="DC" value="No"> N/A <INPUT TYPE="Radio" NAME="DC" value="NA">
   </cfcase>
   <cfcase value="No">
   Yes <input type="Radio" Name="DC" Value="Yes"> No <INPUT TYPE="Radio" NAME="DC" value="No" checked> N/A <INPUT TYPE="Radio" NAME="DC" value="NA">
   </cfcase>
   <cfcase value="NA">
   Yes <input type="Radio" Name="DC" Value="Yes"> No <INPUT TYPE="Radio" NAME="DC" value="No"> N/A <INPUT TYPE="Radio" NAME="DC" value="NA" checked>
   </cfcase>   
   </cfswitch><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_DCComments" displayname="Document Control Implementation Comments">#DCComments#</textarea>
<br><br>

Management Review effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=2')">[View Effectiveness Criteria]</A>
<br>
   <cfswitch expression="#MR#">
   <cfcase value="Yes">
   Yes <input type="Radio" name="MR" Value="Yes" checked> No <INPUT TYPE="Radio" name="MR" value="No"> N/A <INPUT TYPE="Radio" NAME="MR" value="NA">
   </cfcase>
   <cfcase value="No">
   Yes <input type="Radio" name="MR" Value="Yes"> No <INPUT TYPE="Radio" name="MR" value="No" checked> N/A <INPUT TYPE="Radio" NAME="MR" value="NA">
   </cfcase>
   <cfcase value="NA">
   Yes <input type="Radio" name="MR" Value="Yes"> No <INPUT TYPE="Radio" name="MR" value="No"> N/A <INPUT TYPE="Radio" NAME="MR" value="NA" CHECKED>
   </cfcase>   
   </cfswitch><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_MRComments" displayname="Management Review Implementation Comments">#MRComments#</textarea>
<br><br>

Corrective Action effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=3')">[View Effectiveness Criteria]</A>
<br>
   <cfswitch expression="#CA#">
   <cfcase value="Yes">
   Yes <input type="Radio" name="CA" Value="Yes" checked> No <INPUT TYPE="Radio" name="CA" value="No"> N/A <INPUT TYPE="Radio" NAME="CA" value="NA">
   </cfcase>
   <cfcase value="No">
   Yes <input type="Radio" name="CA" Value="Yes"> No <INPUT TYPE="Radio" name="CA" value="No" checked> N/A <INPUT TYPE="Radio" NAME="CA" value="NA">
   </cfcase>
   <cfcase value="NA">
   Yes <input type="Radio" name="CA" Value="Yes"> No <INPUT TYPE="Radio" name="CA" value="No"> N/A <INPUT TYPE="Radio" NAME="CA" value="NA" CHECKED>
   </cfcase>   
   </cfswitch><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_CAComments" displayname="Corrective Action Implementation Comments">#CAComments#</textarea>
<br><br>

Records implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=4')">[View Effectiveness Criteria]</A>
<br>
   <cfswitch expression="#RE#">
   <cfcase value="Yes">
   Yes <input type="Radio" name="RE" Value="Yes" checked> No <INPUT TYPE="Radio" name="RE" value="No"> N/A <INPUT TYPE="Radio" NAME="RE" value="NA">
   </cfcase>
   <cfcase value="No">
   Yes <input type="Radio" name="RE" Value="Yes"> No <INPUT TYPE="Radio" name="RE" value="No" checked> N/A <INPUT TYPE="Radio" NAME="RE" value="NA">
   </cfcase>
   <cfcase value="NA">
   Yes <input type="Radio" name="RE" Value="Yes"> No <INPUT TYPE="Radio" name="RE" value="No"> N/A <INPUT TYPE="Radio" NAME="RE" value="NA" CHECKED>
   </cfcase>   
   </cfswitch><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_REComments" displayname="Records Implementation Comments">#REComments#</textarea>
<br><br>

Internal Audits implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=5')">[View Effectiveness Criteria]</A>
<br>
   <cfswitch expression="#IA#">
   <cfcase value="Yes">
   Yes <input type="Radio" name="IA" Value="Yes" checked> No <INPUT TYPE="Radio" name="IA" value="No"> N/A <INPUT TYPE="Radio" NAME="IA" value="NA">
   </cfcase>
   <cfcase value="No">
   Yes <input type="Radio" name="IA" Value="Yes"> No <INPUT TYPE="Radio" name="IA" value="No" checked> N/A <INPUT TYPE="Radio" NAME="IA" value="NA">
   </cfcase>
   <cfcase value="NA">
   Yes <input type="Radio" name="IA" Value="Yes"> No <INPUT TYPE="Radio" name="IA" value="No"> N/A <INPUT TYPE="Radio" NAME="IA" value="NA" CHECKED>
   </cfcase>   
   </cfswitch><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_IAComments" displayname="Internal Audits Implementation Comments">#IAComments#</textarea>
<br><br>

Overall Quality System Implementation Effectiveness<br>
<A HREF="javascript:popUp('help.cfm?ID=6')">[View Effectiveness Criteria]</A>
<br>
   <cfswitch expression="#Overall#">
   <cfcase value="Yes">
   Yes <input type="Radio" name="Overall" Value="Yes" checked> No <INPUT TYPE="Radio" name="Overall" value="No"> N/A <INPUT TYPE="Radio" NAME="Overall" value="NA">
   </cfcase>
   <cfcase value="No">
   Yes <input type="Radio" name="Overall" Value="Yes"> No <INPUT TYPE="Radio" name="Overall" value="No" checked> N/A <INPUT TYPE="Radio" NAME="Overall" value="NA">
   </cfcase>
   <cfcase value="NA">
   Yes <input type="Radio" name="Overall" Value="Yes"> No <INPUT TYPE="Radio" name="Overall" value="No"> N/A <INPUT TYPE="Radio" NAME="Overall" value="NA" CHECKED>
   </cfcase>   
   </cfswitch><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_OverallComments" displayname="Overall Quality System Implementation Effectiveness">#OverallComments#</textarea>
<br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>
 
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

