<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="Type"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditType, ID,YEAR_ as "Year"
 FROM AuditSchedule
 WHERE ID = #URL.ID#
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif Type.AuditType is "TPTDP">
<CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.Desk,

ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.ExternalLocation,

Scope.Address1, Scope.Address2, Scope.Address3, Scope.Address4, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.FileNo, Scope.Cost, Scope.AuditorEmail, Scope.CC
 FROM AuditSchedule, ExternalLocation, Scope
 WHERE AuditSchedule.ID = #URL.ID#
 AND  AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  Scope.ID = #URL.ID#
 AND  Scope.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfelseif Type.AuditType is "Quality System">

<CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, Scope.Title, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.StartTime, Scope.CC, auditschedule.desk
 FROM AuditSchedule, Scope
 WHERE AuditSchedule.YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
 AND  AuditSchedule.ID = #URL.ID#
 AND  Scope.ID = #URL.ID#
 AND  Scope.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Scope View">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>
	
<cfoutput query="Scope">
<cfif AuditType is "TPTDP">
	<cfif year lt 2007>
	<cfinclude template="scopetemplateTP4_old.cfm">
	<cfelseif year gte 2007>
	<cfinclude template="scopetemplateTP4.cfm">
	</cfif>
<cfelse>
<cfif audittype2 is "Field Services">
	<cfif year lt 2006>
	<cfinclude template="FSTemplate4_old.cfm">
	<cfelseif year is 2006>
		<cfif month lte 8>
		<cfinclude template="FSTemplate4_old.cfm">
		<cfelseif month gte 9>
		<cfinclude template="FSTemplate4.cfm">
		</cfif>
	<cfelseif year gte 2007>
	<cfinclude template="FSTemplate4.cfm">	
	</cfif>
<cfelse>
<cfif year lt 2006>
	<cfif audittype2 is "Program">
	<cfinclude template="QSwProgTemplate4_old.cfm">
	<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate4_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4_old.cfm">
		<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4_old.cfm">	
		</cfif>
	<cfelseif month gte 8>
		<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4.cfm">
		<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif audittype2 is "Program">
	<cfinclude template="QSwProgTemplate4.cfm">
	<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
	<cfinclude template="QSTemplate4.cfm">
	</cfif>
</cfif>
</cfif>
</cfif>
"Attachment A" File: <a href="../ScopeLetters/#AttachA#">#AttachA#</a><br>
</cfoutput>	
	  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->