<cfquery name="audits" datasource="corporate">
select ID, Year_, OfficeName, Area, AuditArea, AuditType2, LeadAuditor, Month from AuditSchedule where AuditedBy = 'IQA' AND Status IS NULL AND Year_ >= 2010 ORDER BY Area, AuditArea, OfficeName, Year_ 
</cfquery>

<cfdump var="#audits#">