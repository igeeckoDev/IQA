<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ID = #URL.ID#
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
		
		
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style></head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0"><cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput><div align="left">
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
                          <td width="3%"></td> <td class="blog-date"><p align="center">Audit Database</p></td>
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
                          <td colspan="2" align="left" class="blog-title"><p align="left">TPTDP Locations - <cfoutput query="TPTDP">#ExternalLocation#</cfoutput></p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">

<br>
<div class="blog-time">TPTDP Client List Help - <A HREF="javascript:popUp('../webhelp/webhelp_TPTDP.cfm')">[?]</A></div>

<cfoutput query="TPTDP">
<br> 
<a href="TPTDP_Edit.cfm?ID=#ID#">Edit this information</a><br>
<a href="TPTDP_update_cert.cfm?ID=#ID#">Update certficate</a><br><br>

<b>Third Party Participant:</b> <br>
#ExternalLocation#<br><br>

<b>Location:</b> <br>
#Location#<br><br>

<b>Type:</b> <br>
<cfif Trim(Type) is ""><Cfelse>#Type#</cfif><br><br>

<b>Billable:</b> <br>
#Billable#<br><br>

<cfif Type is "MOU" or Type is "TPTDP-I" or ID is 36>
<b>Certificate:</b><br> 
<a href="../certs/#Certificate#.pdf">View Certificate</a><br><br>

<font color="red">Note: Certificates issued in 2007 will be available for viewing on the IQA Audit Database until the dates of expiration in 2008, New certificates will no longer be issued by IQA after the 2008 dates of expiration. Please contact the DAP Process Owner, Jodine Hepner, x42418, for information regarding issuance and maintenance of new certificates.</font><br><br>
</cfif>

<b>Status:</b> <br>
<cfif Status is 1>Active<cfelseif Status is 0>Inactive/Removed<cfelse>Status Unknown</cfif><br><br>

<b>Key Contact:</b> <br>
#KC#<br><br>

<b>Key Contact Email:</b> <br>
#KCEmail#<br><br>

<b>Key Contact Phone:</b> <br>
#KCPhone#<br><br>

<b>Address:</b><br>
&nbsp;&nbsp;#Address1#<br>
&nbsp;&nbsp;#Address2#<br>
&nbsp;&nbsp;#Address3#<br>
&nbsp;&nbsp;#Address4#<br>
</cfoutput>
 					  			  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->