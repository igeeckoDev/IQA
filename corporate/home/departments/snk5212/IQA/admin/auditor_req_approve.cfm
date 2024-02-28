<CFQUERY BLOCKFACTOR="100" NAME="AddAuditor" Datasource="Corporate">
UPDATE AuditorList
SET

<cfif URL.Action is "Yes">
Status='Active'
<cfelse>
Status='Denied'
</cfif>

WHERE ID=#URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="AddProfile" Datasource="Corporate">
SELECT * FROM AuditorList, IQAtblOffices
WHERE AuditorList.ID = #URL.ID#
AND AuditorList.Location = IQAtbloffices.OfficeName
</CFQUERY>

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
                              Auditor Request</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

						  
<CFOUTPUT query="AddProfile">
<B>#Auditor#</B> has been #URL.Action#<cfif URL.Action is "yes"> and added to the <a href="Aprofiles.cfm?view=all">Auditor List</a></cfif>.<br><br>
</CFOUTPUT>	

<cfmail 
	query="AddProfile"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#Email#, Global.InternalQuality@ul.com"
	subject="Auditor Request - Approved" 
	Mailerid="Reminder">
	
Your Audit Request has been #URL.Action#. For any questions pertaining to your auditor status, please contact #RQM#.
	
</cfmail>		  
<br><br>
<a href="Aprofiles.cfm?view=all">Return to the Auditor Profiles</a>						 

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

