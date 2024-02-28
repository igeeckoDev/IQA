<cfoutput>
#DateFormat(DateSent, 'mmmm dd, yyyy')#

#Name# (Sent to: #ContactEmail#)
#ExternalLocation#
#Address1#
#Address2#
#Address3#
#Address4#

Our Reference: File Number #FileNo#

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program 

Dear #Name#,

This letter will confirm the planned <cfif desk is "Yes">desk audit of<cfelse>visit to</cfif> #ExternalLocation# for an assessment of general laboratory operations. This is required under UL's Data Acceptance Program and is scheduled for #DateFormat(StartDate, 'mmmm dd, yyyy')# and will be conducted by #LeadAuditor#.

This assessment is to verify continued compliance to ISO/IEC Standard 17025, General Requirements for the Competence of Testing and Calibration Laboratories. It is anticipated that the audit will commence on #DateFormat(StartDate, 'mmmm dd, yyyy')# and be completed by #DateFormat(EndDate, 'mmmm dd, yyyy')# with a report provided to you containing the assessments results. <cfif desk is "Yes">During the course of this assessment you may be contacted with questions or further clarification.</cfif>

<cfif desk is "Yes">In preparation for this audit, please provide information on any key changes in your operations since last year's general assessment of laboratory operations, such as changes in your test facilities, personnel, and testing capability.  In addition, please provide us with your most current quality manual, documentation relating to any nonconformances identified in last year's assessment, and most recent internal audit and management review reports.  This information and documentation is requested at your earliest convenience but no later than #DateFormat(StartDate, 'mmmm dd, yyyy')#.</cfif>The specific scope is detailed in Attachment A.

<cfif Billable is "Yes">
A Project with a cost limit of #Cost# has been established to cover the time associated with the assessment. <cfif Desk is "No">Travel and living expenses incurred will be billed outside of the cost limit.</cfif>
</cfif>

If you have any questions concerning this assessment, please let us know.

#LeadAuditor#
Underwriters Laboratories, Inc.
Email: #AuditorEmail#
Phone: #Phone#

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>