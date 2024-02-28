<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="KP">
SELECT * FROM KP
ORDER BY KP
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="RD">
SELECT * FROM RD
ORDER BY RD
</CFQUERY>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
</style></head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<img border=0 height=53 src="/pagetempheader.gif" usemap=#FPMap0 width=756 align="top"> 
      <map name=FPMap0><area coords=0,41,89,52 
        href="http://#CGI.Server_Name#/" shape=RECT><area coords=94,40,226,52 
        href="http://#CGI.Server_Name#/deprtserv.htm" shape=RECT><area 
        coords=229,42,288,52 href="http://#CGI.Server_Name#/library.htm" 
        shape=RECT><area coords=290,40,353,52 
        href="http://#CGI.Server_Name#/toolkit/" shape=RECT><area 
        coords=451,41,560,52 href="http://#CGI.Server_Name#/employinfo.htm" 
        shape=RECT><area coords=564,37,664,52 
        href="http://#CGI.Server_Name#/cnsmrcrnr/" shape=RECT><area 
        coords=669,40,755,52 href="http://#CGI.Server_Name#/globalsites.htm" 
        shape=RECT><area coords=630,2,755,36 href="http://www.ul.com/" 
        shape=RECT><area coords=0,2,327,41 href="http://#CGI.Server_Name#/" 
        shape=RECT><area coords=396,6,442,14,431,30,396,33,358,25,360,14 
        href="http://#CGI.Server_Name#/help.htm" shape=POLY><area 
        coords=508,6,554,15,540,31,490,33,469,21,481,9 
        href="http://#CGI.Server_Name#/sitemap.htm" shape=POLY><area 
        coords=356,39,447,52 href="http://#CGI.Server_Name#/ee/" 
      shape=RECT></map> 
	
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
						  
							<cfinclude template="adminMenu.cfm">
							
							</td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <br>
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title"><p align="left">Key Processes and Reference Documents</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="46%" align="left" class="blog-content" valign="top">
						  <br><b>Reference Documents</b>
					<br><br>
						   <CFOUTPUT query="RD">
						  - #RD#<br>
						  </CFOUTPUT>
						  - <a href="addRD.cfm">Add</a> 
						  				  
						  </td>
						  <td width="46%" align="left" class="blog-content" valign="top">
						  <br><b>Key Processes</b>
					  <br><br>
						   <CFOUTPUT query="KP">
						  - #KP#<br>
						  </CFOUTPUT>
						  - <a href="addKP.cfm">Add</a>
						  				  
						  </td>
                          <td width="4%"></td>
                        </tr>

						
                        <tr> 
                          <td height="123">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="../images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>
                      </table> 
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
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
				  <p align="center"><font color=#808080 face=Arial size=1><a 
            href="http://#CGI.Server_Name#/"><font face="Arial, Helvetica, sans-serif"><br>
			      UL Net Home</font></a><font face="Arial, Helvetica, sans-serif"> - <a 
            href="http://#CGI.Server_Name#/deprtserv.htm">Departments &amp; Services</a> - <a 
            href="http://#CGI.Server_Name#/library.htm">Library</a> - <a 
            href="http://#CGI.Server_Name#/toolkit/">GBS</a> - <a 
            href="http://#CGI.Server_Name#/ee/">Electronic Eye</a> - <a 
            href="http://#CGI.Server_Name#/employinfo.htm">Employee Info Center</a> - <a href="http://#CGI.Server_Name#/cnsmrcrnr/">Consumer Corner</a> -&nbsp; <a 
            href="http://#CGI.Server_Name#/globalsites.htm">Global UL Sites</a></font></font> </p>
		          <p align=center><font face="Arial, Helvetica, sans-serif" size="1">The UL Net is a resource designed to assist you and other UL employees worldwide. We welcome and encourage your feedback. For questions or updates regarding IQA web content, please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher J. Nicastro</a>. Please direct any questions, comments, suggestions or problems with this site&nbsp; to the <a href="http://#CGI.Server_Name#/help.htm">UL NET TEAM</a>. Copyright &copy; 2004 Underwriters Laboratories Inc.&reg; All rights reserved.</font>                   
		          <p align=center><br>			      
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

