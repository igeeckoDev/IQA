<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>
<cfset Plus2Year = #CurYear# + 2>
<cfset Minus2Year = #CurYear# - 2>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cfif link is "http://#CGI.Server_Name##curdir#OfficeSummary.cfm">
<cfset Bob = FORM.ExternalLocation>
<cfelse>
<cfset Bob = URL.ExternalLocation>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Summary" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ExternalLocation='#Bob#'
AND Approved = 'Yes'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
ORDER BY YEAR DESC, Month DESC, StartDate DESC, EndDate DESC
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="records" Datasource="Corporate">
SELECT COUNT(*) As Count FROM AuditSchedule
WHERE ExternalLocation='#Bob#'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
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
                          <td width="3%"></td> <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	<cfinclude template="AdminMenu.cfm">
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
                              Audit Summary<br><br>
<CFIF Bob is "- None -">
<CFELSE>
<CFOUTPUT>
#Bob#
</CFOUTPUT>
</CFIF>
</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<CFIF Bob is "- None -">
<p>Please select a UL Office, LES, or a TPTDP participant.</p>
<CFELSE>

<CFIF records.count is 0>
No records found.
<CFELSE>

<br>
<p><b><CFOUTPUT>#Bob#</b>
<cfif URL.Year is LastYear>
<p align="left">#LastYear# <a href="TPTDPAuditSummary.cfm?Year=#CurYear#&ExternalLocation=#Bob#">[ #CurYear# ]</a> <a href="TPTDPAuditSummary.cfm?Year=#NextYear#&ExternalLocation=#Bob#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<p align="left"><a href="TPTDPAuditSummary.cfm?Year=#LastYear#&ExternalLocation=#Bob#">[ #LastYear# ]</a> #CurYear# <a href="TPTDPAuditSummary.cfm?Year=#NextYear#&ExternalLocation=#Bob#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<p align="left"><a href="TPTDPAuditSummary.cfm?Year=#LastYear#&ExternalLocation=#Bob#">[ #LastYear# ]</a> <a href="TPTDPAuditSummary.cfm?Year=#CurYear#&ExternalLocation=#Bob#">[ #CurYear# ]</a> #NextYear# <br><br>
<cfelse>
</cfif>
</CFOUTPUT>

<br>
<CFOUTPUT query="Summary">
<b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b>, <cfset CompareDate = Compare(StartDate, EndDate)>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">scheduled for 
<cfif Trim(Month) is 1>
January, #Year#
<cfelseif Trim(Month) is 2>
February, #Year#
<cfelseif Trim(Month) is 3>
March, #Year#
<cfelseif Trim(Month) is 4>
April, #Year#
<cfelseif Trim(Month) is 5>
May, #Year#
<cfelseif Trim(Month) is 6>
June, #Year#
<cfelseif Trim(Month) is 7>
July, #Year#
<cfelseif Trim(Month) is 8>
August, #Year#
<cfelseif Trim(Month) is 9>
September, #Year#
<cfelseif Trim(Month) is 10>
October, #Year#
<cfelseif Trim(Month) is 11>
November, #Year#
<cfelseif Trim(Month) is 12>
December, #Year#
<cfelse>
No month scheduled.
</cfif>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>

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

</CFIF>	  
 <br><br>
 
Return to the  <a href="AuditSummary.cfm">Audit Summary page</a>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->