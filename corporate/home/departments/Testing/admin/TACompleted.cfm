<CFQUERY BLOCKFACTOR="100" name="Summary" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE AuditType LIKE '%Technical Assessment%'
AND Approved = 'Yes'
ORDER BY YEAR DESC, Month DESC, StartDate DESC, EndDate DESC
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
                              Audit Summary - Technical Assessments Completed
</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
<ul>
<CFOUTPUT query="Summary">						  

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

<cfif trim(year) gt CurYear>

<cfelseif trim(year) is CurYear>

<cfif Trim(Status) is NOT "deleted">
	<cfif Trim(Month) is CurMonth>
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<cfif Trim(StartDate) lt CurDate>

		<CFIF ExternalLocation is "- None -">
			<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#</a></b> - #OfficeName#, <cfset CompareDate = Compare(StartDate, EndDate)>

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
		
		<CFELSEIF OfficeName is "- None -">
			<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#</a></b> - #ExternalLocation#, <cfset CompareDate = Compare(StartDate, EndDate)>

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
		

<CFELSE>
</CFIF>

<CFELSE>
</CFIF>	
			
			<cfelse>

			</cfif>
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">

		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>

		<CFIF ExternalLocation is "- None -">
			<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#</a></b> - #OfficeName#, <cfset CompareDate = Compare(StartDate, EndDate)>
						
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
		
		
		<CFELSEIF OfficeName is "- None -">
			<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#</a></b> - #ExternalLocation#, <cfset CompareDate = Compare(StartDate, EndDate)>

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
		

<CFELSE>
</CFIF>

<CFELSE>
</CFIF>	
			
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>

			<cfelse>
			</cfif>
		<cfelse>
		</cfif>	
	<cfelseif CurMonth gt Trim(Month)>

		<CFIF ExternalLocation is "- None -">
			<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#</a></b> - #OfficeName#, <cfset CompareDate = Compare(StartDate, EndDate)>

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
		
		
		<CFELSEIF OfficeName is "- None -">
			<li><b><a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#</a></b> - #ExternalLocation#, <cfset CompareDate = Compare(StartDate, EndDate)>

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
		

<CFELSE>
</CFIF>

<CFELSE>
</CFIF>		

		


</CFOUTPUT>		  
</ul>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->