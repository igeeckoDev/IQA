<!--- edited page on 7/24/2014 to fix logic for removing the count on weekends --->

<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT AuditSchedule.ID, "AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.Approved, AuditSchedule.LeadAuditor, AuditSchedule.ReportDate, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Month, AuditSchedule.CompletionNotes, auditSchedule.AuditType2, AuditSchedule.Desk, AuditSchedule.LeadAuditor,

AuditorList.Email, AuditorList.Auditor,

Baseline.Baseline, Baseline.Year_

FROM AuditSchedule, AuditorList, Baseline

WHERE
AuditorList.Auditor = AuditSchedule.LeadAuditor
AND AuditSchedule.Year_ >= #curyear#
AND AuditSchedule.Year_ = Baseline.Year_
AND Baseline.Baseline = 1
AND AuditSchedule.Approved = 'Yes'
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.ReportDate IS NULL
AND AuditSchedule.Month <= #curmonth#
AND (AuditSchedule.RescheduleNextYear = 'No' OR AuditSchedule.RescheduleNextyear IS NULL)
AND AuditSchedule.CompletionNotes IS NULL
AND (AuditSchedule.StartDate IS NOT NULL AND AuditSchedule.EndDate IS NOT NULL)
</cfquery>

<!--- Late Reports --->
<cfoutput query="Check">
<cfset End = DateFormat(EndDate, 'mm/dd/yyyy')>
<cfset CD = DateFormat(CurDate, 'mm/dd/yyyy')>
<cfset variables.date1= "#CD#">
<cfset variables.date2 = "#End#">

<!--- current date is AFTER the End date --->
<cfif DateCompare(variables.date1, variables.date2, "d") eq 1>
	<cfset variables.totalWorkingDays = -1>
    <cfloop from="#variables.date2#" to="#variables.date1#" index="i">
		<!--- excludes saturday and sunday --->
        <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
           <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
        </cfif>
    </cfloop>

	<!--- reminder on the 4th and 5th day --->
	    <cfif variables.totalWorkingDays GT 3 AND variables.totalWorkingDays LT 6>
        <cfmail
            to="#Email#"
            from="Internal.Quality_Audits@ul.com"
            subject="Audit Report Due Soon (#year#-#id#)">
                #year#-#id#-#auditedby#
                Current Date: #CurDate#
                Lead Auditor: #LeadAuditor#
                Audit End Date: #End#
                Audit End Date is #variables.totalWorkingDays# working days in the past.

                This is a friendly reminder that the Audit Report should be filed 5 working days after the Audit End Date, or Audit Completion Notes should be entered on the IQA site.
        </cfmail>
    </cfif>

    <cfif variables.totalWorkingDays GT 5>
        <cfmail
            to="#Email#"
            cc="Kai.huang@ul@ul.com"
            from="Internal.Quality_Audits@ul.com"
            subject="Audit Report Overdue (#year#-#id#)">
                #year#-#id#-#auditedby#
                Current Date: #CurDate#
                Lead Auditor: #LeadAuditor#
                Audit End Date: #End#
                Audit End Date is #variables.totalWorkingDays# working days in the past.

                Report should be filed 5 working days after the Audit End Date, or Audit Completion Notes should be entered on the IQA site.
        </cfmail>
    </cfif>
</cfif>
</cfoutput>