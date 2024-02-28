<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.LeadAuditor, AuditSchedule.ScopeLetterDate, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Month, AuditSchedule.ScopeLetter, AuditSchedule.CompletionNotes, auditSchedule.AuditType2,

AuditorList.Email, AuditorList.Auditor,

Baseline.Baseline, Baseline.Year_

FROM AuditSchedule, AuditorList, Baseline

WHERE AuditorList.Auditor = AuditSchedule.LeadAuditor
AND AuditSchedule.Year_ >= #curyear#
AND AuditSchedule.Year_ = Baseline.Year_
AND Baseline.Baseline = 1
AND AuditSchedule.Approved = 'Yes'
AND AuditSchedule.CompletionNotes IS NULL
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.ScopeLetterDate IS NULL
AND AuditSchedule.StartDate IS NOT NULL
AND AuditSchedule.Status IS NULL
AND (AuditSchedule.RescheduleNextYear = 'No' OR AuditSchedule.RescheduleNextyear IS NULL)
AND AuditorList.Region ='Corporate'
</cfquery>

 <!--- Late Scopes --->
<cfoutput query="Check">
<cfset Start = DateFormat(StartDate, 'mm/dd/yyyy')>
<cfset CD = DateFormat(CurDate, 'mm/dd/yyyy')>
<cfset variables.date1 = "#CD#">
<cfset variables.date2 = "#Start#">

<!--- current date is before the start date --->
<cfif DateCompare(variables.date1, variables.date2, "d") eq -1>
	<!--- measure time between current date and start date --->
	<cfset variables.totalWorkingDays = -1>
    <cfloop from="#variables.date1#" to="#variables.date2#" index="i">
        <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
           <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
        </cfif>
    </cfloop>

    <cfif variables.totalWorkingDays lt 13 AND variables.totalWorkingDays gte 10>
        <cfmail
            to="#Email#"
            bcc="Christopher.J.Nicastro@ul.com"
            from="Internal.Quality_Audits@ul.com"
            subject="Audit Scope Letter Due Soon (#year#-#id#)">
                #year#-#id#-#auditedby#
                Current Date: #CurDate#
                Lead Auditor: #LeadAuditor#
                Audit Start Date: #Start#
                Audit Start Date is in #variables.totalWorkingDays# working days.

                This is a friendly reminder that the scope letter should be sent 10 working days before the Audit Start Date, or Audit Completion Notes should be entered on the IQA site.
        </cfmail>
    </cfif>

	<cfif variables.totalWorkingDays lt 10>
        <cfmail
            to="#Email#"
            cc="Global.InternalQuality@ul.com"
            from="Internal.Quality_Audits@ul.com"
            subject="Audit Scope Letter Overdue (#year#-#id#)">
                #year#-#id#-#auditedby#
                Current Date: #CurDate#
                Lead Auditor: #LeadAuditor#
                Audit Start Date: #Start#
                Audit Start Date is in #variables.totalWorkingDays# working days.

                The scope letter should be sent 10 working days before the Audit Start Date, or Audit Completion Notes should be entered on the IQA site.
        </cfmail>
    </cfif>
<!--- current date IS the start date --->
<cfelseif DateCompare(variables.date1, variables.date2, "d") eq 0>
	<cfset variables.totalWorkingDays = 10>
         <cfmail
            to="#Email#"
            cc="Global.InternalQuality@ul.com"
            from="Internal.Quality_Audits@ul.com"
            subject="Audit Scope Letter Overdue (#year#-#id#)">
                #year#-#id#-#auditedby#
                Current Date: #CurDate#
                Lead Auditor: #LeadAuditor#
                Audit Start Date: #Start#
                Audit Start Date is Today!

                The scope letter should be sent 10 working days before the Audit Start Date, or Audit Completion Notes should be entered on the IQA site.
        </cfmail>
<!--- current date is AFTER the start date --->
<cfelseif DateCompare(variables.date1, variables.date2, "d") eq 1>
	<cfset variables.totalWorkingDays = -1>
    <cfloop from="#variables.date2#" to="#variables.date1#" index="i">
        <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
           <cfset variables.totalWorkingDays = variables.totalWorkingDays - 1>
        </cfif>
    </cfloop>

    <cfif variables.totalWorkingDays lt 10>
        <cfmail
            to="#Email#"
            cc="Global.InternalQuality@ul.com"
            from="Internal.Quality_Audits@ul.com"
            subject="Audit Scope Letter Overdue (#year#-#id#)">
                #year#-#id#-#auditedby#
                Current Date: #CurDate#
                Lead Auditor: #LeadAuditor#
                Audit Start Date: #Start#
                Audit Start Date is #Abs(variables.totalWorkingDays)# working days in the past.

                The scope letter should be sent 10 working days before the Audit Start Date, or Audit Completion Notes should be entered on the IQA site.
        </cfmail>
    </cfif>
</cfif>
</cfoutput>