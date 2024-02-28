<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

					
              <td class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td valign="top" class="content-column-left"> 
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
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title">
<br>Published Audit Reports</td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="sched-content" valign="top">
						  <br>
<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>				  
<cfset nextmonth = CurMonth + 1>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
	<CFQUERY BLOCKFACTOR="100" NAME="Published" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM AuditSchedule
 WHERE (report IS NULL or report = '1' or report = '2' or report = '3' or report = '4' or report = '5' or report = 'completed' or report = 'entered')
	 AND YEAR_='#curyear#' AND Month < #nextmonth# AND  AuditedBy = 'IQA'
	 AND Status IS NULL
 ORDER BY Month, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "IQAAuditor">
	<CFQUERY BLOCKFACTOR="100" NAME="Published" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM AuditSchedule
 WHERE (report IS NULL or report = '1' or report = '2' or report = '3' or report = '4' or report = '5' or report = 'completed' or report = 'entered')
	 AND YEAR_='#curyear#' AND Month < #nextmonth# AND  AuditedBy = 'IQA'
	 AND Status IS NULL AND  LeadAuditor = '#SESSION.Auth.Name#'
 ORDER BY Month, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>
</cfif>
</cflock>

<cfif Published.recordcount is 0>
No Published or Completed Reports.
<cfelse>
<cfset m = "">
<cfoutput query="Published">
<cfif m is NOT month>
<cfIf m is NOT ""><br></cfif>
<b><u>#MonthAsString(month)#</u></b><br>
<cfelse>
</cfif>

#Year#-#ID#-#AuditedBy# 
<cfif AuditType is "TPTDP">
 <a href="TPReport_output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">View</a>
 :: <a href="tpreport_publish.cfm?ID=#ID#&Year=#Year#">Publish</a>
 :: <a href="TPReport_Edit1.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">Edit</a> 
<cfelse>
 <a href="Report_output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">View</a>
 :: <a href="report_publish.cfm?ID=#ID#&Year=#Year#">Publish</a>
 :: <a href="Report_Edit1.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">Edit</a> 
</cfif>
	 <cfif report is "">
	 [Not Entered]
	 <cfelseif report is "1" or report is "2" or report is "3" or report is "4" or report is "5">
	 [Report In Process]
	 <cfelseif report is "Entered">
	 [Completed, Not Published]
	 <cfelseif report is "Completed">
	 [Published]
	 </cfif>
<br>
<cfset m = month>
</cfoutput>
</cfif>						  
					
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->