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
                          <td width="3%"></td> <td class="blog-date"><p align="center">Third Party Report Card</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	
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
                          <td width="94%" align="left" class="blog-title"><p align="left">&nbsp;</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left" valign="top"><p align="left">

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>
Select which quarterly report you would like to view.<br>Each Quarter represents the Third Party Clients audited during that timeframe.<br><br>

<!---
<cfif url.year LESS THAN OR EQUAL TO 2005>
There are no Report Cards available for years previous to 2006.
<cfelse>
	<cfif curmonth LESS THAN OR EQUAL TO 3>
			<cfset n = 4>
			<cfset year = #CurYear# - 1>
	<cfelseif curmonth LESS THAN OR EQUAL TO 6 AND curmonth Greater Than 3>
		<cfset n = 1>
		<cfset year = #curyear#>
	<cfelseif curmonth LESS THAN OR EQUAL TO 9 AND curmonth Greater Than 6>
		<cfset n = 2>
		<cfset year = #curyear#>
	<cfelseif curmonth LESS THAN OR EQUAL TO 12 AND curmonth Greater Than 9>
		<cfset n = 3>
		<cfset year = #curyear#>
	</cfif>
</cfif>
--->

<cfoutput>
<cfloop from="2006" to="2007" index="n">
	<b>#n#</b><br>
	<cfloop from="1" to="4" index="i">
		- <a href="quarterly.cfm?quarter=#i#&year=#n#">Quarter #i#</a><br>
		<cfif i eq 4><br></cfif>
	</cfloop>
</cfloop>
</cfoutput>
	
<!---
<cfoutput>
<b>#year#</b><br>
<cfloop from="1" to="#n#" index="i">
- <a href="quarterly.cfm?quarter=#i#&year=#year#">Quarter #i#</a><br>
</cfloop><br>

<b>2006</b><br>
<cfloop from="1" to="4" index="i">
- <a href="quarterly.cfm?quarter=#i#&year=2006">Quarter #i#</a><br>
</cfloop>
</cfoutput>
--->
</td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="../images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>
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