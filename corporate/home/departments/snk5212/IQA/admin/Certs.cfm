<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDPList">
SELECT * FROM ExternalLocation
WHERE ExternalLocation <> '- None -'
and Certificate IS NOT NULL
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
		

<script language="JavaScript">
function validateForm()
{
	// check name
     if (document.Form.ExternalLocation.value == '') {
          alert("Please provide the TPTDP name.");
          return false;
     }

    return true;
}		
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
                          <td colspan="2" align="left" class="blog-title"><p align="left">TPTDP Certificates</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">
						  
						  <br>
						  <b>Note: No certificates are available for CAP EA/AA and SCL participants.</b><br><br>
						  <CFOUTPUT query="TPTDPList">
						  - #ExternalLocation# <cfif Trim(Type) is ""><Cfelse>(#Type#)</cfif> <cfif Trim(Certificate) is ""><cfelse> - <a href="../Certs/#Certificate#.pdf">(View Certificate)</a> :: <a href="update_Cert.cfm?ID=#ID#">(Update)</a></cfif><br>
						  </CFOUTPUT>
						  				  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->