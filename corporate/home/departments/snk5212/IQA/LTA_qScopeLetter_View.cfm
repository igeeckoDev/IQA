<CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Auditor, AuditSchedule.AuditArea, AuditSchedule.Email, AuditSchedule.Email2, Scope.ContactEmail, Scope.Auditor as AuditorName, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.CC, Scope.Name

FROM AuditSchedule, Scope

WHERE AuditSchedule.YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = #URL.ID#
AND Scope.ID = #URL.ID#
AND Scope.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<br />

<cfinclude template="#IQARootDir#LTA_Scope_View.cfm">

<cfoutput query="Scope">
"Attachment A" File: <a href="#IQADir#scopeletters/#AttachA#">#AttachA#</a><br>
</cfoutput>