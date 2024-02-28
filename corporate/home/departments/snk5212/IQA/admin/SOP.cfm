<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<cfoutput>
		<title>#Request.SiteTitle#</title>
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "CPO">
<link href="#Request.CSS2#" rel="stylesheet" media="screen">
<cfelse>
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfif>
</cflock>
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
<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="date.js"></script>        
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
                          	<cfif cgi.path_translated is "#path#Andon_Add.cfm"
								or cgi.PATH_TRANSLATED is "#path#Andon_Review.cfm"
								or cgi.PATH_TRANSLATED is "#path#Andon_Edit.cfm"
								or cgi.PATH_TRANSLATED is "#path#Andon_OK.cfm"
								or cgi.PATH_TRANSLATED is "#path#manage.cfm" 
								AND cgi.QUERY_STRING CONTAINS "Role=Andon">
                                	<cfinclude template="#Request.AndonMenu#">
                            <cfelseif cgi.path_translated is "#path#lists.cfm" 
								or cgi.PATH_TRANSLATED is "#path#KPRD.cfm"
								or cgi.PATH_TRANSLATED is "#path#cf.cfm"
								or cgi.PATH_TRANSLATED is "#path#gf.cfm"
								or cgi.PATH_TRANSLATED is "#path#lf.cfm"
								or cgi.PATH_TRANSLATED is "#path#ASAccred.cfm"
								or cgi.PATH_TRANSLATED is "#path#Accred.cfm"
								or cgi.PATH_TRANSLATED is "#path#AddKP.cfm"
								or cgi.PATH_TRANSLATED is "#path#AddRD.cfm"
								or cgi.PATH_TRANSLATED is "#path#cf_edit.cfm"
								or cgi.PATH_TRANSLATED is "#path#gf_edit.cfm"
								or cgi.PATH_TRANSLATED is "#path#lf_edit.cfm"
								or cgi.PATH_TRANSLATED is "#path#ASAccred_Edit.cfm"
								or cgi.PATH_TRANSLATED is "#path#Accred_Edit.cfm">
                            		<cfinclude template="#Request.ListsMenu#">
                            <cfelseif cgi.PATH_TRANSLATED is "#path#_prog.cfm" 
								or cgi.PATH_TRANSLATED is "#path#_prog_edit.cfm"
								or cgi.PATH_TRANSLATED is "#path#_prog_detail.cfm"
								or cgi.PATH_TRANSLATED is "#path#_prog_add.cfm"
								or cgi.path_translated is "#path#_prog_rh_master.cfm" 
								or cgi.path_translated is "#path#_progRHLog.cfm"
								or cgi.path_translated is "#path#_progRHLog2.cfm">
                                	<cfinclude template="#Request.ProgMenu#">
							<cfelse>
							  	<cfinclude template="#Request.adminmenu#">
							</cfif>
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
                          <td width="94%" align="left" class="blog-subtitle"><p align="left"><br>
                              <a name="Top"></a><cfoutput>#title#</cfoutput></p></td>
                          <td width="3%" align="right" nowrap>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left" valign="top">