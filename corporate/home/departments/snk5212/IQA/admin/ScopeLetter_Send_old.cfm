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

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Enter Audit Scope">
<cfinclude template="SOP.cfm">

<!--- / --->

<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="date.js"></script>
				  
<cfif SelectAudit.recordcount is 0>
<cfoutput>		
<br>
There are no Auditors Selected for this audit.<br>
Please <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">go back</a> and select auditors before sending a scope letter.
</cfoutput>
<cfelse>
 
<cfoutput query="SelectAudit">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>			  

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="ScopeLetter_Submit.cfm?ID=#ID#&Year=#Year#&AuditType2=#AuditType2#">

<cfif url.audittype2 is "Field Services">
	<cfif year lt 2006>
	<cfinclude template="FSTemplate2_old.cfm">
	<cfelseif year is 2006>
		<cfif month lte 8>
		<cfinclude template="FSTemplate2_old.cfm">
		<cfelseif month gte 9>
		<cfinclude template="FSTemplate2.cfm">
		</cfif>
	<cfelseif year gte 2007>
	<cfinclude template="FSTemplate2.cfm">	
	</cfif>
<cfelse>
<cfif year lt 2006>
	<cfif URL.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate2_old.cfm">
	<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate2_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif URL.audittype2 is "Program">
		<cfinclude template="QSwProgTemplate2_old.cfm">
		<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate2_old.cfm">	
		</cfif>
	<cfelseif month gte 8>
		<cfif URL.audittype2 is "Program">
		<cfinclude template="QSwProgTemplate2.cfm">
		<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate2.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif URL.audittype2 is "Program">
	<cfinclude template="QSwProgTemplate2.cfm">
	<cfelseif URL.audittype2 is "Corporate" or URL.audittype2 is "Local Function" or URL.audittype2 is "Local Function FS" or URL.audittype2 is "Local Function CBTL" or URL.audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate2.cfm">
	</cfif>
</cfif>
</cfif>

<br><br>

Contact Name<br>
<input name="e_Name" Type="Text" Value="" displayname="Contact Name"><br><br>
Title<br>
<input name="e_Title" Type="Text" Value="" displayname="Title"><br><br>
Email<br>
<input name="e_ContactEmail" Type="Text" Value="#Contact#" displayname="Contact Email"><br><br>

Office<br>
#OfficeName#<br><br>
Audit Area<br>
#AuditArea#<br><br>

<cfif URL.AuditType2 is "Field Services">
<b>Start Time</b><br>
<input name="e_StartTime" Type="Text" Value="" displayname="Start Time"><br><br>
</cfif>

Start Date<br>
<input name="e_StartDate" Type="Text" Value="#DateFormat(StartDate, 'mm/dd/yyyy')#" displayname="Start Date" onchange="return ValidateESDate()"><br><br>
End Date<br>
<input name="EndDate" Type="Text" Value="#DateFormat(EndDate, 'mm/dd/yyyy')#" onchange="return ValidateEDate()"><br><br>

Lead Auditor<br>
#LeadAuditor#<br><br>

<cfif Auditor is "" or Auditor is "- None -">
<cfelse>
Auditor(s)<br>
#Auditor#<br><br>
</cfif>

Auditor Email<br>
<input name="e_AuditorEmail" Type="Text" size="60" Value="#Email#" displayname="Auditor Email"><br><br>
Additional Recipients of Scope Letter (cc)<br>
<input name="cc" Type="Text" size="60" Value=""><br><br>
Phone<br>
<input name="e_Phone" Type="Text" Value="#Phone#" displayname="Auditor Phone"><br><br>

<INPUT TYPE="button" value="Submit Scope Letter" onClick=" javascript:checkFormValues(document.all('Audit'));">
</form>

</cfoutput>		  
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->