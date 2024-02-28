<CFQUERY BLOCKFACTOR="100" name="Plan" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID#
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
</style></head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0"><cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput><div align="left">
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
                              Audit Details</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<CFOUTPUT query="Plan">
<b>#Year#-#ID#</b> <br><br>

<b>Location</b><br>
<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<br>
<cfelse>
#ExternalLocation#<br></cfif><br>

<b>Auditor</b><br>						
#Auditor#<br>
<br>

<b>Type of Audit</b><br>
#AuditType#<br><br>

<b>Month Scheduled</b>
<cfif Trim(Month) is 1>
<br>January
<cfelseif Trim(Month) is 2>
<br>February
<cfelseif Trim(Month) is 3>
<br>March
<cfelseif Trim(Month) is 4>
<br>April
<cfelseif Trim(Month) is 5>
<br>May
<cfelseif Trim(Month) is 6>
<br>June
<cfelseif Trim(Month) is 7>
<br>July
<cfelseif Trim(Month) is 8>
<br>August
<cfelseif Trim(Month) is 9>
<br>September
<cfelseif Trim(Month) is 10>
<br>October
<cfelseif Trim(Month) is 11>
<br>November
<cfelseif Trim(Month) is 12>
<br>December
<cfelse>
<br>No month scheduled.
</cfif>
<br><br>

<b>Audit Dates</b><br>
<cfset CompareDate = Compare(StartDate, EndDate)>
						
<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">No dates scheduled<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
	</cfif>
</cfif><br>

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

<b>Status</b><br> 
<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
	<cfif Trim(Month) is CurMonth>
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<cfif Trim(StartDate) lt CurDate>
				<img src="../images/blue.jpg" border="0">
			<cfelse>
				<img src="../images/yellow.jpg" border="0">
			</cfif>
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
			<img src="../images/yellow.jpg" border="0">
		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
				<img src="../images/blue.jpg" border="0">
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
				<img src="../images/yellow.jpg" border="0">
			<cfelse>
			</cfif>
		<cfelse>
		</cfif>	
	<cfelseif CurMonth gt Trim(Month)>
		<img src="../images/blue.jpg" border="0">
	<cfelse>
		<img src="../images/yellow.jpg" border="0">
	</cfif>
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>
<br><br>
						
<cfif Trim(Report) is "">
<b>Audit Report</b><br>
No Report Submitted - <a href="addreport.cfm?ID=#ID#&Year=#Year#">Upload Report</a><br><br>
<cfelse>
<b>Audit Report</b>
<br><A href="../Reports/#Report#">#Report#</a><br><br>
</cfif>
		
<cfif Trim(Plan) is "">
<b>Audit Plan</b><br>
No Plan Submitted - <a href="addplan.cfm?ID=#ID#&Year=#Year#">Upload Plan</a><br><br>
<cfelse>
<b>Audit Plan</b>
<br><A href="../Plans/#Plan#">#Plan#</a><br><br>
</cfif>		

<cfif Trim(ScopeLetter) is "">
<b>Scope Letter</b><br>
No Scope Letter Submitted - <a href="addScopeLetter.cfm?ID=#ID#&Year=#Year#">Upload Scope Letter</a><br><br>
<cfelse>
<b>Scope Letter</b>
<br><A href="../scopeletters/#ScopeLetter#">#ScopeLetter#</a><br><br>
</cfif>		
			
<cfif Trim(FollowUp) is "">
<b>Audit Report</b><br>
No Follow-Up Submitted - <a href="addFollowUp.cfm?ID=#ID#&Year=#Year#">Upload Follow-Up</a><br><br>
<cfelse>
<b>Follow Up</b>
<br><A href="../FollowUps/#FollowUp#">#FollowUp#</a><br><br>
</cfif>		
						
<b>Scope</b><br>
#Scope#<br><br>

<cfif Trim(KP) is "- None -">
<b>Reference Documents</b>
<br>None Specified<br><br>
<cfelse>
<b>Reference Documents</b>
<br>#RD#<br><br>
</cfif>

<cfif Trim(KP) is "- None -">
<b>Key Processes</b>
<br>None Specified<br><br>
<cfelse>
<b>Key Processes</b>
<br>#KP#<br><br>
</cfif>

<b>Auditor Follow-up Note</b><br>
#Notes#<br><br>
					
<br>			
<br>
</CFOUTPUT>  
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->