<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="emailCheck"> 
SELECT ID, Year_, Email, AuditedBy, LeadAuditor, Area, OfficeName, AuditType2
FROM AuditSchedule
WHERE Email IS NOT NULL
AND Email LIKE '%,%'
AND Status IS NULL
AND (RescheduleNextYear IS NULL OR RescheduleNextyear = 'No')
AND Year_ > 2010
AND AuditedBy = 'IQA'
ORDER BY LeadAuditor, Year_, ID
</CFQUERY>

<Table border="1">
<tr>
<th>Audit</th>
<th>Lead Auditor</th>
<th>Audit Details</th>
<th>Primary Contact</th>
</tr>
<cfoutput query="emailCheck">
<tr valign="top">
<td>#Year_#-#ID#-#AuditedBy#</td>
<td>#LeadAuditor#</td>
<td>#AuditType2#<br>#OfficeName#<br>#Area#</td>
<td>#trim(replace(Email, ",", "<br>", "All"))#</td>
</tr>
</cfoutput>
</Table>