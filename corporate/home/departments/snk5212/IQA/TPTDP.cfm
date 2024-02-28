<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDPList">
SELECT * FROM ExternalLocation
WHERE ExternalLocation <> '- None -'
ORDER BY Status DESC, ExternalLocation
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPType">
SELECT * FROM ThirdPartyTypes
ORDER BY TPType
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
	 
     if (document.Form.TPType.value == '') {
          alert("Please provide the Third Party Participant type.");
          return false;
     }
	 
	 if (document.Form.Certificate.value == '' & document.Form.Cert.value !== '') {
          alert("Please enter a Certificate Number.");
          return false;
     } 	
	 
	 if (document.Form.Certificate.value !== '' & document.Form.Cert.value == '') {
          alert("Please attach a Certificate file.");
          return false;
     }	 

    return true;
}		
</script>


		
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
						  
							<cfinclude template="Menu.cfm">
							
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
                          <td colspan="2" align="left" class="blog-title"><p align="left">TPTDP Locations</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">
						  <br>
						  <u>Third Party Report Card</u><br><cfoutput>
<a href="report/report.cfm?Year=#CurYear#">View Report Card</a></cfoutput><br><br>

<font color="red">Note: Certificates issued in 2007 will be available for viewing on the IQA Audit Database until the dates of expiration in 2008, New certificates will no longer be issued by IQA after the 2008 dates of expiration. Please contact the DAP Process Owner, Jodine Hepner, x42418, for information regarding issuance and maintenance of new certificates.</font><br><br>

* Note: Certificates are issued by IQA <u>ONLY</u> for MOU and TPTDP-I clients.<br><br>
			  
<b>Current list of TPTDP locations:</b><br><br>
<table border="1">
<tr>
<td class="blog-title">Third Party Name</td>
<td class="blog-title">Location</td>
<td class="blog-title">Participant Type</td>
</tr>

<CFOUTPUT query="TPTDPList">
<tr>
<td class="blog-content">
<b>#ExternalLocation#</b> <cfif Status is 0><font color="red">(Inactive)</font></cfif><br>
- <a href="TPTDP_View.cfm?ID=#ID#">View</a><br>
- <a href="report/reportcard.cfm?TP=#ExternalLocation#">Report Card</a><br>
<cfif Type is "MOU" or Type is "TPTDP-I" or ID is 36>
 - <a href="certs/#Certificate#.pdf">Cert</a>
</cfif> 
</td>
<td class="blog-content">#Location#<br></td>
<td class="blog-content">
<cfif len(Trim(Type))>#Type#</cfif>
</td>
</tr>
</CFOUTPUT>
</table>				  
</td>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->