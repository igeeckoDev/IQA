<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate"> 
SELECT AuditSchedule.ID, "AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.Approved, AuditSchedule.LeadAuditor, AuditSchedule.ReportDate, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Month, AuditSchedule.CompletionNotes, auditSchedule.AuditType2, AuditSchedule.Desk, AuditSchedule.LeadAuditor, 

AuditorList.Email, AuditorList.Auditor

FROM AuditSchedule, AuditorList

WHERE
AuditorList.Auditor = AuditSchedule.LeadAuditor
AND (AuditSchedule.Year_ BETWEEN 2008 AND 2012)
AND AuditSchedule.Approved = 'Yes'
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL 
AND AuditSchedule.ReportDate IS NOT NULL
AND AuditSchedule.AuditType2 <> 'Global Function/Process'
AND (AuditSchedule.RescheduleNextYear = 'No' OR AuditSchedule.RescheduleNextyear IS NULL)
AND (AuditSchedule.StartDate IS NOT NULL AND AuditSchedule.EndDate IS NOT NULL)

ORDER BY
AuditSchedule.Year_, AuditSchedule.Month
</cfquery>

<cfset k = 1>
<cfset inSpec = 0>
<cfset outSpec = 0>

<table border=1>
<cfoutput query="Check">
<cfset End = DateFormat(EndDate, 'mm/dd/yyyy')>
<cfset ReportD = DateFormat(ReportDate, 'mm/dd/yyyy')>

<cfif ReportD is NOT "">
    <cfset variables.date1 = "#End#">
    <cfset variables.date2 = "#ReportD#">
    
    <!---Setting up our total working days counter.--->
    <cfset variables.totalWorkingDays = -1>

    <!---Looping over our "Date Range" an incrementing our counter where the day is not Sunday or Saturday.--->
    <cfloop from="#variables.date1#" to="#variables.date2#" index="i">
       <cfif dayOfWeek(i) NEQ 1 AND dayOfWeek(i) NEQ 7>
          <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
       </cfif>
    </cfloop>

<tr>
	<td>#k#</td>
    <td>
    	<cfif variables.totalWorkingDays lt 0>
        	0
        <cfelse>
        	#variables.totalWorkingDays#
        </cfif>
        
        <cfif variables.totalWorkingDays lt 5>
        	<cfset inSpec = inSpec + 1>
        <cfelse>
        	<cfset outSpec = outSpec + 1>
        </cfif>
    </td>
	<td>#year#</td>
    <td>#AuditType2#</td>
    <!---
    <td>#leadauditor#</td>
    <td>#year#</td>
    <td>End=#variables.date1#</td>
    <td>Report=#variables.date2#</td>
	<td>#AuditType2#</td>
    --->
</tr>
<cfset k = k+1>
</cfif>
</cfoutput>
</table>

<cfoutput>spec = #inSpec# / out of spec = #outSpec#</cfoutput>