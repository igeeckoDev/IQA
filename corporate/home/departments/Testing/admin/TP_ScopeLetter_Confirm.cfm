<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfQUERY Datasource="Corporate" Name="Check">
SELECT * FROM Scope
WHERE ID = #URL.ID# and YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif check.recordcount is 0>

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

<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<CFQUERY Datasource="Corporate" Name="EnterScope">
INSERT INTO Scope(ID, Year)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">)
</CFQUERY>

<cfif Form.e_AttachA is NOT "">

<CFFILE ACTION="UPLOAD" 
FILEFIELD="e_AttachA" 
DESTINATION="#basedir#ScopeLetters\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/x-zip-compressed, application/msword">

<cfset FileName="#Form.e_AttachA#">

<cfset NewFileName="#URL.Year#-#URL.ID#-Attach.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#basedir#ScopeLetters\#NewFileName#">
	
</cfif>

<CFQUERY Datasource="Corporate" Name="EnterScope">
UPDATE Scope
SET

AttachA='#NewFileName#',
Name='#Form.Name#',
ContactEmail='#Form.ContactEmail#',
Address1='#Form.Address1#',
Address2='#Form.Address2#',
Address3='#Form.Address3#',
Address4='#Form.Address4#',
FileNo='#Form.FileNo#',
<cfif SelectAudit.Billable is "Yes">
Cost='#Form.Cost#',
</cfif>
<cfif form.cc is "">
<cfelse>
cc='#form.cc#',
</cfif>
Phone='#Form.Phone#',
AuditorEmail='#Form.AuditorEmail#',
Auditor='#SelectAudit.LeadAuditor#',
DateSent='#CurDate#'

WHERE ID = #URL.ID# AND YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY Datasource="Corporate" Name="ScopeEntered">
UPDATE AuditSchedule
SET

ScopeLetter = 'Entered',
StartDate = '#DateFormat(Form.StartDate, 'mm/dd/yyyy')#',
<cfif Form.EndDate is "" or Form.EndDate eq Form.StartDate>
EndDate = '#DateFormat(Form.StartDate, 'mm/dd/yyyy')#',
<cfelse>
EndDate = '#DateFormat(Form.EndDate, 'mm/dd/yyyy')#',
</cfif>
ScopeLetterDate = '#CurDate#'

WHERE ID = #URL.ID# AND YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY Datasource="Corporate" Name="KCInfo">
UPDATE ExternalLocation
SET

Address1='#Form.Address1# ',
<cfif IsDefined("Form.Address2")>
Address2='#Form.Address2# ',
<cfelse>
</cfif>
<cfif IsDefined("Form.Address3")>
Address3='#Form.Address3# ',
<cfelse>
</cfif>
<cfif IsDefined("Form.Address4")>
Address4='#Form.Address4# ',
<cfelse>
</cfif>
FileNumber='#Form.FileNo#',
KC='#Form.Name#',
KCEmail='#Form.ContactEmail#'

WHERE ExternalLocation = '#SelectAudit.ExternalLocation#'
</cfquery>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.Desk, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact,

ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.ExternalLocation, ExternalLocation.FileNumber,

Scope.Address1, Scope.Address2, Scope.Address3, Scope.Address4, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.FileNo, Scope.Cost, Scope.AuditorEmail, Scope.CC
 FROM AuditSchedule, ExternalLocation, Scope
 WHERE AuditSchedule.ID = #URL.ID#
 AND  AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  Scope.ID = #URL.ID#
 AND  Scope.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

</cfif>

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
                             Scope Letter Sent</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<cfif check.recordcount is 0>						  
						  
<cfoutput query="Scope">

	<cfif year lt 2007>
	<cfinclude template="scopetemplateTP4_old.cfm">
	<cfelseif year gte 2007>
	<cfinclude template="scopetemplateTP4.cfm">
	</cfif>

"Attachment A" File: <a href="../scopeletters/#AttachA#">#AttachA#</a><br>
</cfoutput>	

<cfmail to="#ContactEmail#" from="#AuditorEmail#" cc="Internal.Quality_Audits@ul.com, #cc#" bcc="#AuditorEmail#"  mimeattach="#basedir#ScopeLetters\#AttachA#" subject="General Assessment of Laboratory Operations under UL's Data Acceptance Program" query="Scope">

	<cfif year lt 2007>
	<cfinclude template="scopetemplateTP3_old.cfm">
	<cfelseif year gte 2007>
	<cfinclude template="scopetemplateTP3.cfm">
	</cfif>
	
Attached File: #AttachA#
</cfmail>

<cfelse>

<cfoutput>
#URL.Year#-#URL.ID# Scope has already been sent.<br><br>
<a href="scopeletter_view.cfm?year=#url.year#&id=#url.id#">
View</a> Scope Letter
</cfoutput>
</cfif>
	  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->