<CFIF AuditPlanFile is "">
<cflocation url="addreport.cfm?ID=#ID#&Year=#Year#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="AuditPlanFile" 
DESTINATION="#basedir#Plans\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/x-zip-compressed">

<cfset FileName="#Form.AuditPlanFile#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">

 
<cffile
    action="rename"
    source="#FileName#"
    destination="#basedir#Plans\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule

SET 
<CFIF AuditPlanFile is "">
<CFELSE>
Plan='#NewFileName#'
</CFIF>

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
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
                              Audit Details - Plan Upload</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<CFQUERY BLOCKFACTOR="100" name="AddReport" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="AddReport">
<b>Audit Number</b> - #Year#-#ID#<br>
<b>Location</b> - <cfif Trim(OfficeName) is "" or Trim(OfficeName) is "- None -">#ExternalLocation#<br>
<cfelse>#OfficeName#<br></cfif>

<b>Auditor</b> - #Auditor#<br>

<b>Type of Audit</b> - #AuditType#<br>
<b>Scope</b> - #Scope#<br>

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
<br>

<b>Dates</b> - 

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

<a href="../Reports/#Report#">Audit Report</a> - Click to view.<br>

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

Status - 
<cfif trim(year) gt CurYear>

<cfif Trim(Status) is NOT "deleted">
<img src="../images/yellow.jpg" border="0">
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

<cfelseif trim(year) is CurYear>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
	<cfif Trim(Month) is CurMonth>
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<cfif Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="../images/green.jpg" border="0">
				<cfelse>
					<img src="../images/blue.jpg" border="0">
				</cfif>
			<cfelse>
				<img src="../images/yellow.jpg" border="0">
			</cfif>
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
			<img src="../images/yellow.jpg" border="0">
		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="../images/green.jpg" border="0">
				<cfelse>
					<img src="../images/blue.jpg" border="0">
				</cfif>
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
				<img src="../images/yellow.jpg" border="0">
			<cfelse>
			</cfif>
		<cfelse>
		</cfif>	
	<cfelseif CurMonth gt Trim(Month)>
		<cfif Trim(AuditType) is "Technical Assessment">
			<img src="../images/green.jpg" border="0">
		<cfelse>
			<img src="../images/blue.jpg" border="0">
		</cfif>
	<cfelse>
		<img src="../images/yellow.jpg" border="0">
	</cfif>
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

<cfelse>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted" and Trim(AuditType) is NOT "Technical Assessment">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(AuditType) is "Technical Assessment">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted" and Trim(AuditType) is NOT "Technical Assessment">
<img src="../images/blue.jpg" border="0">
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

</cfif>

<b>Key Processes</b> - #KP#<br>
<b>Reference Documents</b> - #RD#<br>
<b>Notes</b> - #Notes#
</cfoutput>

<br>
<hr>
<br>

<CFOUTPUT>
File Upload was Successful! Information about the file is detailed below.
<HR>
Content Type: #File.ContentType#<br>
Content SubType: #File.ContentSubType#<br>
Client Directory: #File.ClientDirectory#<br>
Client File: #File.ClientFile#<br>
Client FileName: #File.ClientFileName#<br>
Client FileExt: #File.ClientFileExt#<br>
Server Directory: #File.ServerDirectory#<br>
Server File: #File.ServerFile#<br>
Attempted ServerFile: #File.AttemptedServerFile#<br>
File Existed? #File.FileExisted#<br>
File Was Saved? #File.FileWasSaved#<br>
File Was Overwritten? #File.FileWasOverWritten#<br>
File Was Renamed? #File.FileWasRenamed#<br>
</CFOUTPUT>
						  
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->