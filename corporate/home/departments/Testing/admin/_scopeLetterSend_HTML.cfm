<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Scope Letter HTML Test">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Scope">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, 
AuditSchedule.Auditor As Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, 
AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, 
AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, 
AuditSchedule.SiteContact, Scope.Title, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.CC, auditschedule.desk

FROM AuditSchedule, Scope

WHERE AuditSchedule.YEAR_ = 2017
AND AuditSchedule.ID = 149
AND Scope.ID = 149
AND Scope.Year_ = 2017
</CFQUERY>

<cfmail
	to="Christopher.J.Nicastro@ul.com"
	from="Christopher.J.Nicastro@ul.com"
	cc="Christopher.J.Nicastro@ul.com"
	bcc="Christopher.J.Nicastro@ul.com"
	mimeattach="#IQARootPath#ScopeLetters\#AttachA#"
	subject="Quality System Audit of #Area#"
	query="Scope"
	type="html">

	<cfinclude template="#IQARootDir#IQAScope3_HTML.cfm">

Attached File: #AttachA#
</cfmail>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->