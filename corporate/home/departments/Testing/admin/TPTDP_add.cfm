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
                          <td colspan="2" align="left" class="blog-title"><p align="left">Add Third Party Participant</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">

<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="TPTDP" ACTION="TPTDP_add_submit.cfm">

<b>Third Party Participant Name:</b><br>
<input Type="text" Name="ExternalLocation" Value="" size="70"><br><br>

<b>Location:</b><br>
<input Type="text" Name="Location" Value="" size="50"><br><br>

<b>Type:</b><br>
<SELECT NAME="Type">
<cfoutput query="TPType">
		<OPTION value="#TPType#">#TPType#
</cfoutput>
</Select><br><br>

<b>Billable:</b><br>
<SELECT NAME="Billable">
		<OPTION value="Yes">Yes
		<OPTION value="No">No
</Select>
<br><br>

<b>Certificate:</b><br>
<SELECT NAME="Cert">
		<OPTION value="Yes">Yes
		<OPTION value="No">No
</Select>
<br><br>

<b>Status:</b><br>
<SELECT NAME="Status">
		<OPTION value="1">Active
		<OPTION value="0">Inactive/Removed
</Select><br><br>

<b>Key Contact:</b><br>
<input Type="text" Name="KC" Value="" size="40"><br><br>

<b>Key Contact Email:</b><br>
<input Type="text" Name="KCEmail" Value="" size="40"><br><br>

<b>Key Contact Phone:</b><br>
<input Type="text" Name="KCPhone" Value="" size="40"><br><br>

<b>Address:</b><br>
<input Type="text" Name="Address1" Value="" size="70"><br>
<input Type="text" Name="Address2" Value="" size="70"><br>
<input Type="text" Name="Address3" Value="" size="70"><br>
<input Type="text" Name="Address4" Value="" size="70"><br><br><br>

<INPUT TYPE="Submit" value="Save and Continue">

</FORM>			  			  

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
