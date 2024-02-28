<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View1">
SELECT Sum(
<cfloop index=i from=1 to=34>
Count#i# +
</cfloop>
CountOther) as sumFindings, 

Sum(
<cfloop index=i from=1 to=34>
OCount#i# +
</cfloop>
OCountOther) as sumObservations,

AuditSchedule.LeadAuditor

FROM REPORT, auditSchedule

WHERE Report.ID = AuditSchedule.ID
AND Report.Year_ = AuditSchedule.Year_
AND AuditSchedule.Year_ = #URL.Year#
AND Auditschedule.AuditedBy = 'IQA'
GROUP BY LeadAuditor
ORDER BY LeadAuditor
</cfquery>

<cfoutput Query="View1">
#LeadAuditor#<Br>
Findings - #sumFindings#<br>
Observations - #sumObservations#<br><br>
</cfoutput>