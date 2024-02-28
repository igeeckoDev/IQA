<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
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

	<body onLoad="document.login.username.focus();" leftmargin="0" marginheight="0" marginwidth="0" topmargin="0"><cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput><div align="left">
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
                          <td class="blog-date"><p align="left"><br>
                              Global Login - Internal Quality Audits</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">

<cfif IsDefined("Form.username")> 
   <CFQUERY BLOCKFACTOR="100" name="finduser" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE username = '#Form.Username#'

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>
	
  <CFIF #finduser.RecordCount# IS 0>
  <p>Invalid Username.</p>	
  <CFELSE>	

<CFQUERY BLOCKFACTOR="100" NAME="finduser" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE username = '#FORM.username#'

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>	
	
<cfmail 
from="ULWebForms@ul.com" 
to="#Email#" 
subject="IQA Password"
query="finduser">

The Internal Quality Audits password for #Form.username# is #password#. 

Please save this email for future reference.

</cfmail>

<CFOUTPUT query="finduser">
<p><b>Email Sent</b><br>
Your password has been mailed to #Email#.<br><br>

<p><a href="global_login.cfm">Login</a> to the IQA site.</p>


</CFOUTPUT>
	
  </cfif>
</cfif>		  

<cfform name="send_password" action="#CGI.SCRIPT_NAME#" method="post">
<b>Enter User Name</b><br>
<cfinput name="username" type="text" size="25" maxlength="25" required="yes" message="Please enter User Name.">
<br>
<input type="submit" value="Submit Info">
</cfform>
<br>						  

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->