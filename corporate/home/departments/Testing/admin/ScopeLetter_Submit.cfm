<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Send Scope Letter - Confirm and Upload Attachment A">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Datasource="Corporate" Name="SelectAudit">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate,
AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.AuditorInTraining, AuditSchedule.Area,
AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan,
AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved,
AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email as Contact,
AuditSchedule.Email2 as Contact2, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact,
AuditSchedule.ScopeLetterDate, AuditSchedule.SME,

AuditorList.Auditor, AuditorList.Phone, AuditorList.Email, auditschedule.Desk

FROM AuditSchedule, AuditorList

WHERE AuditSchedule.YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.LeadAuditor = AuditorList.Auditor
</CFQUERY>

<Cfset AuditorCCEmails = "">

<!--- add auditor field emails --->
<cfif len(SelectAudit.Aud)>
    <cfloop index = "ListElement" list = "#SelectAudit.Aud#">
        <Cfoutput>
            <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
            SELECT Email
            FROM AuditorList
            WHERE Auditor = '#trim(ListElement)#'
            </CFQUERY>

            <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
        </cfoutput>
    </cfloop>
</cfif>

<!--- add auditor in training field emails --->
<cfif len(SelectAudit.AuditorInTraining)>
    <cfloop index = "ListElement" list = "#SelectAudit.AuditorInTraining#">
        <Cfoutput>
            <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
            SELECT Email
            FROM AuditorList
            WHERE Auditor = '#trim(ListElement)#'
            </CFQUERY>

            <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
        </cfoutput>
    </cfloop>
</cfif>
<!--- /// --->

<script language="JavaScript">
function check() {
  var ext = document.Audit.e_AttachA.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.e_AttachA.value.length!=0) || (document.Audit.e_AttachA.value!=null)) {
	 if(ext != 'pdf') {
      if(ext != 'doc') {
	   if(ext != 'zip') {
	    if(ext != 'xls') {
		 if(ext != 'ocx') {
    alert('You selected a .'+ext+' file; please select a doc, xls, pdf, or zip file.');
    return false;
	  }
	  }
	  }
	  }
	 }
	}
else
return true;
document.Audit.submit();
}
</script>

<b>Need to Edit?</b> Click 'back' on your browser's navigation bar.<br><br>
If you wish to submit, press 'Submit Scope Letter' below. Adding Attachment A is required.<br><br>

<hr>

<cfoutput query="SelectAudit" maxRows="1">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<cfset ccList = "">
<cfif len(Form.CC)>
	<cfset ccList = listAppend(ccList, "#Form.CC#")>
</cfif>
<cfif len(AuditorCCEmails)>
	<cfset ccList = listAppend(ccList, "#AuditorCCEmails#")>
</cfif>
<cfif len(SME)>
	<cfset ccList = listAppend(ccList, "#SME#")>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="ScopeLetter_Confirm.cfm?ID=#ID#&Year=#Year#&AuditType=#AuditType#">
<input type="hidden" name="Name" Value="#Form.Name#" DisplayName="Contact Name">
<input type="hidden" name="Title" Value="#Form.Title#" DisplayName="Contact Title">
<input type="hidden" name="ContactEmail" Value="#Form.ContactEmail#" DisplayName="Contact Email">
<input type="hidden" name="Phone" Value="#Form.Phone#" DisplayName="Auditor Phone">
<input type="hidden" name="StartDate" Value="#Form.StartDate#" DisplayName="Start Date">
<input type="hidden" name="EndDate" Value="#Form.EndDate#">
<cfif URL.AuditType2 is "Field Services">
	<input type="hidden" name="StartTime" Value="#Form.StartTime#" DisplayName="Start Time">
</cfif>
<input type="hidden" name="AuditorEmail" Value="#Form.AuditorEmail#" DisplayName="Lead Auditor Email">
<input type="hidden" name="cc" Value="#ccList#">
<input type="hidden" name="AuditType2" Value="#AuditType2#">

<cfif year gte 2008>
<!--- New Scope 4/17/2009 to include MMS --->
	<cfinclude template="#IQARootDir#IQAScope1.cfm">
<!--- End of New Scope for 2008+ --->
<cfelse>
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
	<cfif url.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate1_old.cfm">
	<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate1_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif url.audittype2 is "Program">
		<cfinclude template="QSwProgTemplate1_old.cfm">
		<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate1_old.cfm">
		</cfif>
	<cfelseif month gte 8>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate1.cfm">
		<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate1.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif url.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate1.cfm">
	<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate1.cfm">
	</cfif>
</cfif>
</cfif>
</cfif>

"Attachment A" File (PDF or ZIP format only):<br>
<INPUT NAME="e_AttachA" SIZE=50 TYPE="FILE" DisplayName="Attachment A"><br><br>

<INPUT TYPE="button" value="Send Scope Letter" onClick=" javascript:check(document.Audit.e_AttachA);">

</form>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->