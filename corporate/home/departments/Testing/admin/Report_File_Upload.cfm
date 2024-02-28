<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

<script language="JavaScript" src="file.js"></script>

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
                          <td width="94%" align="left" class="blog-title"><br>
                              Upload Files - Audit Report<br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">


<div align="Left" class="blog-time">
Report Upload Help - <A HREF="javascript:popUp('../webhelp/webhelp_reportupload.cfm')">[?]</A></div><br>						  
						  
<CFQUERY BLOCKFACTOR="100" name="AddReport" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE ID = #URL.ID#
and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="AddReport">

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="report_fileupload.cfm?ID=#ID#&Year=#Year#&auditedby=#auditedby#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

Upload Audit Report Attachment:<br>
File must be PDF Format. File will be renamed <B>#Year#-#ID#-ReportAttach.pdf</b><br>
<INPUT NAME="File" SIZE=50 TYPE="FILE">

<br><br>
<INPUT TYPE="Submit" value="Upload Report">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->


</body>
</html>
