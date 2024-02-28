<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="vID">
SELECT MAX(ID) +1 AS NewID FROM IndexVision
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="vQuery"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
INSERT INTO IQADB_INDEX Vision (ID)
VALUES (#vID.NewID#)
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="updateVision" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
UPDATE IQADB_INDEX Vision SET 
RevDate='#FORM.RevDate#',
Vision='#FORM.Vision#'
WHERE ID=#vID.NewID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Vision" Datasource="Corporate">
SELECT * FROM IndexVision
WHERE ID=#vID.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDMission">
SELECT MAX(ID) AS MaxMID FROM IndexMission
</CFQUERY>

<CFQUERY NAME="Mission" Datasource="Corporate">
SELECT * FROM IndexMission
WHERE ID = #IDMission.MaxMID#
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

					
              <td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="left"><br>
                              Index Edit</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">


					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><br><p align="left">Navigation</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
						  	<cfinclude template="adminmenu.cfm">
						  
 <br>
                            </p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%">&nbsp;</td>
                          <td class="blog-time"><p align="left">Index updated!</p></td>
                          <td></td>
                        </tr>
                        
                      </table>

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
                              Vision<CFOUTPUT QUERY="Vision"> - <cfset Rev = #RevDate#>(#DateFormat(Rev, 'mmmm dd, yyyy')#, Rev #VID.NewID#)</CFOUTPUT>
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
: <a href="Index_edit.cfm">edit</a> :</p>
<cfelse>
</p>
</CFIF>
</cflock>	

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->