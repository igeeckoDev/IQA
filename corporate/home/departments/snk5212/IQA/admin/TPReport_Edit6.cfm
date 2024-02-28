<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfquery name="Input" Datasource="Corporate">
UPDATE TPReport5
SET 

<cfloop index="x" list="#form.fieldnames#">
<cfoutput>
<cfif x is "Comments">
<cfelse>
#x# = #form[x]#,
</cfif>
</cfoutput>
</cfloop>
Comments='N/A'

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID=#URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TPInfo">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#Audit.ExternalLocation#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAA">
SELECT * FROM CAPAA
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Output">
SELECT * FROM TPReport6
WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
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
                             Add Report (5) - ISO 17025 Audit Coverage Matrix</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  

<cfoutput query="Audit">		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport_Edit6_submit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#&CAPAA=Yes">
</cfoutput>

<Table width="700" valign="top">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="600" valign="top">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="CAPAA" startrow="1" maxrows="14">
<tr><td class="blog-content2" valign="top">
#CAPAA#
</td></tr> 
</cfoutput>
</table>

</td>
<td class="blog-content" valign="top">

<Table border="1" width="100">
<tr><td class="blog-content" valign="top"><b><cfoutput>#year#-#id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Comments" or col is "Year" or col is "ID">
<cfelse>
 <cfoutput query="Output" maxrows="14">
<tr><td class="blog-content" valign="top">
  <cfif output[col][1] IS "1">
   Yes <input type="Radio" name="#col#" Value="1" checked> 
   No <INPUT TYPE="Radio" name="#col#" value="0">	
  <cfelse>
   Yes <input type="Radio" name="#col#" Value="1"> 
   No <INPUT TYPE="Radio" name="#col#" value="0" checked>
  </cfif>
</td></tr> 
 </cfoutput>
</cfif>  
</cfloop>
</TABLE>

</td>
</tr>
</TABLE>

<INPUT TYPE="Submit" value="Save and Continue">
</FORM>

 
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->