<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT StartDate, EndDate, Year_, ID, AuditedBy, AuditType2, LeadAuditor, Auditor, AuditorInTraining, (EndDate-StartDate)+1 as Days
FROM AuditSchedule
WHERE Status IS NULL
AND AuditedBy = 'IQA'
AND Year_ > 2009
AND Startdate IS NOT NULL
AND EndDate IS NOT NULL
ORDER BY Year_
</CFQUERY>

<Table border=1>
<cfoutput query="Check">
<tr>
<td>#Year_#-#ID#</td>
<td>#dateformat(startDate, "mm/dd/yyyy")#</td>
<td>#dateformat(endDate, "mm/dd/yyyy")#</td>
<td>#AuditType2#</td>
<td><cfset TotalStaff = Listlen(LeadAuditor) + Listlen(Auditor) + listlen(AuditorInTraining)>#TotalStaff#</td>
<td><cfset totalDays = (EndDate - startDate) + 1>#totalDays#</td>
</tr>
</cfoutput>
</Table>