<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="AddCF"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: a9fa4e48-1b6c-486a-90e5-5a2214465c8c Variable Datasource name --->
UPDATE InspectionPrograms
SET 

ProgramName='#Form.ProgramName#',
Owner='#Form.Owner#'

WHERE ID=#URL.ID#
<!---TODO_DV_CORP_002_End: a9fa4e48-1b6c-486a-90e5-5a2214465c8c Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY Name="Insp" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d5cd4371-9e6d-4e1f-b69b-956347bff4ed Variable Datasource name --->
SELECT * From InspectionPrograms
WHERE ID = #URL.ID#
<!---TODO_DV_CORP_002_End: d5cd4371-9e6d-4e1f-b69b-956347bff4ed Variable Datasource name --->
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
						  
<cfoutput query="Insp">

<b>Program</b><br>
#ProgramName#<br><br>

<b>Owner</b><br>
#Owner#<br><br>

<a href="InspectionPrograms.cfm">Inspection Programs List</a>

</cfoutput>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->