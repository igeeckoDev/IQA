<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>
<cfset Plus2Year = #CurYear# + 2>
<cfset Minus2Year = #CurYear# - 2>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cfif link is "http://#CGI.Server_Name##curdir#TypeOfficeSummary.cfm">
<cfset Bob = Form.AuditType>
<CFIF Office is "- None -">
<cfset Ex = Form.ExternalLocation>
<CFELSE>
<cfset Office = Form.OfficeName>
</cfif>
<cfelse>
<cfset Bob = URL.AuditType>
<CFIF Office is "- None -">
<cfset Ex = URL.ExternalLocation>
<cfelse>
<cfset Office = URL.OfficeName>
</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Summary" Datasource="Corporate">
SELECT * FROM AuditSchedule
<cfif Form.AuditType is "AS">
WHERE AuditedBy = 'AS'
<cfelse>
WHERE AuditType LIKE '%#Bob#%'
</cfif>
AND Approved = 'Yes'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<CFIF Office is "- None -">AND ExternalLocation='#Ex#'
<CFELSEIF Ex is "- None -">AND OfficeName='#Office#'
<CFELSE>
</CFIF>
ORDER BY YEAR DESC, Month DESC, StartDate DESC, EndDate DESC
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="records" Datasource="Corporate">
SELECT COUNT(*) As Count FROM AuditSchedule
<cfif Form.AuditType is "AS">
WHERE AuditedBy = 'AS'
<cfelse>
WHERE AuditType LIKE '%#Bob#%'
</cfif>
AND Approved = 'Yes'
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<CFIF Office is "- None -">AND ExternalLocation='#Ex#'
<CFELSEIF Ex is "- None -">AND OfficeName='#Office#'
<CFELSE>
</CFIF>
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
							Audit Summary</p><cfoutput>
							 <cfif Form.AuditType is "AS">Accreditation Audits<cfelse>#FORM.AuditType#</cfif>
							 <CFIF FORM.ExternalLocation is "- None -" and FORM.OfficeName is "- None -">	
							 <CFELSEIF FORM.ExternalLocation is "- None -">
							 , #FORM.OfficeName#
							 <CFELSEIF FORM.OfficeName is "- None -">
							 , #FORM.ExternalLocation#
							 <CFELSE>
							 </CFIF>						  
							   </cfoutput><br><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<CFIF Ex is "- None -" and Office is "- None -">						  
<p>Please select a UL Office, LES or TPTDP location on the previous page.</p>

<CFELSEIF Bob is "Quality System" and Office is "- None -">
<p>You must select a UL Office or LES office when choosing Quality System audits.</p>

<CFELSEIF Bob is "SMT">
<p>Please choose another type of audit. SMT audits are not tracked in this schedule.</p>

<CFELSEIF Bob is "Technical Assessment" and Office is "- None -">
<p>You must select a UL Office or LES office when choosing Technical Assessment audits.</p>

<CFELSEIF Bob is "TPTDP" and Ex is "- None -">
<p>You must select a TPTDP Participant location when choosing TPTDP audits.</p>

<CFELSEIF Bob is "AS" and Ex is NOT "- None -">
<p>You must select a UL Office or LES when choosing Accreditation audits.</p>

<CFELSEIF Bob is "AS" and Office is "- None -">
<p>You must select a UL Office or LES when choosing Accreditation audits.</p>

<CFELSEIF Ex is "- None -">

<CFIF records.count is 0>
No records found.
<CFELSE>

<br>
<p><CFOUTPUT>
<cfif URL.Year is LastYear>
<p align="left">#LastYear# <a href="TypeOfficeAuditSummary.cfm?Year=#CurYear#&AuditType=#Bob#&OfficeName=#Office#">[ #CurYear# ]</a> <a href="TypeOfficeAuditSummary.cfm?Year=#NextYear#&AuditType=#Bob#&OfficeName=#Office#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<p align="left"><a href="TypeOfficeAuditSummary.cfm?Year=#LastYear#&AuditType=#Bob#&OfficeName=#Office#">[ #LastYear# ]</a> #CurYear# <a href="TypeOfficeAuditSummary.cfm?Year=#NextYear#&AuditType=#Bob#&OfficeName=#Office#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<p align="left"><a href="TypeOfficeAuditSummary.cfm?Year=#LastYear#&AuditType=#Bob#&OfficeName=#Office#">[ #LastYear# ]</a> <a href="TypeOfficeAuditSummary.cfm?Year=#CurYear#&AuditType=#Bob#&OfficeName=#Office#">[ #CurYear# ]</a> #NextYear# <br><br>
<cfelse>
</cfif>
</CFOUTPUT>

<CFOUTPUT query="Summary">
<b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> <cfif AuditArea is ""><cfelse>(#Trim(AuditArea)#)</cfif> - <cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
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

<CFELSEIF Office is "- None -">

<br>
<p><CFOUTPUT>
<cfif URL.Year is LastYear>
<p align="left">#LastYear# <a href="TypeOfficeAuditSummary.cfm?Year=#CurYear#&AuditType=#Bob#&ExternalLocation=#Ex#">[ #CurYear# ]</a> <a href="TypeOfficeAuditSummary.cfm?Year=#NextYear#&AuditType=#Bob#&ExternalLocation=#Ex#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<p align="left"><a href="TypeOfficeAuditSummary.cfm?Year=#LastYear#&AuditType=#Bob#&ExternalLocation=#Ex#">[ #LastYear# ]</a> #CurYear# <a href="TypeOfficeAuditSummary.cfm?Year=#NextYear#&AuditType=#Bob#&ExternalLocation=#Ex#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<p align="left"><a href="TypeOfficeAuditSummary.cfm?Year=#LastYear#&AuditType=#Bob#&ExternalLocation=#Ex#">[ #LastYear# ]</a> <a href="TypeOfficeAuditSummary.cfm?Year=#CurYear#&AuditType=#Bob#&ExternalLocation=#Ex#">[ #CurYear# ]</a> #NextYear# <br><br>
<cfelse>
</cfif>
</CFOUTPUT>

<CFIF records.count is 0>
No records found.
<CFELSE>

<CFOUTPUT query="Summary">
<b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> - <cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
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
						
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#
	</cfif>
</cfif><br>
</cfoutput>
</cfif>

<CFELSE>
<p>Please select a UL Office, LES or TPTDP location on the previous page. Only one location selection can be made at a time</p>
</CFIF>	  
 <br><br>
 
Return to the  <a href="AuditSummary.cfm">Audit Summary page</a>
                           
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->