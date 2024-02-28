<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY Name="Alerts" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * From  IQADB_ALERTS  "ALERTS" WHERE ID = #URL.ID#

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
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
                          <td class="blog-date"><p align="center">Audit Details</p></td>
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
                              Auditor Alerts</td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
						
						<tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-content"><p align="left"><br>
                              <CFOUTPUT QUERY="Alerts">
							  <img src="../images/ico_article.gif" border="0"> <b>#Subject#</b><br><br>
							  <cfif Trim(Start) is NOT "" and Trim(End) is "">
							  Effective <cfset S = #Start#>#DateFormat(S, 'mm/dd/yyyy')#<br><br>
							  <cfelseif Trim(Start) is NOT "" and Trim(End) is NOT "">
							  Effective from <cfset S = #Start#>#DateFormat(S, 'mm/dd/yyyy')# to <cfset E = #End#>#DateFormat(E, 'mm/dd/yyyy')#<br><br>
							  <cfelseif Trim(Start) is "" and Trim(End) is NOT "">
							  Effective until <cfset E = #End#>#DateFormat(E, 'mm/dd/yyyy')#<br><br>
							  <cfelseif Trim(Start) is "" and Trim(End) is "">
							  <cfelse>
							  Effective from <cfset S = #Start#>#DateFormat(S, 'mm/dd/yyyy')# to <cfset E = #End#>#DateFormat(E, 'mm/dd/yyyy')#<br><br>
							  </cfif>
							  <cfif Notes is ""><cfelse><b>Notes:</b> #Notes#<br><br></cfif>
							  <cfif File is ""><cfelse><b>Attached File:</b> <a href="../alertdocs/#File#">View</a><br><br></cfif>
							  <hr align="left" noshade width="85%">
							  <br>
							  #Details#
							  </CFOUTPUT>
							  </p></td>
                          
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->