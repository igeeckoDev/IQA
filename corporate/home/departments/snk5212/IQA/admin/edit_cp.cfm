<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY Name="Cert" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: aeba6921-bc36-48d8-8a2e-d4763ad1c2f5 Variable Datasource name --->
SELECT * From CertPrograms
WHERE ID = #URL.ID#
<!---TODO_DV_CORP_002_End: aeba6921-bc36-48d8-8a2e-d4763ad1c2f5 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

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

					
              <td class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="center">Audit Database</p></td>
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
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        
					  
						<tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              Current Product Certification Programs in the UL Family of Companies</td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
						
						<tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-content"><p align="left"><br>
						  
<cfoutput query="Cert">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="edit_cp_submit.cfm?ID=#ID#">		

<b>Program</b><br>
<input type="text" name="program" value="#Program#" size="92"><br><br>

<b>Owner</b><br>
<input type="text" name="owner" value="#Owner#"><br><br>

<b>Responsibility</b><br>
<input type="text" name="responsibility" value="#Responsibility#"><br><br>

<b>Control</b><br>
<input type="text" name="Control" value="#Control#"><br><br>

<cflock scope="SESSION" timeout="60">
<cfif SESSION.Auth.AccessLevel is "Admin" or SESSION.Auth.AccessLevel is "Quality" or SESSION.Auth.AccessLevel is "SU">
   <cfswitch expression="#IQA#">
   <cfcase value="Yes">
<b>IQA Program Audit List?</b><br>
Yes <input type="Radio" Name="IQA" Value="Yes" checked> No <INPUT TYPE="Radio" NAME="IQA" value="No"><br><br>	 
   </cfcase> 
   <cfcase value="No">
<b>IQA Program Audit List?</b><br>
Yes <input type="Radio" Name="IQA" Value="Yes"> No <INPUT TYPE="Radio" NAME="IQA" value="No" checked><br><br>	 
   </cfcase>
   <cfcase value="">
<b>IQA Program Audit List?</b><br>
Yes <input type="Radio" Name="IQA" Value="Yes"> No <INPUT TYPE="Radio" NAME="IQA" value="No" checked><br><br>	 
   </cfcase>
   </cfswitch>      
</cfif>
</cflock>					  
					  
<INPUT TYPE="Submit" value="Save and Continue">
</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->