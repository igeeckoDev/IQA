<CFQUERY BLOCKFACTOR="100" NAME="Access" Datasource="Corporate"> 
SELECT * FROM  IQADB_ACCESS  "ACCESS" ORDER BY AccessLevel
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Region" Datasource="Corporate"> 
SELECT * FROM  IQADB_REGION  "REGION" ORDER BY Region
</cfquery>

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

<cflock scope="SESSION" timeout="60">
<CFQUERY BLOCKFACTOR="100" NAME="SelectUser" Datasource="Corporate"> 
SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE ID = #ID#
</CFQUERY>
</CFLOCK>

<script language="javascript"> 
<!-- 
function check_current_pw() 
{
	if (document.theForm.Current.value != document.theForm.password.value){
		alert ("Your current password was entered incorrectly.");
		return false;
	 } 
	 
	if (document.theForm.ConfirmP1.value != document.theForm.ConfirmP2.value){
		alert ("The confirmation password and new password to not match.");
		return false;
	 } 
	 
  return true;	 
}
//-->
</script>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU">
<!---
<br>
<CFOUTPUT QUERY="SelectUser">
#Name# - Change Password<br>
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="theForm" ACTION="manage_password.cfm?ID=#ID#" onsubmit="return check_current_pw()">
Current Password (#password#)<br>
<INPUT TYPE="HIDDEN" name="password" value="#password#">
<INPUT TYPE="HIDDEN" name="ID" value="#ID#">
<cfINPUT TYPE="TEXT" NAME="Current" required="yes" message="Enter your current password"><br><br>
New Password:<br>
<cfINPUT TYPE="TEXT" NAME="ConfirmP1" required="yes" message="Enter your new password"><br><br>
Confirm Password:<br>
<cfINPUT TYPE="TEXT" NAME="ConfirmP2" required="yes"  message="Confirm your password"><br><br>
<INPUT TYPE="Submit" value="Submit Changes">
</cfFORM>
</CFOUTPUT>
--->

<br><br>
<b>Edit Account Information.</b><br><br>

<table width="650" align="left" border="1">
<tr>
<Td width="40%" class="blog-title" align="center">Name</td>
<Td width="20%" class="blog-title" align="center">Access Level</td>
<Td width="20%" class="blog-title" align="center">Region</td>
<Td width="20%" class="blog-title" align="center">Email</td>
</tr>
<CFOUTPUT query="SelectUser">
<tr>
<Td width="40%" class="blog-content">#name#</td>
<Td width="20%" class="blog-content">#accesslevel#</td>
<Td width="20%" class="blog-content">#Region#</td>
<Td width="20%" class="blog-content">#Email#</td>
</tr>
</CFOUTPUT>
</table>

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="theForm2" ACTION="manage_user_account.cfm?ID=#ID#" onsubmit="return checkinfo()"><br><br>
<CFOUTPUT query="SelectUser">
<input type="hidden" name="ID" value="#ID#"><br><br>
Name:<br>
<cfINPUT TYPE="TEXT" NAME="name" value="#name#" required="yes" message="Enter Name"><br><br>

Region:<br>
<SELECT NAME="Region">
		<OPTION VALUE="All">All
		<OPTION VALUE="#Region#" selected>#Region#
</CFOUTPUT>		
<CFOUTPUT QUERY="Region">
		<OPTION VALUE="#Region#">#Region#
</CFOUTPUT>
</SELECT><br><br>
<CFOUTPUT query="SelectUser">

Email Address (external):<br>
<cfINPUT TYPE="TEXT" value="#Email#" NAME="Email" required="yes" size="75" message="Enter Email Address"><br><br>
</cfoutput>
<INPUT TYPE="Submit" value="Submit Changes">
</CFFORM>

</cfif>
</cflock>						  
			  					  
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->