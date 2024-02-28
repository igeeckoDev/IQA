<cfoutput query="Scope">
#dateformat(datesent, "mmmm dd, yyyy")#
#Name#
#ContactEmail#
#OfficeName#

Subject: Laboratory Technical Audit of - #OfficeName# - #AuditArea#

Dear #Name#,

This is to confirm our communications pertaining to the Laboratory Technical Audit of #OfficeName# - #AuditArea# that is scheduled for #dateformat(StartDate, "mmmm dd, yyyy")#. #AuditorName# will conduct this audit, which will begin with an opening session to review the audit scope and coordinate audit activities with you and your staff.

The scope of this assessment is to verify the competence of laboratory staff, to review the availability of test documentation and to determine if the correct equipment and environmental conditions are utilized.

The assessments will be conducted using ISO /IEC 17025:2005, Section 4.13.2 Technical Records, Section 5 Technical Requirements, and related UL internal policies and procedures listed in the Attachment A File.

Also included in Attachment A is a list of the standards and tests that will be assessed during the audit. The list was selected from the information contained in the Scope of Capability. Please prepare testing samples and other resources in advance.

Any Noncompliance and Preventive actions noted during the audit will be discussed with you during a closing session on #dateformat(EndDate, "mmmm dd, yyyy")#.

If you have any questions concerning the audit, please contact the auditor, Todd Corriveau or Bruce Proper for more information. Otherwise, we look forward to working with you and your staff during our visit.

Regards,
Global Test and Laboratory Compliance

cc: #AuditorEmail#<cfif len(cc)>, #cc#</cfif>
</cfoutput>