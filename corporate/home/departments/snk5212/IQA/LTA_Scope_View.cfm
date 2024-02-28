<cfoutput query="Scope">
<b>#dateformat(datesent, "mmmm dd, yyyy")#</b><Br />
<b>#Name#</b><br />
<b>#ContactEmail#</b><br>
<b>#OfficeName#</b><br><br>

Subject: Laboratory Technical Audit of - <b>#OfficeName# - #AuditArea#</b> <br><br>

Dear <b>#Name#</b>,<br><br>

This is to confirm our communications pertaining to the Laboratory Technical Audit of <b>#OfficeName# - #AuditArea#</b> that is scheduled for <b>#dateformat(StartDate, "mmmm dd, yyyy")#</b>. <b>#AuditorName#</b> will conduct this audit, which will begin with an opening session to review the audit scope and coordinate audit activities with you and your staff.<br><br>

The scope of this assessment is to verify the competence of laboratory staff, to review the availability of test documentation and to determine if the correct equipment and environmental conditions are utilized.<br><br>

The assessments will be conducted using ISO /IEC 17025:2005, Section 4.13.2 Technical Records, Section 5 Technical Requirements, and related UL internal policies and procedures listed in the Attachment A File.<br /><br />

Also included in Attachment A is a list of the standards and tests that will be assessed during the audit. The list was selected from the information contained in the Scope of Capability. Please prepare testing samples and other resources in advance.<br /><br />

Any Noncompliance and Preventive actions noted during the audit will be discussed with you during a closing session on <b>#dateformat(EndDate, "mmmm dd, yyyy")#</b>.<br><br>

If you have any questions concerning the audit, please contact the auditor, <a href="mailto:Todd.L.Corriveau@ul.com">Todd Corriveau</a>, or <a href="mailto:Bruce.R.Proper@ul.com">Bruce Proper</a> for more information. Otherwise, we look forward to working with you and your staff during our visit.<Br /><br />

Regards,
Global Test and Laboratory Compliance<br /><br />

cc: <br />
<b>#AuditorEmail#</b><br />
<cfif Len(cc)>
<cfset Dump = #replace(cc, ",", "<br>", "All")#>
<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
<b>#Dump1#</b><br /><Br />
<cfelse>
<br />
</cfif>
</cfoutput>