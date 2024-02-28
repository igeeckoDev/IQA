<CFQUERY Datasource="Corporate" Name="SelectAudit">
SELECT * FROM AuditSchedule, ExternalLocation, AuditorList
WHERE AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
AND AuditSchedule.LeadAuditor = AuditorList.Auditor
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
				<td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td> <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	<cfinclude template="adminMenu.cfm">
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
                             Enter Type of Scope Letter</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<cfoutput query="SelectAudit">						  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Data" ACTION="TP_ScopeLetter_Send.cfm?ID=#ID#&Year=#Year#&AuditType=#AuditType#&Type=#Type#">

Select Type of Audit:<br>

<cfif URL.AuditType is "TPTDP">

<SELECT NAME="TPTDP">
	<OPTION VALUE="EAInitial">CAP EA Initial Assessment
	<OPTION VALUE="EARe">CAP EA Continuing Assessment
	<OPTION VALUE="EAAAInitial">CAP EA/AA Initial Assessment
	<OPTION VALUE="EAAARE">CAP EA/AA Continuing Assessment
	<OPTION VALUE="CTLInitial">CTL Initial Assessment
	<OPTION VALUE="CTLRE">CTL Continuing Assessment	
	<OPTION VALUE="MOUInitial">MOU Initial Assessment
	<OPTION VALUE="MOURE">MOU Continuing Assessment
	<OPTION VALUE="SCLInitial">SCL Initial Assessment
	<OPTION VALUE="SCLRE">SCL Continuing Assessment
	<OPTION VALUE="INVInitial">TPTDP by Invitation Initial Assessment
	<OPTION VALUE="INVRE">TPTDP by Invitation Continuing Assessment
</SELECT><br><br>

<cfelseif URL.AuditType is "Technical Assessment">

<cflocation url="addreport.cfm?ID=#ID#&Year=#Year#" addtoken="no">

<cfelse>

<cflocation url="ScopeLetter_Send.cfm?ID=#ID#&Year=#Year#&AuditType=#AuditType#&AuditType2=#AuditType2#" addtoken="no">

</cfif>

<INPUT TYPE="Submit" value="Submit">
</form>
</cfoutput>
					  
 <br>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->