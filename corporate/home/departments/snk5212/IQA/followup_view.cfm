<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="FollowUp">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.Month,

ExternalLocation.ExternalLocation, ExternalLocation.Cert, ExternalLocation.Billable,

followup.Address1, followup.Address2, followup.Address3, followup.Address4, followup.Name, followup.ContactEmail, followup.Auditor, followup.Phone, followup.DateSent, followup.FileNumber, followup.AuditorEmail, followup.CC, followup.CAPName, followup.CAPEmail, followup.CAPLocation, followup.Type
 FROM AuditSchedule, ExternalLocation, FollowUP
 WHERE AuditSchedule.Year_= <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
 AND  AuditSchedule.ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
 AND  followup.ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
 AND  followup.Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Follow Up Letter View">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<cfoutput query="FollowUp">
	<cfinclude template="followup_template4.cfm">
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->