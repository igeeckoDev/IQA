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

<cfif AuditType is "TPTDP">

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TP_ScopeLetter_Confirm.cfm?ID=#ID#&Year=#Year#&AuditType=#AuditType#">

<input type="hidden" name="Name" Value="#Form.e_Name#">
<input type="hidden" name="ContactEmail" Value="#Form.e_ContactEmail#">
<input type="hidden" name="Address1" Value="#Form.e_Address1#">
<input type="hidden" name="Address2" Value="#Form.Address2#">
<input type="hidden" name="Address3" Value="#Form.Address3#">
<input type="hidden" name="Address4" Value="#Form.Address4#">
<input type="hidden" name="FileNo" Value="#Form.e_FileNo#">
<input type="hidden" name="StartDate" Value="#Form.e_StartDate#">
<input type="hidden" name="EndDate" Value="#Form.EndDate#">
<cfif SelectAudit.Billable is "Yes">
<input type="hidden" name="Cost" Value="#Form.e_Cost#">
</cfif>
<input type="hidden" name="Phone" Value="#Form.e_Phone#">
<input type="hidden" name="AuditorEmail" Value="#Form.e_AuditorEmail#">
<input type="hidden" name="cc" Value="#Form.cc#">

	<cfif year lt 2007>
	<cfinclude template="scopetemplateTP1_old.cfm">
	<cfelseif year gte 2007>
	<cfinclude template="scopetemplateTP1.cfm">
	</cfif>

"Attachment A" File (PDF or ZIP format only):<br>
<INPUT NAME="e_AttachA" SIZE="70" TYPE="FILE" displayname="Attachment A"><br><br>

<INPUT TYPE="button" value="Send Scope Letter" onClick=" javascript:check(document.Audit.e_AttachA);"> 
</form>

</cfif>

</cfoutput>
		  
 <br>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->