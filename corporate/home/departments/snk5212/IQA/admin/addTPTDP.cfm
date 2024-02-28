<CFIF Cert is "">
<CFELSE>
<CFFILE ACTION="UPLOAD" 
FILEFIELD="Cert" 
DESTINATION="#basedir#Certs\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf">
</CFIF>

<cfif Certificate is "">
<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addTPTDP">
INSERT INTO ExternalLocation(ExternalLocation, Type)
VALUES ('#FORM.ExternalLocation#', '#FORM.Type#')
</CFQUERY>
<cfelse>
<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addTPTDP">
INSERT INTO ExternalLocation(ExternalLocation, Type, Certificate)
VALUES ('#FORM.ExternalLocation#', '#FORM.Type#', '#FORM.Certificate#')
</CFQUERY>
</cfif>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDPList">
SELECT * FROM ExternalLocation
WHERE ExternalLocation <> '- None -'
ORDER BY ExternalLocation
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
                          <td colspan="2" align="left" class="blog-title"><p align="left">Add TPTDP Location</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">&nbsp;
						  
						  <CFOUTPUT><b>#FORM.ExternalLocation#</b> <cfif Trim(Type) is ""><Cfelse>(#Type#)</cfif> has been added to the TPTDP List.
						  <cfif Form.Cert is NOT ""><br>#Form.Certificate# has been uploaded.<cfelse></cfif>
						  </CFOUTPUT>
						  <br><br>
						  <b>Current list of TPTDP locations:</b><br><br>
						  <CFOUTPUT query="TPTDPList">
						  - #ExternalLocation# <cfif Trim(Type) is ""><Cfelse>(#Type#)</cfif><br>
						  </CFOUTPUT>
						  				  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->