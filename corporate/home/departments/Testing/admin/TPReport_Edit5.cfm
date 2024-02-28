<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE TPReport4

SET	
DC='#Form.DC#', DCComments ='#FORM.e_DCComments#',
MR='#Form.MR#', MRComments ='#FORM.e_MRComments#',
IA='#Form.IA#', IAComments ='#FORM.e_IAComments#',
RE='#Form.RE#', REComments ='#FORM.e_REComments#',
CA='#Form.CA#', CAComments='#Form.e_CAComments#',
Overall='#Form.Overall#', OverallComments='#Form.e_OverallComments#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ID
</CFQUERY>

<cfquery name="Output" Datasource="Corporate">
SELECT * FROM TPReport5
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID = #URL.ID#
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
						  

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#Audit.ExternalLocation#'
</CFQUERY>

<cfoutput query="Check">
<cfif Check.Type is "CAP-EA/AA" or Check.Type is "CAP-AA">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport_Edit6.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
<cfelse>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport_edit5_submit.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
</cfif>
</cfoutput>

<Table width="600" valign="top">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="500" valign="top">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="ISO17025">
<tr><td class="blog-content2" valign="top">
<cfset Dump1 = #replace(ISO_17025_2005, "Clause ", "", "All")#>
#Dump1#
</td></tr> 
</cfoutput>
</table>

</td>
<td class="blog-content" valign="top">

<Table border="1" width="100">
<tr><td class="blog-content" valign="top"><b><cfoutput>#year#-#id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "ID" or col is "Year" or col is "comments" or col is "AuditedBy">
<cfelse> 
 <cfoutput query="Output">
<tr><td class="blog-content2" valign="top">
  <cfif col is "003">
	<cfif form.dc is "yes" or form.dc is "no">
	Yes <input type="hidden" name="#col#" value="1">
	<cfelse>
	No <input type="hidden" name="#col#" value="0">
	</cfif>
  <cfelseif col is "011">
	<cfif form.ca is "yes" or form.ca is "no">
	Yes <input type="hidden" name="#col#" value="1">
	<cfelse>
	No <input type="hidden" name="#col#" value="0">
	</cfif>
  <cfelseif col is "013">
	<cfif form.re is "yes" or form.re is "no">
	Yes <input type="hidden" name="#col#" value="1">
	<cfelse>
	No <input type="hidden" name="#col#" value="0">
	</cfif>
  <cfelseif col is "014">
	<cfif form.ia is "yes" or form.ia is "no">
	Yes <input type="hidden" name="#col#" value="1">
	<cfelse>
	No <input type="hidden" name="#col#" value="0">
	</cfif>
  <cfelseif col is "015">
	<cfif form.mr is "yes" or form.mr is "no">
	Yes <input type="hidden" name="#col#" value="1">
	<cfelse>
	No <input type="hidden" name="#col#" value="0">
	</cfif>	
  <cfelse>
  <cfif output[col][1] IS "1">
   Yes <input type="Radio" name="#col#" Value="1" checked> 
   No <INPUT TYPE="Radio" name="#col#" value="0">	
  <cfelse>
   Yes <input type="Radio" name="#col#" Value="1"> 
   No <INPUT TYPE="Radio" name="#col#" value="0" checked>
  </cfif>
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

