<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cflock scope="SESSION" timeout="60">
<CFQUERY BLOCKFACTOR="100" NAME="update_acct" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
UPDATE IQADB_LOGIN  "LOGIN" SET 

user_first_name = '#Form.user_first_name#',
user_last_name = '#Form.user_last_name#',
Region = '#Form.Region#',
Email = '#Form.Email#'

WHERE ID = #ID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
</CFLOCK>

<CFQUERY BLOCKFACTOR="100" NAME="SelectUser" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE ID = #ID#

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
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
						  
							<cfinclude template="adminmenu.cfm">
							
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
                          <td colspan="2" align="left" class="blog-title"><p align="left">Manage User Accounts</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content" valign="top">
<p>Updated Info:</p><br>
<table width="650" align="left" border="1">
<tr>
<Td width="20%" class="blog-title" align="center">First Name</td>
<Td width="20%" class="blog-title" align="center">Last Name</td>
<Td width="20%" class="blog-title" align="center">Access Level</td>
<Td width="20%" class="blog-title" align="center">Region</td>
<Td width="20%" class="blog-title" align="center">Email</td>
</tr>
<CFOUTPUT query="SelectUser">
<tr>
<Td width="20%" class="blog-content">#user_first_name#</td>
<Td width="20%" class="blog-content">#user_last_name#</td>
<Td width="20%" class="blog-content">#user_access_level#</td>
<Td width="20%" class="blog-content">#Region#</td>
<Td width="20%" class="blog-content">#Email#&nbsp;</td>
</tr>
</CFOUTPUT>
</table>  				
<br><p><a href="Manage.cfm">Manage Accounts</a></p>	  
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->