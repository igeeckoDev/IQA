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

<cfoutput>
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.AccessLevel is "Auditor" OR SESSION.Auth.AccessLevel is "IQAAuditor">
	<cfset AuditedBy = "IQA">
	<cfelse>
	<cfset AuditedBy = #SESSION.Auth.Region#>
	</cfif>
</cflock>
</cfoutput>

<cflock scope="SESSION" timeout="60">
<cfquery name="Output" Datasource="Corporate">
SELECT * FROM Query
WHERE OfficeName='#URL.OfficeName#' AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.AccessLevel is "Auditor" OR SESSION.Auth.AccessLevel is "IQAAuditor">
<cfelse>
AND AuditedBy = '#SESSION.Auth.Region#'
</cfif>
</cfquery>
</cflock>

<cfoutput>						  
<b><u>Audit Coverage #URL.Year# - #OfficeName# - #AuditedBy#</u></b><br>
Select year: 
<A href="audit_coverage.cfm?Year=#curyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#startyear#</A> ::  
<a href="audit_coverage.cfm?Year=#nextyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#nextyear#</A> :: 
<A href="audit_coverage.cfm?Year=#twoyear#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">#twoyear#</A><br>
</cfoutput><br>

<div align="Left" class="blog-time">
Audit Plan and Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

<cfoutput>
<a href="Audit_Plan2.cfm?OfficeName=#URL.OfficeName#&Start=#StartYear#&AuditedBy=#AuditedBy#">View</a> Audit Plan<br>
</cfoutput>

<cfif output.recordcount is "0">
<br>There have been no audits conducted for this office in <cfoutput>#URL.Year#</cfoutput>.<br>
<cfelse>
<br>
<cfoutput>
<a href="Audit_Coverage2.cfm?Year=#URL.Year#&OfficeName=#URL.OfficeName#&AuditedBy=#AuditedBy#">Compress</a> Coverage<br>
</cfoutput>
These Audit Coverage is comprised of the audits listed below.<br><br>
<cfset i = 1>
<cfoutput query="output" group="ID">
#i#: <u>#Year#-#ID#</u>: #Area#<br>
<cfset i = i + 1>
</cfoutput><br>

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
<cfoutput query="output" group="ID">
<td class="blog-content">

<Table border="1" width="66">
<tr><td class="blog-content" align="center"><b>#i#</b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year" or col is "ID" or col is "OfficeName" or col is "Comments" or col is "AuditedBy">
<cfelse>
<tr>
 <td class="blog-content">
  <cfif output[col][i] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#Year#-#ID#</a>
	<cfelse>
	-- <br>
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

