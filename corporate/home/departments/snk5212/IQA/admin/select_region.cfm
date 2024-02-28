<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.accesslevel is "SU">

<cfquery Datasource="Corporate" name="Region"> 
SELECT * from IQARegion, IQASubRegion
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = IQASubRegion.Region
ORDER BY IQARegion.Region, IQASubRegion.SubRegion
</CFQUERY>

<CFelseIF SESSION.Auth.accesslevel is "Europe" or SESSION.Auth.accesslevel is "Asia Pacific">

<cfquery Datasource="Corporate" name="Region"> 
SELECT * from IQARegion, IQASubRegion
WHERE IQASubRegion.SubRegion <> 'None'
AND IQARegion.Region = '#Session.Auth.AccessLevel#'
AND IQARegion.Region = IQASubRegion.Region
ORDER BY IQARegion.Region, IQASubRegion.SubRegion
</CFQUERY>

<cfelse>
</cfif>
</cflock>

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
					  
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"></td>
						  <td class="blog-subtitle"><p align="left"><br>Select Region - Adding an Audit</p></td>
                          <td></td>
						</tr>
						<tr> 
						  <td width="3%" height="20" align="right"></td>
						  <td width="94%" align="left" class="blog-content"><p align="left"><br>
						  
<cfset RegHolder=""> 

<CFOUTPUT Query="Region"> 
<cfif RegHolder IS NOT Region> 
<cfIf RegHolder is NOT ""><br></cfif>
<b>#Region#</b><br> 
</cfif>
<cfif Region is "Europe">
&nbsp;&nbsp; - <a href="addaudit.cfm?AuditedBy=Europe">Europe</a><br>
<cfelse>
&nbsp;&nbsp; - <a href="addaudit.cfm?AuditedBy=#SubRegion#">#SubRegion#</a><br>
</cfif>
<cfset RegHolder = Region> 
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->