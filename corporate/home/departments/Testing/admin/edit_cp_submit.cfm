<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="AddCF"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 31ef4909-a019-4ab3-b856-76b82f384276 Variable Datasource name --->
UPDATE CertPrograms
SET 

Program='#Form.Program#',
Owner='#Form.Owner#',
Responsibility='#Form.Responsibility#',
Control='#Form.Control#',
IQA='#Form.IQA#'

WHERE ID=#URL.ID#
<!---TODO_DV_CORP_002_End: 31ef4909-a019-4ab3-b856-76b82f384276 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY Name="Cert" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 92058fc7-2cfd-4206-89ae-63b2e2b8e370 Variable Datasource name --->
SELECT * From CertPrograms
WHERE ID = #URL.ID#
<!---TODO_DV_CORP_002_End: 92058fc7-2cfd-4206-89ae-63b2e2b8e370 Variable Datasource name --->
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

<b>Program</b><br>
#Program#<br><br>

<b>Owner</b><br>
#Owner#<br><br>

<b>Responsibility</b><br>
#Responsibility#<br><br>

<b>Control</b><br>
#Control#<br><br>

<b>IQA Program Audit List</b><br>
#IQA#<br><br>

<a href="certprograms.cfm">Certification Programs List</a>

</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->