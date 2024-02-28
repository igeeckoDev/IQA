<CFQUERY BLOCKFACTOR="100" NAME="Query" Datasource="Corporate">
UPDATE PolicyRevs

SET Status='#FORM.Status#'

WHERE ID=#URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Name="PolicyRevDetails" Datasource="Corporate">
SELECT * FROM PolicyRevs
WHERE ID = #URL.ID#
ORDER BY PolicyRev
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Name="PolicyDetails" Datasource="Corporate">
SELECT * FROM Policy
WHERE ID = #URL.ID#
</CFQUERY>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Internal Quality Audits</title>
		<link href="css.css" rel="stylesheet" media="screen">

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style><link rel="stylesheet" type="text/css" href="http://#CGI.Server_Name#/header/ulnetheader.css" />
</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<SCRIPT language=JavaScript src="http://#CGI.Server_Name#/header/header.js"></SCRIPT>
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
					<td class="table-masthead" align="right" valign="middle"><div align="center"><img src="../images/IQA2.jpg" width="317" height="34"></div></td>

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
                          <td class="blog-date"><p align="center">Internal Quality 
                              Audits</p></td>
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
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title"><br><p align="left">Audit Document Changes - Detail</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" valign="top" align="left" class="blog-content">
<br>						  
<CFOUTPUT Query="PolicyDetails">
<p><b>#IAPolicy#</b> - <a href="http://#CGI.Server_Name##FileLocation#">View File</a></p>
</CFOUTPUT>

<CFOUTPUT Query="PolicyRevDetails">
<p><b>Status</b>- #Status#</p>

</CFOUTPUT>	

<p><a href="docs.cfm">View the Audit Documents page</a></p>					 
						  </table>
                      <br> 
                      
                      
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      
					  <table width="100%">
                        <tr><td width="70%">&nbsp;</td>
					  <td width="30%" align="left">

						</td>
						</tr></table>
                      
                    </td>
                    <td class="horizontalbar">&nbsp;</td>
                    <td class="content-column-right" valign="top">&nbsp;</td>
                  </tr>
                </table></td>
				</tr>
				<tr>
				  <td class="table-bookend-bottom-footer" valign="top">
				  <div class="box-header">&nbsp;</div>
				</td>
				  </tr>
				  <tr>				  
<td class="table-bookend-bottom-footer">
<cfinclude template="../footer.cfm">            
</td>
			  </tr>
				<tr>
				  <td class="table-bookend-bottom">&nbsp;</td>
			  </tr>
				<tr>
					<td></td>

				</tr>
			</table>
			</div>
			</td></tr></table>
		
</div>
	</body>

</html>
