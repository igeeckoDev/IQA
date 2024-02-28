<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Internal Quality Audits</title>

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
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
					<td class="table-masthead" align="right" valign="middle">&nbsp;</td>

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
                          <td class="blog-date"><p align="center">IQA Admin</p></td>
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

<cfif curyear gte 2006 AND curyear lte 2008>
	<cfset StartYear = 2006>
<cfelseif curyear gte 2009 AND curyear lte 2011>
	<cfset StartYear = 2009>
<cfelseif curyear gte 2012 AND curyear lte 2014>
	<cfset StartYear = 2012>	
</cfif>

<cfset NextYear = #startyear# + 1>
<cfset TwoYear = #startyear# + 2>
						  
<cfquery name="Output" Datasource="Corporate">
SELECT * FROM Query
WHERE OfficeName='#URL.OfficeName#' AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
</cfquery>

<cfoutput>
<b><u>Audit Coverage #URL.Year# - #OfficeName#</u></b><br>
Select year: 
<A href="audit_coverage.cfm?Year=#startyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#startyear#</A> ::  
<a href="audit_coverage.cfm?Year=#nextyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#nextyear#</A> :: 
<A href="audit_coverage.cfm?Year=#twoyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#twoyear#</A><br>
</cfoutput><br>

<div align="Left" class="blog-time">
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

<cfoutput>
<a href="Audit_Coverage.cfm?Year=#URL.Year#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">Expand</a> Coverage<br>
<a href="Audit_Plan2.cfm?OfficeName=#URL.OfficeName#&Start=#StartYear#&AuditedBy=#AuditedBy#">View</a> Audit Plan<br>
</cfoutput>

<cfif output.recordcount is "0">
<br>There have been no audits conducted for this office in <cfoutput>#URL.Year#</cfoutput>.<br>
<cfelse>
<br>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses
ORDER BY ID
</cfquery>

<Table width="700">
<tr>
<td class="blog-content" valign="top">

<Table border="1" width="650" valign="top">
<tr><td class="blog-content"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td></tr>
<cfoutput query="Clauses" startrow="1" maxrows="34">
<tr>
<td class="blog-content">
#title#
</td></tr> 
</cfoutput>

</table>

</td>

<cfset i = 1>
<cfset C=ArrayNew(1)>
<cfloop index="j" from="1" to="34">
<CFSET C[j] = 0>
</cfloop>

<cfset j = 1>
<cfoutput query="output" group="ID">
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year" or col is "ID" or col is "OfficeName" or col is "Comments">
<cfelse>
  <cfif output[col][i] IS "1">
  	<cfset C[j]= C[j]+1>
	<cfelse>
  </cfif>
 <cfset J = J+1>  
</cfif>  
	<cfif J eq 35>
	<cfset J = 1>
	</cfif>
</cFLOOP>
<cfset i = i+1>
</cfoutput>

<cfoutput>
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b><a href="Audit_Coverage.cfm?Year=#URL.Year#&OfficeName=#URL.OfficeName#">#Year#</a></b></td></tr>
<cfloop index="j" from="1" to="34">
<tr>
 <td class="blog-content" align="center">
  <cfif c[j] gte 1>
  	<b>X</b><br>
	<cfelse>
	--<br>
  </cfif>
</td></tr> 
</cfloop>
</TABLE>

</td>
</cfoutput>
</tr>
</TABLE>

</cfif>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

