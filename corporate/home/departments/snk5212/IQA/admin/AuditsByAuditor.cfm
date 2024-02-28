<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>
<cfset Plus2Year = #CurYear# + 2>
<cfset Minus2Year = #CurYear# - 2>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
<cfset Bob = Form.Auditor>
<cfelse>
<cfset Bob = URL.Auditor>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="AuditorInternal" Datasource="Corporate">
SELECT * FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE Auditor LIKE '%#FORM.Auditor#%'
<cfelse>
WHERE Auditor LIKE '%#URL.Auditor#%'
</cfif>
AND Approved = 'Yes'
AND AuditType <> 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
ORDER BY YEAR DESC, Month, StartDate DESC, EndDate DESC
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="LeadAuditorInternal" Datasource="Corporate">
SELECT * FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE LeadAuditor = '#FORM.Auditor#'
<cfelse>
WHERE LeadAuditor = '#URL.Auditor#'
</cfif>
AND Approved = 'Yes'
AND AuditType <> 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
ORDER BY YEAR DESC, Month, StartDate DESC, EndDate DESC
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ARecordsInternal" Datasource="Corporate">
SELECT COUNT(*) As ACountInternal FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE Auditor LIKE '%#FORM.Auditor#%'
<cfelse>
WHERE Auditor LIKE '%#URL.Auditor#%'
</cfif>
AND Approved = 'Yes'
AND AuditType <> 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="LARecordsInternal" Datasource="Corporate">
SELECT COUNT(*) As LACountInternal FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE LeadAuditor = '#FORM.Auditor#'
<cfelse>
WHERE LeadAuditor = '#URL.Auditor#'
</cfif>
AND Approved = 'Yes'
AND AuditType <> 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditorTPTDP" Datasource="Corporate">
SELECT * FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE Auditor LIKE '%#FORM.Auditor#%'
<cfelse>
WHERE Auditor LIKE '%#URL.Auditor#%'
</cfif>
AND Approved = 'Yes'
AND AuditType = 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
ORDER BY YEAR DESC, Month, StartDate DESC, EndDate DESC
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="LeadAuditorTPTDP" Datasource="Corporate">
SELECT * FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE LeadAuditor = '#FORM.Auditor#'
<cfelse>
WHERE LeadAuditor = '#URL.Auditor#'
</cfif>
AND Approved = 'Yes'
AND AuditType = 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
ORDER BY YEAR DESC, Month, StartDate DESC, EndDate DESC
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ARecordsTPTDP" Datasource="Corporate">
SELECT COUNT(*) As ACountTPTDP FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE Auditor LIKE '%#FORM.Auditor#%'
<cfelse>
WHERE Auditor LIKE '%#URL.Auditor#%'
</cfif>
AND Approved = 'Yes'
AND AuditType = 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="LARecordsTPTDP" Datasource="Corporate">
SELECT COUNT(*) As LACountTPTDP FROM AuditSchedule
<cfif link is "http://#CGI.Server_Name##curdir#AuditorSummary.cfm">
WHERE LeadAuditor = '#FORM.Auditor#'
<cfelse>
WHERE LeadAuditor = '#URL.Auditor#'
</cfif>
AND Approved = 'Yes'
AND AuditType = 'TPTDP'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<cfif URL.Year is CurYear>
AND Month >= #CurMonth#
</cfif>
</CFQUERY>

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
						  	<cfinclude template="adminMenu.cfm">
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
                              Audit Summary</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
<br>
<p><b><CFOUTPUT>#Bob#</b> - Lead Auditor - 
<cfif URL.Year is CurYear>
<p align="left">#CurYear# <a href="AuditsByAuditor.cfm?Year=#NextYear#&Auditor=#Bob#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<p align="left"><a href="AuditsByAuditor.cfm?Year=#CurYear#&Auditor=#Bob#">[ #CurYear# ]</a> #NextYear# <br><br>
<cfelse>
</cfif>
</CFOUTPUT>

</p>

<p><u>Internal audits</u></p>

<ul>

<!-- Internal Audits, Lead Auditor -->

<CFIF LARecordsInternal.LACountInternal is 0>
No records found.
<CFELSE>

<CFOUTPUT query="LeadAuditorInternal">						  
<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> - 

<cfif Trim(Status) is 'Deleted'>
<b>Audit Deleted</b> -
<cfelse>
</cfif>

<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<cfif auditarea is "">,<cfelse> (#TRIM(AuditArea)#),</cfif>
<cfelse>
#ExternalLocation#, </cfif>
#AuditType#, <cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
<cfif Trim(Month) is 1>
scheduled for January, #Year#
<cfelseif Trim(Month) is 2>
scheduled for February, #Year#
<cfelseif Trim(Month) is 3>
scheduled for March, #Year#
<cfelseif Trim(Month) is 4>
scheduled for April, #Year#
<cfelseif Trim(Month) is 5>
scheduled for May, #Year#
<cfelseif Trim(Month) is 6>
scheduled for June, #Year#
<cfelseif Trim(Month) is 7>
scheduled for July, #Year#
<cfelseif Trim(Month) is 8>
scheduled for August, #Year#
<cfelseif Trim(Month) is 9>
scheduled for September, #Year#
<cfelseif Trim(Month) is 10>
scheduled for October, #Year#
<cfelseif Trim(Month) is 11>
scheduled for November, #Year#
<cfelseif Trim(Month) is 12>
scheduled for December, #Year#
<cfelse>
No month scheduled.
</cfif> 
						
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#
	</cfif>
</cfif><br>
</CFOUTPUT>	
</CFIF>
</ul>

<br>

<p><u>Third Party audits</u></p>

<ul>

<CFIF LARecordsTPTDP.LACountTPTDP is 0>
No records found.
<CFELSE>

<CFOUTPUT query="LeadAuditorTPTDP">						  
<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> - 

<cfif Trim(Status) is 'Deleted'>
<b>Audit Deleted</b> -
<cfelse>
</cfif>

<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<cfif auditarea is "">,<cfelse> (#TRIM(AuditArea)#),</cfif> 
<cfelse>
#ExternalLocation#, </cfif>
#AuditType#, <cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
<cfif Trim(Month) is 1>
scheduled for January, #Year#
<cfelseif Trim(Month) is 2>
scheduled for February, #Year#
<cfelseif Trim(Month) is 3>
scheduled for March, #Year#
<cfelseif Trim(Month) is 4>
scheduled for April, #Year#
<cfelseif Trim(Month) is 5>
scheduled for May, #Year#
<cfelseif Trim(Month) is 6>
scheduled for June, #Year#
<cfelseif Trim(Month) is 7>
scheduled for July, #Year#
<cfelseif Trim(Month) is 8>
scheduled for August, #Year#
<cfelseif Trim(Month) is 9>
scheduled for September, #Year#
<cfelseif Trim(Month) is 10>
scheduled for October, #Year#
<cfelseif Trim(Month) is 11>
scheduled for November, #Year#
<cfelseif Trim(Month) is 12>
scheduled for December, #Year#
<cfelse>
No month scheduled.
</cfif> 
						
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#
	</cfif>
</cfif><br>
</CFOUTPUT>	
</CFIF>

</ul>	
<br>

<p><b><CFOUTPUT>#Bob#</CFOUTPUT></b> - Auditor</p>

<p><u>Internal audits</u></p>

<ul>
<CFIF ARecordsInternal.ACountInternal is 0>
No records found.
<CFELSE>

<CFOUTPUT query="AuditorInternal">						  
<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> - 
<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<cfif auditarea is "">,<cfelse> (#TRIM(AuditArea)#),</cfif>
<cfelse>
#ExternalLocation#, </cfif>
#AuditType#, <cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
<cfif Trim(Month) is 1>
scheduled for January, #Year#
<cfelseif Trim(Month) is 2>
scheduled for February, #Year#
<cfelseif Trim(Month) is 3>
scheduled for March, #Year#
<cfelseif Trim(Month) is 4>
scheduled for April, #Year#
<cfelseif Trim(Month) is 5>
scheduled for May, #Year#
<cfelseif Trim(Month) is 6>
scheduled for June, #Year#
<cfelseif Trim(Month) is 7>
scheduled for July, #Year#
<cfelseif Trim(Month) is 8>
scheduled for August, #Year#
<cfelseif Trim(Month) is 9>
scheduled for September, #Year#
<cfelseif Trim(Month) is 10>
scheduled for October, #Year#
<cfelseif Trim(Month) is 11>
scheduled for November, #Year#
<cfelseif Trim(Month) is 12>
scheduled for December, #Year#
<cfelse>
No month scheduled.
</cfif> 
						
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#
	</cfif>
</cfif><br>

</CFOUTPUT>	
</CFIF>
</ul>	  

<br>

<p><u>Third Party audits</u></p>

<ul>
<CFIF ARecordsTPTDP.ACountTPTDP is 0>
No records found.
<CFELSE>

<CFOUTPUT query="AuditorTPTDP">						  
<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> - 
<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<cfif auditarea is "">,<cfelse> (#TRIM(AuditArea)#),</cfif>
<cfelse>
#ExternalLocation#, </cfif>
#AuditType#, <cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
<cfif Trim(Month) is 1>
scheduled for January, #Year#
<cfelseif Trim(Month) is 2>
scheduled for February, #Year#
<cfelseif Trim(Month) is 3>
scheduled for March, #Year#
<cfelseif Trim(Month) is 4>
scheduled for April, #Year#
<cfelseif Trim(Month) is 5>
scheduled for May, #Year#
<cfelseif Trim(Month) is 6>
scheduled for June, #Year#
<cfelseif Trim(Month) is 7>
scheduled for July, #Year#
<cfelseif Trim(Month) is 8>
scheduled for August, #Year#
<cfelseif Trim(Month) is 9>
scheduled for September, #Year#
<cfelseif Trim(Month) is 10>
scheduled for October, #Year#
<cfelseif Trim(Month) is 11>
scheduled for November, #Year#
<cfelseif Trim(Month) is 12>
scheduled for December, #Year#
<cfelse>
No month scheduled.
</cfif> 
						
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#
	</cfif>
</cfif><br>

</CFOUTPUT>	
</CFIF>
</ul>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->