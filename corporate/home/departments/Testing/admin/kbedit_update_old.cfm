<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfif Form.File is "">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKB">
UPDATE KB
SET 
Subject='#Form.Subject#',
Posted=<cfif Form.Posted is "">null<cfelse>'#Form.Posted#'</cfif>,
Details='#Form.Details#'

WHERE ID=#URL.ID#
</CFQUERY>

<cfelse>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#basedir#KB\attachments\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/msword, application/vnd.ms-powerpoint, application/vnd.ms-excel, application/x-zip-compressed">

<cfset FileName="#Form.File#">

<cfset NewFileName="#ID#.#cffile.ClientFileExt#">

 
<cffile
    action="rename"
    source="#FileName#"
    destination="#basedir#KB\attachments\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddKB"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
UPDATE KB SET Subject='#Form.Subject#', FILE_='#NewFileName#', Posted=<cfif Form.Posted is "">null<cfelse>'#Form.Posted#'</cfif>, Details=<CFQUERYPARAM VALUE='#Form.Details#'>
 WHERE ID=#URL.ID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

</cfif>	

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Show">
SELECT * FROM KB
WHERE  ID=#URL.ID#
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
                          <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">


				<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left">
						 <cfinclude template="adminMenu.cfm">
                            </td>
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
                          <td width="3%" height="20" align="right"></td>
                          <td width="94%" align="left" class="blog-content"><p align="left"><br>
						
<cfinclude template="KBMenu.cfm">				  
						  
<br><br>						  
<b>Knowledge Base - Edit Article</b>
<br><br>						  

<CFOUTPUT Query="Show"> 
<B>#Subject#</B><br><br>
#Posted#<br>
Written by: #Author#<br>
Listed under: #KBTopics#
<cfif File is ""><cfelse><br>Attachment: <a href="../kb/attachments/#File#">Click to view file</a></cfif>
<br><br>
<hr align="left" noshade width="85%"><br>
#Details#
</CFOUTPUT>


<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->