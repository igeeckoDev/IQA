<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY Datasource="Corporate" Name="SelectAudit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email as Contact, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.ScopeLetterDate, AuditorList.Auditor, AuditorList.Phone, AuditorList.Email, auditschedule.desk
 FROM AuditSchedule, AuditorList
 WHERE AuditSchedule.YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
 AND  AuditSchedule.ID = #URL.ID#
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
		
<script language="JavaScript" src="date.js"></script>	
		
<script language="JavaScript">		
function check() {
  var ext = document.Audit.e_AttachA.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_AttachA.value.length!=0) || (document.Audit.e_AttachA.value!=null)) {
	 if(ext != 'pdf') {
      if(ext != 'doc') {
	   if(ext != 'zip') {
    alert('You selected a .'+ext+' file; please select a doc, pdf, or zip file!');
    return false; 
	  }
	  }
	 }
	}	
else
return true;
document.Audit.submit();
}
</script>		

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
                             Confirm Scope Letter</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
	
<br>						  
<b>Need to Edit?</b> Click 'back' on your browser's navigation bar.<br><br>
If you wish to submit, press 'Submit Scope Letter' below. Adding Attachment A is required.<br><br>

<hr>
						  
<cfoutput query="SelectAudit">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>								  

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="ScopeLetter_Confirm.cfm?ID=#ID#&Year=#Year#&AuditType=#AuditType#">

<input type="hidden" name="Name" Value="#Form.e_Name#" DisplayName="Contact Name">
<input type="hidden" name="Title" Value="#Form.e_Title#" DisplayName="Contact Title">
<input type="hidden" name="ContactEmail" Value="#Form.e_ContactEmail#" DisplayName="Contact Email">
<input type="hidden" name="Phone" Value="#Form.e_Phone#" DisplayName="Auditor Phone">
<input type="hidden" name="StartDate" Value="#Form.e_StartDate#" DisplayName="Start Date">
<input type="hidden" name="EndDate" Value="#Form.EndDate#">
<cfif URL.AuditType2 is "Field Services">
<input type="hidden" name="StartTime" Value="#Form.e_StartTime#" DisplayName="Start Time">
</cfif>
<input type="hidden" name="AuditorEmail" Value="#Form.e_AuditorEmail#" DisplayName="Auditor Email">
<input type="hidden" name="cc" Value="#Form.cc#">
<input type="hidden" name="AuditType2" Value="#AuditType2#">

<cfif url.audittype2 is "Field Services">
	<cfif year lt 2006>
	<cfinclude template="FSTemplate1_old.cfm">
	<cfelseif year is 2006>
		<cfif month lte 8>
		<cfinclude template="FSTemplate1_old.cfm">
		<cfelseif month gte 9>
		<cfinclude template="FSTemplate1.cfm">
		</cfif>
	<cfelseif year gte 2007>
	<cfinclude template="FSTemplate1.cfm">	
	</cfif>
<cfelse>
<cfif year lt 2006>
	<cfif URL.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate1_old.cfm">
	<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate1_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif URL.audittype2 is "Program">
		<cfinclude template="QSwProgTemplate1_old.cfm">
		<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate1_old.cfm">	
		</cfif>
	<cfelseif month gte 8>
		<cfif URL.audittype2 is "Program">
		<cfinclude template="QSwProgTemplate1.cfm">
		<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate1.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif URL.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate1.cfm">
	<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate1.cfm">
	</cfif>
</cfif>
</cfif>

"Attachment A" File (PDF or ZIP format only):<br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" DisplayName="Attachment A"><br><br>

<INPUT TYPE="button" value="Send Scope Letter" onClick=" javascript:check(document.Audit.e_AttachA);"> 

</form>	
</cfoutput>
		  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->