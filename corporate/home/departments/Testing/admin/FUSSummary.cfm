<!--- DV_CORP_002 02-APR-09 --->
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>
<cfset Plus2Year = #CurYear# + 2>
<cfset Minus2Year = #CurYear# - 2>

<CFQUERY BLOCKFACTOR="100" name="Summary" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 1f549c4e-42df-403e-9371-183ea08c3dfe Variable Datasource name --->
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE (AuditType2 = 'Field Services' or OfficeName = 'Field Services')
AND Approved = 'Yes'
AND Year_ = '#URL.Year#'
ORDER BY OFFICENAME, Area, AuditType, ID
<!---TODO_DV_CORP_002_End: 1f549c4e-42df-403e-9371-183ea08c3dfe Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="records" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 283e8620-7111-4f3a-982f-d048bf3fac3c Variable Datasource name --->
SELECT COUNT(*) As Count FROM AuditSchedule
WHERE (AuditType2 = 'Field Services' or OfficeName = 'Field Services')
AND Approved = 'Yes'
AND Year_ = '#URL.Year#'
<!---TODO_DV_CORP_002_End: 283e8620-7111-4f3a-982f-d048bf3fac3c Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
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
                              Audit Summary - Field Services</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<br>
<p><CFOUTPUT>
<cfif URL.Year is LastYear>
<p align="left">#LastYear# <a href="FUSSummary.cfm?Year=#CurYear#">[ #CurYear# ]</a> <a href="FUSSummary.cfm?Year=#NextYear#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<p align="left"><a href="FUSSummary.cfm?Year=#LastYear#">[ #LastYear# ]</a> #CurYear# <a href="FUSSummary.cfm?Year=#NextYear#">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<p align="left"><a href="FUSSummary.cfm?Year=#LastYear#">[ #LastYear# ]</a> <a href="FUSSummary.cfm?Year=#CurYear#">[ #CurYear# ]</a> #NextYear# <br><br>
<cfelse>
</cfif>
</CFOUTPUT>

<CFIF records.count is 0>
No records found.
<CFELSE>

<cfset OfficeHolder=""> 

<CFOUTPUT query="Summary">
<cfif OfficeHolder IS NOT OfficeName> 
<cfIf OfficeHolder is NOT ""><br></cfif>
<b>#OfficeName#</b><br> 
</cfif>

<b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a></b> - 

<cfif AuditType2 is "Field Services">
#Area#, 
<cfelse>
	<cfif AuditedBy is "AS">
	#AuditType#, 
	<cfelse>
	<cfif OfficeName is "Field Services">
	#AuditType#, 
	<cfelse>
	#OfficeName#, #AuditType#,
	</cfif> 
	</cfif>
</cfif>

<cfset CompareDate = Compare(StartDate, EndDate)>
<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
<cfif Month is "" or Month is 0>
month not specified, 
<cfelse>
scheduled for #MonthAsString(Month)#, 
</cfif>
#Year#
						
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#
	</cfif>
</cfif>
<cfif AuditedBy is NOT "AS">
 (#LeadAuditor#)
<cfelse>
 (AS Contact: #ASContact#) 
</cfif>
<br>
<cfset OfficeHolder = OfficeName> 
</CFOUTPUT>
</cfif>	 

 <br><br>
 
Return to the  <a href="AuditSummary.cfm">Audit Summary page</a>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->