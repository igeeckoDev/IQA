<CFQUERY BLOCKFACTOR="100" NAME="Month" Datasource="Corporate">
	SELECT * FROM Month
	ORDER BY alphaID
</cfquery>

	<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT * FROM IQAtblOffices
	WHERE Exist <> 'No'
	ORDER BY OfficeName
	</cfquery>
	
	<CFQUERY BLOCKFACTOR="100" NAME="QRSAuditor" Datasource="Corporate">
	SELECT * FROM QRSAuditor
	ORDER BY Auditor
	</cfquery>	
	
<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
<script language="JavaScript" src="validate.js"></script>		
<script language="JavaScript" src="date.js"></script>	

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
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              Add QRS Audit</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
		

					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="QRS_AddAudit_Submit.cfm">


<cfoutput>
<cfset maxyear = #curyear# + 3>
</cfoutput>

Audit Year: (required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#maxyear#" from="#curyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="QRS">

Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
		<OPTION value="" SELECTED>- None -
<CFOUTPUT QUERY="Month">
		<OPTION VALUE="#ID#">#Month#
</CFOUTPUT>
</SELECT>
<br><br>

Type of Audit: (required)<br>
<SELECT NAME="AuditType">
	<OPTION VALUE="Accreditation">Accreditation
	<OPTION VALUE="EMS">EMS
	<OPTION VALUE="QMS">QMS
								
</SELECT>
<br><br>

Site being Audited: (required)<br>
<SELECT NAME="OfficeName">
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

Auditor: (required)<br>
<SELECT NAME="QRSAuditor">
<CFOUTPUT QUERY="QRSAuditor">
		<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT><br><br>

Primary Contact(s): (required, external UL email addresses)<br>
<INPUT TYPE="TEXT" NAME="e_Email" VALUE="" size="80" displayname="Contacts"><br><br>

Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="" onchange="return ValidateSDate()"><br><br>
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="" onchange="return ValidateEDate()"><br><br>

Scope/Report<br>
DMS File Number:<br>
<INPUT TYPE="Text" NAME="e_Scope" VALUE="" displayname="Scope"><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>			  
	
					  
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

