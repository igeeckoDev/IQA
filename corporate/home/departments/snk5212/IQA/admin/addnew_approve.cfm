<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT MAX(ID) + 1 AS newid
 FROM AuditSchedule
 WHERE YEAR_=#FORM.Year#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO AuditScheduleApprove(ID, Year)
VALUES (#Query.newid#, #FORM.Year#)
</CFQUERY>


<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
UPDATE AuditScheduleApprove
SET 
<cfif ExternalLocation is "- None -" or ExternalLocation is "">
OfficeName='#FORM.OfficeName#',
AuditArea='#FORM.AuditArea#',
<cfelse>
ExternalLocation='#FORM.ExternalLocation#',
</cfif>

<cfif Form.StartDate is "">
StartDate=null,
<cfelse>
StartDate='#FORM.StartDate#',
</cfif>

<cfif Form.EndDate is "">
EndDate=null,
<cfelse>
EndDate='#FORM.EndDate#',
</cfif>

<cfif Form.RD is "- None -" or Form.RD is "">
<cfelse>
RD='#FORM.RD#',
</cfif>

<cfif Form.KP is "- None -" or Form.KP is "">
<cfelse>
KP='#FORM.KP#',
</cfif>

Approved='Yes',
Month='#Month#',
LeadAuditor='#FORM.LeadAuditor#',
Auditor='#FORM.Auditor#',
AuditType='#FORM.AuditType#',
Scope='#FORM.Scope#',
Notes='#FORM.Notes#'
WHERE ID=#Query.newid# AND Year=#FORM.Year#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ScheduleAddApprove" Datasource="Corporate">
SELECT * FROM AuditScheduleApprove
WHERE ID=#Query.newid# AND Year=#FORM.Year#
</CFQUERY>

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
                              Audit Schedule - Add New Audit</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

						  
<CFOUTPUT query="ScheduleAddApprove">
Your data has been updated and is awaiting approval.<br><br>
<b>ID</b> - #Year#-#ID#<br>
<b>Scope</b> - #Scope#<br>
<b>LeadAuditor(s)</b> - #LeadAuditor#<br>
<b>Auditor(s)</b> - #Auditor#<br>

<b>Location</b> - 
<cfif Trim(OfficeName) is "- None -" or Trim(OfficeName) is "">
#ExternalLocation#<br>
<cfelse>
#OfficeName#<br>
</cfif>
<b>Type of Audit</b> - #AuditType#<br>

<b>Month Scheduled</b> - 
<cfif Trim(Month) is 1>
January
<cfelseif Trim(Month) is 2>
February
<cfelseif Trim(Month) is 3>
March
<cfelseif Trim(Month) is 4>
April
<cfelseif Trim(Month) is 5>
May
<cfelseif Trim(Month) is 6>
June
<cfelseif Trim(Month) is 7>
July
<cfelseif Trim(Month) is 8>
August
<cfelseif Trim(Month) is 9>
September
<cfelseif Trim(Month) is 10>
October
<cfelseif Trim(Month) is 11>
November
<cfelseif Trim(Month) is 12>
December
<cfelse>
No month scheduled.
</cfif>
</b>
<br>

<b>Dates of Audit</b> - 
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">No dates scheduled<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is ""><cfset Start = #StartDate#>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0><cfset Start = #StartDate#>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif Trim(StartDate) is "" AND Trim(EndDate) is NOT ""><cfset End = #EndDate#>#DateFormat(End, 'mmmm dd, yyyy')#
<br>
<cfelse>
<cfset Start = #StartDate#>#DateFormat(Start, 'mmmm dd')# - <cfset End = #EndDate#>#DateFormat(End, 'dd, yyyy')#<br>
</cfif>

<cfif Trim(RD) is "- None -">
<b>Reference Documents</b> - None Specified<br>
<cfelse>
<b>Reference Documents</b> - #RD#<br>
</cfif>

<cfif Trim(KP) is "- None -">
<b>Key Processes</b> - None Specified<br>
<cfelse>
<b>Key Processes</b> - #KP#<br>
</cfif>

<b>Notes</b> - #Notes#<br>

</CFOUTPUT>	

<br><br>
<a href="schedule.cfm">Return to the Audit Schedule</a>						 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

