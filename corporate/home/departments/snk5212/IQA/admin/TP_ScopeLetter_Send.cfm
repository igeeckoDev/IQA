<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY blockfactor="100" Datasource="Corporate" Name="SelectAudit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.ScopeLetterDate, AuditSchedule.Desk, ExternalLocation.ExternalLocation, ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.Address1, ExternalLocation.Address2, ExternalLocation.Address3, ExternalLocation.Address4, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.FileNumber, AuditorList.Auditor, AuditorList.Phone, AuditorList.Email
 FROM AuditSchedule, ExternalLocation, AuditorList
 WHERE AuditSchedule.ID = #URL.ID#
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
 AND  AuditSchedule.LeadAuditor = AuditorList.Auditor
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="date.js"></script>

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
                             Enter Scope Letter Information</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
						  
<cfoutput query="SelectAudit">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>			  

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TP_ScopeLetter_Submit.cfm?ID=#ID#&Year=#Year#">

	<cfif year lt 2007>
	<cfinclude template="scopetemplateTP2_old.cfm">
	<cfelseif year gte 2007>
	<cfinclude template="scopetemplateTP2.cfm">
	</cfif>

<br>
Necessary Fields:<br>
<b>Contact Name</b><br>
<input name="e_Name" Type="Text" Value="#KC#" displayname="Contact Name"><br><br>
<b>Email</b><br>
<input name="e_ContactEmail" Type="Text" Value="#KCEmail#" displayname="Contact Email"><br><br>
<b>Company Name</b><br>
#ExternalLocation#<br><br>
<b>Client Address</b><br>
<input name="e_Address1" Type="Text" Value="#Address1#" size="50" displayname="Address"><br>
<input name="Address2" Type="Text" Value="#Address2#" size="50"><br>
<input name="Address3" Type="Text" Value="#Address3#" size="50"><br>
<input name="Address4" Type="Text" Value="#Address4#" size="50"><br><br>
<b>File Number</b><br>
<input name="e_FileNo" type="text" value="#FileNumber#" displayname="File Number"><br><br>
<b>Start Date</b> (mm/dd/yyyy)<br>
<input name="e_StartDate" Type="Text" Value="#DateFormat(StartDate, 'mm/dd/yyyy')#" displayname="Start Date" onchange="return ValidateESDate()"><br><br>
<b>End Date</b> (mm/dd/yyyy)<br>
<input name="EndDate" Type="Text" Value="#DateFormat(EndDate, 'mm/dd/yyyy')#" onchange="return ValidateEDate()"><br><br>

<b>Lead Auditor</b><br>
#LeadAuditor#<br><br>

<cfif Billable is "Yes">
<b>Cost and Currency</b><br>
<input name="e_Cost" Type="Text" Value="" displayname="Cost and Currency"><br><br>
</cfif>

<b>Auditor Email</b><br>
<input name="e_AuditorEmail" Type="Text" Value="#Email#" displayname="Auditor Email"><br><br>
Additional Recipients of Scope Letter (cc)<br>
<input name="cc" Type="Text" size="60" Value=""><br><br>
<b>Phone</b><br>
<input name="e_Phone" Type="Text" Value="#Phone#" displayname="Auditor Phone"><br><br><br>

<INPUT TYPE="button" value="Submit Scope Letter" onClick=" javascript:checkFormValues(document.all('Audit'));">
</form>

</cfoutput>		  
 <br>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->