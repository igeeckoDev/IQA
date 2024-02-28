<cfoutput>
#DateFormat(CurDate, 'mmmm dd, yyyy')#

#Name#, #Title#
#ContactEmail#
#OfficeName#

Subject: Quality System Audit of  <cfif AuditType2 is "Program" or AuditType2 is "Corporate" or AuditType2 is "Global Function/Process"><cfelse>#OfficeName# - </cfif>#Area# 

Dear #name#, 

This is to confirm our communications pertaining to the<cfif desk is "Yes"> desk</cfif> audit of UL #OfficeName# - #Area# that is scheduled for #DateFormat(StartDate, 'mmmm dd, yyyy')#. #LeadAuditor# will conduct this audit, which will begin with an opening session to review the audit scope and coordinate audit activities with you and your staff. <cfif Aud is "" or Aud is "- None -"><cfelse>#Aud# will be assisting on this audit.</cfif>

<cfif desk is "Yes">Desk Audits are utilized to assess compliance of some processes and/or documentation that does not require an on-site visit. During the course of this assessment you may be contacted with questions for further clarification.<cfelse>It would be appreciated if you could arrange an area that we could work from during the assessment. Preferably, the workspace should have UL network connections for our laptops to access UL reference materials. We will try to be flexible with respect to your staff schedules so as to minimize the impact of the visit upon operations.

<cfif AuditType2 is "Program">Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. </cfif>Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.</cfif>

<cfif AuditType2 is "Field Services">This assessment might also include a visit to client facilities to audit the activities of one or more Field Reps. If this is the case, we can make special arrangements for the closing meeting. Please see Attachment A for specific details of this possibility.</cfif>

The scope of this assessment includes verifying compliance to and implementation of the UL Quality Management System as detailed in the UL Global Quality Manual, 00-QA-P0001. Scope specifics are described in Attachment A.

<cfif AuditType2 is "Global Function/Process">Audit duration is dependent on the amount of documents requiring review globally.  As such, an end date cannot be determined at this time.

A closing meeting will be scheduled at the completion of the audit to discuss any Findings and Observations noted during the audit.<cfelse>

All Findings and Observations noted during the audit will be discussed with you during a formal closing session on <cfif EndDate is "" or EndDate eq StartDate>#DateFormat(StartDate, 'mmmm dd, yyyy')#<cfelse>#DateFormat(EndDate, 'mmmm dd, yyyy')#</cfif>.</cfif>

If you have any questions concerning the audit, please let me know. <cfif Desk is "No">Otherwise, we look forward to working with you and your staff during our visit.</cfif> 

#LeadAuditor#
Underwriters Laboratories, Inc.
Email: #AuditorEmail#
Phone: #Phone#

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>