<cfquery name="Output" Datasource="Corporate">
SELECT * FROM QueryTP_AA
WHERE ExternalLocation='#URL.ExternalLocation#'
ORDER BY Year
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
                              </p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<cfoutput>						  
<br><b><u>CAP-AA - Audit Coverage - #ExternalLocation#</u></b><br>
</cfoutput>

<cfif output.recordcount is "0">
<br>There have been no audits conducted for this Third Party Participant with the new reporting format.<br>
<cfelse>
<br>
<cfoutput query="output" group="ID">
<u>#Year#-#ID#</u><br>
</cfoutput><br>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAA">
SELECT * FROM CAPAA
ORDER BY ID
</CFQUERY>

<Table width="700">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="650" valign="top">
<tr><td class="blog-content">&nbsp;</td></tr>
<cfoutput query="CAPAA" startrow="1" maxrows="25">
<tr><td class="blog-content">
#CAPAA#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 1>
<cfoutput query="output" group="ID">
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content"><b>#year#-#id#</b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "comments" or col is "Year" or col is "ID" or col is "ExternalLocation" or col is "auditedby">
<cfelse>
<tr><td class="blog-content">
  <cfif output[col][i] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
</cfif>  
</cFLOOP>
<cfset i = i+1>
</TABLE>

</td>
 </cfoutput>

</tr>
</TABLE>

</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

