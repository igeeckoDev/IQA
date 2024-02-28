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
                          <td colspan="2" align="left" class="blog-title"><p align="left">TPTDP Locations - Edit</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">

<br>
<cfoutput query="TPTDP">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="TPTDP" ACTION="TPTDP_update.cfm?ID=#ID#">

<b>#ExternalLocation#</b><br><br>

<b>Location:</b> #Location#<br>
<input Type="text" Name="Location" Value="#Location#" size="50"><br><br>

<b>Type:</b> <cfif Trim(Type) is ""><Cfelse>#Type#</cfif><br>
<SELECT NAME="Type">
		<OPTION value="#Type#" SELECTED>#Type#
</cfoutput>		
<cfoutput query="TPType">
		<OPTION value="#TPType#">#TPType#
</cfoutput>
</Select><br><br>

<cfoutput query="TPTDP">
<b>Billable:</b> (currently: #billable#)<br>
<SELECT NAME="Billable">
<cfswitch expression="#Billable#">
	<cfcase value="Yes">
		<OPTION value="Yes" selected>Yes
		<OPTION value="No">No
	</cfcase>
	<cfcase value="No">
		<OPTION value="Yes">Yes
		<OPTION value="No"selected>No
	</cfcase>
</cfswitch>		
</Select>
<br><br>

<input type="hidden" Name="Cert" value="#Cert#">

<b>Status:</b> (Currently: <cfif Status is 1>Active<cfelseif Status is 0>Inactive/Removed<cfelse>Status Unknown</cfif>)<br>
<SELECT NAME="Status">
<cfswitch expression="#Status#">
	<cfcase value="1">
		<OPTION value="1" selected>Active
		<OPTION value="0">Inactive/Removed
	</cfcase>
	<cfcase value="0">
		<OPTION value="1">Active
		<OPTION value="0" selected>Inactive/Removed
	</cfcase>
</cfswitch>
</Select><br><br>

<b>Key Contact:</b> #KC#<br>
<input Type="text" Name="KC" Value="#KC#" size="40"><br><br>

<b>Key Contact Email:</b> #KCEmail#<br>
<input Type="text" Name="KCEmail" Value="#KCEmail#" size="40"><br><br>

<b>Key Contact Phone:</b> #KCPhone#<br>
<input Type="text" Name="KCPhone" Value="#KCPhone#" size="40"><br><br>

<b>Address:</b><br>
&nbsp;&nbsp;#Address1#<br>
&nbsp;&nbsp;#Address2#<br>
&nbsp;&nbsp;#Address3#<br>
&nbsp;&nbsp;#Address4#<br><br>
<input Type="text" Name="Address1" Value="#Address1#" size="40"><br>
<input Type="text" Name="Address2" Value="#Address2#" size="40"><br>
<input Type="text" Name="Address3" Value="#Address3#" size="40"><br>
<input Type="text" Name="Address4" Value="#Address4#" size="40"><br><br><br>

<INPUT TYPE="Submit" value="Save and Continue">

</FORM>

</cfoutput>					  			  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->