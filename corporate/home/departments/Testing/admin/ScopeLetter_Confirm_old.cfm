<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfQUERY Datasource="Corporate" Name="Check">
SELECT * FROM Scope
WHERE ID = #URL.ID# and YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif check.recordcount is 0>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="SelectAudit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.ScopeLetterDate, AuditorList.Auditor, AuditorList.Phone, AuditorList.Email, auditschedule.desk
 FROM AuditSchedule, AuditorList
 WHERE AuditSchedule.YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
 AND  AuditSchedule.ID = #URL.ID#
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
Title='#Form.Title#',
ContactEmail='#Form.ContactEmail#',
Phone='#Form.Phone#',
<cfif SelectAudit.AuditType2 is "Field Services">
StartTime='#TimeFormat(Form.StartTime, "h:m tt")#',
</cfif>
<cfif form.cc is "">
<cfelse>
cc='#form.cc#',
</cfif>
AuditorEmail='#Form.AuditorEmail#',

Auditor='#SelectAudit.LeadAuditor#',
DateSent='#DateFormat(CurDate, 'mm/dd/yyyy')#'

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

<CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor As Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, Scope.Title, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.CC, auditschedule.desk
 FROM AuditSchedule, Scope
 WHERE AuditSchedule.YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
 AND  AuditSchedule.ID = #URL.ID#
 AND  Scope.ID = #URL.ID#
 AND  Scope.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
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

<cfif audittype2 is "Field Services">
	<cfif year lt 2006>
	<cfinclude template="FSTemplate4_old.cfm">
	<cfelseif year is 2006>
		<cfif month lte 8>
		<cfinclude template="FSTemplate4_old.cfm">
		<cfelseif month gte 9>
		<cfinclude template="FSTemplate4.cfm">
		</cfif>
	<cfelseif year gte 2007>
	<cfinclude template="FSTemplate4.cfm">	
	</cfif>
<cfelse>
<cfif year lt 2006>
	<cfif audittype2 is "Program">
	<cfinclude template="QSwProgTemplate4_old.cfm">
	<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate4_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4_old.cfm">
		<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4_old.cfm">	
		</cfif>
	<cfelseif month gte 8>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4.cfm">
		<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif audittype2 is "Program">
	<cfinclude template="QSwProgTemplate4.cfm">
	<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate4.cfm">
	</cfif>
</cfif>
</cfif>

"Attachment A" File: <a href="../scopeletters/#AttachA#">#AttachA#</a><br>
</cfoutput>	

<cfif AuditType2 is "Program">
	
	<cfmail 
	to="#ContactEmail#" 
	from="#AuditorEmail#" 
	cc="Internal.Quality_Audits@ul.com, #cc#" 
	bcc="#AuditorEmail#"
	mimeattach="#basedir#ScopeLetters\#AttachA#"
	subject="Audit of #Trim(Area)#" 
	query="Scope">

<cfif year lt 2006>
		<cfinclude template="QSwProgTemplate3_old.cfm">
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfinclude template="QSwProgTemplate3_old.cfm">
	<cfelseif month gte 8>
		<cfinclude template="QSwProgTemplate3.cfm">
	</cfif>
<cfelseif year gte 2007>
		<cfinclude template="QSwProgTemplate3.cfm">
</cfif>	
	Attached File: #AttachA#
	</cfmail>

<cfelseif AuditType2 is "Field Services">

	<cfmail 
	to="#ContactEmail#" 
	from="#AuditorEmail#" 
	cc="Internal.Quality_Audits@ul.com, #cc#" 
	bcc="#AuditorEmail#"
	mimeattach="#basedir#ScopeLetters\#AttachA#"
	subject="Audit of UL #Trim(OfficeName)# - #Trim(Area)# to Underwriters Laboratories Inc.'s Field Services Manual and General criteria for the operation of Various types of bodies performing inspection as detailed in the GIP (Global Inspection Policy)"
	query="Scope">

<cfif year lt 2006>
		<cfinclude template="FSTemplate3_old.cfm">
<cfelseif year is 2006>
	<cfif month lte 8>
		<cfinclude template="FSTemplate3_old.cfm">
	<cfelseif month gte 9>
		<cfinclude template="FSTemplate3.cfm">
	</cfif>
<cfelseif year gte 2007>
		<cfinclude template="FSTemplate3.cfm">
</cfif>
	Attached File: #AttachA#
	</cfmail>

<cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">

	<cfmail 
	to="#ContactEmail#" 
	from="#AuditorEmail#" 
	cc="Internal.Quality_Audits@ul.com, #cc#" 
	bcc="#AuditorEmail#"
	mimeattach="#basedir#ScopeLetters\#AttachA#"
	subject="Quality System Audit of #Trim(OfficeName)# - #Trim(Area)#"
	query="Scope">

<cfif year lt 2006>
		<cfinclude template="QSTemplate3_old.cfm">
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfinclude template="QTemplate3_old.cfm">
	<cfelseif month gte 8>
		<cfinclude template="QSTemplate3.cfm">
	</cfif>
<cfelseif year gte 2007>
		<cfinclude template="QSTemplate3.cfm">
</cfif>	
	Attached File: #AttachA#
	</cfmail>

</cfif>

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