<CFQUERY BLOCKFACTOR="100" NAME="AuditProgram2004" Datasource="Corporate">
SELECT * FROM AuditProgram
WHERE 
Auditor = '#URL.Auditor#'
ORDER BY Auditor
</CFQUERY>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
                          <td class="blog-date"><p align="center">Audit Details</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  
							<cfinclude template="adminMenu.cfm">
							
							</td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <br>
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title"><p align="left">Metrics - Audit Program Effectiveness</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content" valign="top">


<br><br>
<b>Audit Program Effectiveness Metrics</b> - 2004<br>
Number of CARs generated by accreditors or other third party examiners.<br><br>
<table border="1" width="100%" class="blog-content">
<tr>
<td width="14.28%" align="Center"><b>Auditor Name</b></td>
<td width="7.14%" align="center"><b>Jan</b></td>
<td width="7.14%" align="center"><b>Feb</b></td>
<td width="7.14%" align="center"><b>Mar</b></td>
<td width="7.14%" align="center"><b>Apr</b></td>
<td width="7.14%" align="center"><b>May</b></td>
<td width="7.14%" align="center"><b>Jun</b></td>
<td width="7.14%" align="center"><b>Jul</b></td>
<td width="7.14%" align="center"><b>Aug</b></td>
<td width="7.14%" align="center"><b>Sep</b></td>
<td width="7.14%" align="center"><b>Oct</b></td>
<td width="7.14%" align="center"><b>Nov</b></td>
<td width="7.14%" align="center"><b>Dec</b></td>
</tr>

<CFOUTPUT query="AuditProgram2004">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="ape_update.cfm?Auditor=#Auditor#">
<tr>
<td>#Auditor#<input type="hidden" name="year" value="2004"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="January" VALUE="#January#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="February" VALUE="#February#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="March" VALUE="#March#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="April" VALUE="#April#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="May" VALUE="#May#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="June" VALUE="#June#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="July" VALUE="#July#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="August" VALUE="#August#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="September" VALUE="#September#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="October" VALUE="#October#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="November" VALUE="#November#"></td>
<td align="center"><INPUT size="4" TYPE="Text" NAME="December" VALUE="#December#"></td>
</tr>
<tr>
<td>Current Values</td>
<td align="center">#January#</td>
<td align="center">#February#</td>
<td align="center">#March#</td>
<td align="center">#April#</td>
<td align="center">#May#</td>
<td align="center">#June#</td>
<td align="center">#July#</td>
<td align="center">#August#</td>
<td align="center">#September#</td>
<td align="center">#October#</td>
<td align="center">#November#</td>
<td align="center">#December#</td>
</tr>
</CFOUTPUT>
</table>
<br><br>
<INPUT TYPE="Submit" value="Submit Update">
</FORM>
<br><br>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->