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

This letter will confirm the planned visit to #ExternalLocation# for an assessment of general laboratory operations. This is required under UL's Data Acceptance Program and is scheduled for #DateFormat(StartDate, 'mmmm dd, yyyy')# and will be conducted by #LeadAuditor#.

The assessment, to verify compliance to ISO/IEC Standard 17025, General Requirements for the Competence of Testing and Calibration Laboratories, will begin with an opening session for coordination of activities. It is anticipated that a closing session will be held on #DateFormat(EndDate, 'mmmm dd, yyyy')# to discuss and review assessment results.

The specific scope is detailed in Attachment A.

Please note that the ISO/IEC 17025 standard has been updated to the ISO/IEC17025:2005 edition which includes changes to align with the requirements ISO9001:2000. Starting October 1, 2005, a grace period of one year will be implemented to come into compliance to the new requirements. The scope of the audits for this period will be based on the updated standard, and any non-conformances found against the new requirements will be identified as an "Observation". Starting October 1, 2006, the requirements of ISO/IEC17025:2005 will be audited for full compliance.

<cfif BILLABLE is "Yes">
A Project with a cost limit of #Cost# has been established to cover the time associated with the assessment. Travel and living expenses incurred will be billed outside of the cost limit.
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