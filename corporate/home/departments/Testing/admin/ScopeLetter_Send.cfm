<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Send Scope Letter">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Datasource="Corporate" Name="SelectAudit">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate,
AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType,
AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status,
AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes,
AuditSchedule.Month, AuditSchedule.Email as Contact, AuditSchedule.Email2 as Contact2, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda,
AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.ScopeLetterDate, AuditSchedule.SME,

AuditorList.Auditor, AuditorList.Phone, AuditorList.Email, auditschedule.Desk

FROM AuditSchedule, AuditorList

WHERE AuditSchedule.YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.LeadAuditor = AuditorList.Auditor
</CFQUERY>

<!---
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
--->

<cfif SelectAudit.recordcount is 0>
<cfoutput>
<br>
There are no Auditors Selected for this audit.<br>
Please <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">go back</a> and select auditors before sending a scope letter.
</cfoutput>
<cfelse>

<cfoutput query="SelectAudit" maxrows="1">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="ScopeLetter_Submit.cfm?ID=#ID#&Year=#Year#&AuditType2=#AuditType2#">

<cfif year gte 2008>
<!--- New Scope 4/17/2009 to include MMS --->
	<cfinclude template="#IQARootDIR#IQAScope2.cfm">
<!--- End of New Scope for 2008+ --->
<cfelse>
<cfif url.audittype2 is "Field Services">
	<cfif year lt 2006>
	<cfinclude template="FStemplate2_old.cfm">
	<cfelseif year is 2006>
		<cfif month lte 8>
		<cfinclude template="FStemplate2_old.cfm">
		<cfelseif month gte 9>
		<cfinclude template="FStemplate2.cfm">
		</cfif>
	<cfelseif year gte 2007>
	<cfinclude template="FStemplate2.cfm">
	</cfif>
<cfelse>
<cfif year lt 2006>
	<cfif url.audittype2 is "Program">
	<cfinclude template="QSwProgtemplate2_old.cfm">
	<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
	<cfinclude template="QStemplate2_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif url.audittype2 is "Program">
		<cfinclude template="QSwProgtemplate2_old.cfm">
		<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
		<cfinclude template="QStemplate2_old.cfm">
		</cfif>
	<cfelseif month gte 8>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgtemplate2.cfm">
		<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
		<cfinclude template="QStemplate2.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif url.audittype2 is "Program">
	<cfinclude template="QSwProgtemplate2.cfm">
	<cfelseif url.audittype2 is "Corporate" or url.audittype2 is "Local Function" or url.audittype2 is "Local Function FS" or url.audittype2 is "Local Function CBTL" or url.audittype2 is "Global Function/Process">
	<cfinclude template="QStemplate2.cfm">
	</cfif>
</cfif>
</cfif>
</cfif>

<br><br>

Primary Contact Name<br>
<cfinput name="Name" size="50" Type="Text" Value="" displayname="Contact Name" required="Yes"><br><br>

Title of Primary Contact<br>
<cfinput name="Title" size="65" Type="Text" Value="" displayname="Title" required="yes"><br><br>

Primary Contact / 'To' Field Email Address (edit on Audit Details page)<br>
#Contact#<br><br>
<cfinput name="ContactEmail" size="50" Type="hidden" Value="#Contact#" required="yes">

Office<br>
#OfficeName#<br><br>
Audit Area<br>
#AuditArea#<br><br>

<cfif URL.AuditType2 is "Field Services">
<b>Start Time</b><br>
<cfinput name="StartTime" Type="Text" Value="" displayname="Start Time" required="true"><br><br>
</cfif>

Start Date<br>
<cfinput name="StartDate" Type="Text" Value="#DateFormat(StartDate, 'mm/dd/yyyy')#" displayname="Start Date" onchange="return ValidateESDate()" validate="date"><br><br>
End Date<br>
<cfinput name="EndDate" Type="Text" Value="#DateFormat(EndDate, 'mm/dd/yyyy')#" onchange="return ValidateEDate()" validate="date"><br><br>

Lead Auditor<br>
#LeadAuditor#<br><br>

<cfif Aud is "" or Aud is "- None -">
<cfelse>
Auditor(s)<br>
#Aud#<br><br>
</cfif>

Auditor Email<br>
<cfinput name="AuditorEmail" Type="Text" size="60" Value="#Email#" displayname="Auditor Email" required="yes"><br><br>

Additional Recipients of Scope Letter (cc)<br>
<cfloop list="#Contact2#" index="ListElement">
	#ListElement#<br />
</cfloop>
Auditor(s), Auditor(s) In Training, Subject Matter Expert(s)<br /><br />

<cfinput name="cc" Type="Hidden" Value="#Contact2#" required="yes">
<u>Note</u> - Please use "Other Contacts" on the Audit Details page to add/edit cc contacts<br><br>

Phone<br>
<cfinput name="Phone" Type="Text" Value="#Phone#" displayname="Auditor Phone" required="yes"><br><br>

<b>Confirmation of Reporting the Accreditor and Regulatory Requirements in the Audit Documentation</b><br>
Please confirm that all applicable accreditor and regulatory requirements have been documented in the audit agenda. The pathnotes, audit report, and audit coverage table shall also reflect these requirements when they are completed.<br><br>

Confirm <cfinput type="radio" value="Confirmed" name="Confirmation_Checkbox" required="yes"><br><br>

<!---<INPUT TYPE="button" value="Submit Scope Letter" onClick=" javascript:checkFormValues(document.all('Audit'));">--->
<INPUT TYPE="Submit" name="Submit" Value="Submit Scope Letter">
</cfform>

</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->