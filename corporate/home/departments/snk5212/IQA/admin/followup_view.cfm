<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="FollowUp"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.Month, 

ExternalLocation.ExternalLocation, ExternalLocation.Cert, ExternalLocation.Billable,

followup.Address1, followup.Address2, followup.Address3, followup.Address4, followup.Name, followup.ContactEmail, followup.Auditor, followup.Phone, followup.DateSent, followup.FileNumber, followup.AuditorEmail, followup.CC, followup.CAPName, followup.CAPEmail, followup.CAPLocation, followup.Type, followup.projectnumber
 FROM AuditSchedule, ExternalLocation, FollowUP
 WHERE AuditSchedule.ID = #URL.ID#
 AND  AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  followup.ID = #URL.ID#
 AND  followup.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
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