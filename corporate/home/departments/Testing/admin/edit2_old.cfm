<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFQUERY BLOCKFACTOR="100" NAME="ScheduleEdit" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Query" Datasource="Corporate">
UPDATE AuditSchedule

SET 

<cfif link is NOT "http://#CGI.Server_Name##curdir#edit.cfm?ID=#ScheduleEdit.ID#&Year=#ScheduleEdit.Year#&AuditedBy=#ScheduleEdit.AuditedBy#">
	<cfif Form.StartDate is "">
	<cfelse>
	StartDate='#FORM.StartDate#',
	</cfif>
	<cfif Form.EndDate is "">
	<cfelse>
	EndDate='#FORM.EndDate#',
	</cfif>
<cfelse>
</cfif>

<cfif form.audittype is NOT "TPTDP">
<cfif form.RD is "NoChanges">
<cfelse>
RD='#FORM.RD#',
</cfif>
<cfif form.KP is "NoChanges">
<cfelse>
KP='#FORM.KP#',
</cfif>
</cfif>

<cfif FORM.AuditType is "NoChanges">
<cfelse>
AuditType='#FORM.AuditType#',
</cfif>
Notes='#FORM.Notes#',
Month='#FORM.Month#'

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="ScheduleEdit" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfif SESSION.Auth.AccessLevel is "RQM">

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE Status = 'Active'
	AND SubRegion = '#SESSION.Auth.SubRegion#'
	AND QUALIFIED LIKE <cfif Form.AuditType is "NoChanges">'%#scheduleedit.audittype#%'<cfelse>'%#Form.AuditType#%'</cfif>
	ORDER BY LastName
	</cfquery>

<cfelseif SESSION.Auth.AccessLevel is "SU" or SESSION.Auth.AccessLevel is "Admin">

<cfif ScheduleEdit.AuditedBy is "IQA">

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT Auditor, Status FROM AuditorList
	WHERE Status = 'Active'
	AND QUALIFIED LIKE <cfif Form.AuditType is "NoChanges">'%#scheduleedit.audittype#%'<cfelse>'%#Form.AuditType#%'</cfif>
	ORDER BY LastName
	</cfquery>
	
<cfelse>

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT Auditor, Status FROM AuditorList
	WHERE Status = 'Active'
	AND SubRegion = '#ScheduleEdit.AuditedBy#'
	AND QUALIFIED LIKE <cfif Form.AuditType is "NoChanges">'%#scheduleedit.audittype#%'<cfelse>'%#Form.AuditType#%'</cfif>
	ORDER BY LastName
	</cfquery>
	
</cfif>	
	
<cfelseif SESSION.Auth.AccessLevel is "Europe" or SESSION.Auth.AccessLevel is "Asia Pacific">

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT Auditor, Status FROM AuditorList
	WHERE Status = 'Active'
	AND SubRegion = '#ScheduleEdit.AuditedBy#'
	AND QUALIFIED LIKE <cfif Form.AuditType is "NoChanges">'%#scheduleedit.audittype#%'<cfelse>'%#Form.AuditType#%'</cfif>
	ORDER BY LastName
	</cfquery>	
	
<cfelseif SESSION.Auth.AccessLevel is "OQM">

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE Status = 'Active'
	AND Location = '#SESSION.Auth.Office#'
	AND QUALIFIED LIKE <cfif Form.AuditType is "NoChanges">'%#scheduleedit.audittype#%'<cfelse>'%#Form.AuditType#%'</cfif>
	ORDER BY LastName
	</cfquery>	

</cfif>
</cflock>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		

<script language="JavaScript">
function validateForm()
{
	// check name
 
	 if (document.Audit.OfficeName.value !== '- None -' & document.Audit.AuditArea.value == "") {
          alert("Please provide an Audit Area for this internal audit.");
          return false;
     }	 
	 
	 if (document.Audit.ExternalLocation.value !== '- None -' & document.Audit.AuditArea.value !== "") {
          alert("Please do not type an Audit Area for a Third Party Audit.");
          return false;
     }	
	 
	return true;
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
                              Audit Details</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

<cfoutput query="ScheduleEdit">

<p>Note: To change the dates of the audit, or the month it is scheduled for, please use <a href="reschedule.cfm?ID=#ID#&Year=#Year#">this form</a>.</p><br>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="update.cfm?ID=#ID#&Year=#Year#" onSubmit="return validateForm();">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">
<INPUT TYPE="Hidden" NAME="Month" VALUE="#Month#">
<INPUT TYPE="Hidden" Name="AuditType" Value="#AuditType#">

<cfif form.audittype is "TPTDP">
<cfelse>
Area(s) to be Audited: (required for all internal audits)<br>
<INPUT TYPE="Text" NAME="AuditArea" size="75" VALUE="#AuditArea#"><br><br>

Primary Contact (external email addresses)<br>
- Audit notification will be sent to this person or persons (commas between the addresses)<br>
<INPUT TYPE="Text" NAME="Email" size="75" VALUE="#Email#"><br><br>
</cfif>
</cfoutput>

Lead Auditor: (required)<br>
<SELECT NAME="LeadAuditor">
		<OPTION value="NoChanges" SELECTED>No Changes
		<OPTION value="- None -">- None -
<CFOUTPUT QUERY="Auditor">
		<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT>
<br><br>

Auditor:<br>
<SELECT NAME="Auditor" multiple="multiple">
		<OPTION value="NoChanges" SELECTED>No Changes
	<OPTION VALUE="- None -">- None -
<CFOUTPUT QUERY="Auditor">
		<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="ScheduleEdit">
Scope:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="Scope" Value="#Scope#">#Scope#</textarea><br><br>

<INPUT TYPE="Submit" value="Save and Continue">

</FORM>

</cfoutput>
			  
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->