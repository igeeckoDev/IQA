<cfquery Datasource="Corporate" name="Audits">
SELECT *
FROM AuditSchedule
WHERE Approved = 'Yes'
AND  AuditedBY = 'IQA'
AND (AuditSchedule.Status IS Null OR AuditSchedule.Status = 'Deleted')
<!--- AND  (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No') --->
AND  Year_ = <cfqueryparam value="#url.year#" cfsqltype="cf_sql_integer">
ORDER BY Month, ID
</cfquery>

<cfquery Datasource="Corporate" name="Auditors">
SELECT *
FROM AuditorList
WHERE IQA = 'Yes'
AND Status <> 'Inactive'
ORDER BY Status, Auditor
</cfquery>

<table border="1">
<tr>
    <th>Audit Number</th>
    <th>Audit Type/Location/Area</th>
    <th>Month</th>
    <cfoutput query="Auditors">
        <th>#Auditor#</th>
    </cfoutput>
</tr>
<cfoutput query="Audits">
<tr valign="top">
<td>#Year_#-#ID#</td>
<td>
<u>Audit Type</u>: #AuditType2#<br>
<u>Office Name</u>: #OfficeName#<br />
<u>Area</u>: #Area#
</td>
<td>#MonthAsString(Month)#</td>
	<cfloop query="Auditors">
    	<td align="center">
            <cfquery Datasource="Corporate" name="isPartOfAudit">
            SELECT COUNT(*) as Count
            From AuditSchedule
            WHERE (LeadAuditor = '#Auditor#'
            OR Auditor LIKE '%#Auditor#%'
            OR AuditorInTraining LIKE '%#Auditor#%')
            AND Year_ = #Audits.Year_#
            AND ID = #Audits.ID#
            </cfquery>

            <cfif isPartOfAudit.Count gt 0>
            	X

            <cfelse>
            	--
        	</cfif>
		</td>
    </cfloop>
</tr>
</cfoutput>
</table>