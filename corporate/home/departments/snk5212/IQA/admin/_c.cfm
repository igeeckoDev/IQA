<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT AuditSchedule.Year_, AuditSchedule.Id, AuditSchedule.AuditedBy, AuditSchedule.OfficeName, IQAtblOffices.OfficeName
FROM IQAtblOffices
LEFT JOIN AuditSchedule
ON AuditSchedule.OfficeName = IQAtblOffices.OfficeName
WHERE Year_ = 2010
AND AuditedBy = 'IQA'
ORDER BY IQAtblOffices.OfficeName
</cfquery>

<cfdump var="#Office#">