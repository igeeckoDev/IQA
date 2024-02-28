<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<cfoutput>
		<title>#Request.SiteTitle#</title>
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
                          <td>
						  <div align="center" class="blog-date">
						  	<cfoutput>#Request.SiteTitle#</cfoutput>
						  </div>
						  
						  <span align="left" class="blog-content">
						  <!--- Menu Items --->
						  <cfinclude template="menu.cfm">
					<!--- Test if Application is in Development - output last data update date if not --->
							<cfoutput>
								<br>
								<cfif Request.Development eq "Yes">
									<font color="red">
								Application In Development - This is TEST DATA and is NOT ACCURATE
									</font>
								<cfelse>
									Data Current through #dateformat(Request.DataDate, "mm/dd/yyyy")#
								</cfif>
								<br>
							</cfoutput>
						  </span>
						  </td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left">
						  <span align="left" class="blog-subtitle">
						  <br>
						  <a name="Top"></a>
							<cfoutput>
								<cfif isDefined("subTitle")>#subTitle#</cfif>
								<cfif isDefined("subTitle2")> - #subTitle2#</cfif>
								<Br>
							</cfoutput>
						  </span>
						  </td>
                          <td width="3%" align="right" nowrap>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left" valign="top"><br>