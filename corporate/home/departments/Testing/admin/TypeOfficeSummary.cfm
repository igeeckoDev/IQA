<CFQUERY BLOCKFACTOR="100" name="Summary" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE Approved = 'Yes'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AuditType" Datasource="Corporate">
	SELECT AuditType FROM AuditType
	WHERE AuditType <> 'SMT'
	ORDER BY AuditType
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT OfficeName FROM IQAtbloffices
	ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="ExternalLocation" Datasource="Corporate">
	SELECT ExternalLocation FROM ExternalLocation
	ORDER BY ExternalLocation
</cfquery>

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
                          <td width="3%"></td> <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	<cfinclude template="AdminMenu.cfm">
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
                              Audit Summary</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<p>Please choose a Type of Audit and aa UL Office, LES or TPTDP location.</p>						  
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" Action="TypeOfficeAuditSummary.cfm?Year=#CurYear#">
</cfoutput> 

Type of Audit:<br>
<SELECT NAME="AuditType">
		<Option Value="AS">Accreditation Audits
<CFOUTPUT QUERY="AuditType">
		<cfif AuditType is NOT "Field Services">
		<OPTION VALUE="#AuditType#">#AuditType#
		</cfif>
</CFOUTPUT>
</SELECT>
<br><br>

Location: (Internal) 
<br>
<SELECT NAME="OfficeName">
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

Location: (External) 
<br>
<SELECT NAME="ExternalLocation">
<CFOUTPUT QUERY="ExternalLocation">
		<OPTION VALUE="#ExternalLocation#">#ExternalLocation#
</CFOUTPUT>
</SELECT>
<br><br>

<INPUT TYPE="Submit" value="Submit">
</FORM>
			  
 <br><br>
 
Return to the  <a href="AuditSummary.cfm">Audit Summary page</a>
                           
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->