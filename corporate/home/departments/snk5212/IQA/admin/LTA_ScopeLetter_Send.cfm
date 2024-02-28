<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Confirm/Send Scope Letter">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("URL.Validate") AND len(URL.Validate)>
	<br><font color="red"><b>Validation Error</b> - No Attachment A<br>
	Please add an Attachment A file before submitting the scope for sending.</font>
	<br><br>
	------------
	<br /><Br />
<cfelse>
	<br>
</cfif>

<cfQUERY Datasource="Corporate" Name="Check">
SELECT * FROM Scope
WHERE 
	ID = #URL.ID# 
	AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif check.recordcount GT 0>
	<cfoutput>
    #URL.Year#-#URL.ID# Scope has already been sent.<br><br>
    <a href="LTA_ScopeLetter_View.cfm?year=#url.year#&id=#url.id#">
    View</a> Scope Letter
    </cfoutput>
<cfelse>

<!--- / --->

<!---<script language="JavaScript">		
function check() {
  var ext = document.Audit.e_AttachA.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_AttachA.value.length!=0) || (document.Audit.e_AttachA.value!=null)) {
	 if(ext != 'pdf') {
      if(ext != 'xls') {
	   if(ext != 'zip') {
    alert('You selected a .'+ext+' file; please select a xls, pdf, or zip file!');
    return false; 
	  }
	  }
	 }
	}	
else
return true;
document.Audit.submit();
}
</script>--->

<CFQUERY BLOCKFACTOR="100" name="Details" Datasource="Corporate">
SELECT 
	AuditSchedule.*, AuditSchedule.Year_ as Year, Auditors_LTA.Auditor as AuditorName, Auditors_LTA.Email as AuditorEmail
FROM 
	AuditSchedule, Auditors_LTA
WHERE 
	AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND AuditSchedule.Auditor = Auditors_LTA.Auditor
</CFQUERY>

<cfoutput>
Please review the Scope Letter below. If any changes need to be made to the bolded text, please do so on the <a href="auditdetails.cfm?#CGI.Query_String#">Audit Details</a> page.<br /><Br />

Otherwise, please attach an <u>Attachment A</u> file below the scope and Submit/Send the scope letter.
</cfoutput>
<br /><br />
------------
<br /><Br />

<cfinclude template="LTA_Scope_Send.cfm">

<cfoutput query="Details">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="LTA_ScopeLetter_Submit.cfm?ID=#ID#&Year=#Year#">

"Attachment A" File (PDF or ZIP format only):<br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" DisplayName="Attachment A"><br><br>

<input name="submit" type="submit" value="Send Scope Letter">

<!---
<INPUT TYPE="button" value="Send Scope Letter" onClick=" javascript:check(document.Audit.e_AttachA);"> 
--->

</form>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->