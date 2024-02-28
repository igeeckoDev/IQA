<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT ID, Year_, Status, OfficeName, AuditType2, Area, AuditArea
FROM AuditSchedule
WHERE Year_ BETWEEN 2012 and 2013
AND AuditedBy = 'IQA'
AND Status IS NULL
ORDER BY AuditType2, OfficeName, AuditArea, Area, Year_
</CFQUERY>

<cfdump var="#Check#">