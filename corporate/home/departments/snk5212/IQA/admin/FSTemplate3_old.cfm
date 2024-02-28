<cfoutput>
#DateFormat(CurDate, 'mmmm dd, yyyy')#

#Name#, #Title#
#ContactEmail#
#OfficeName#

Subject: Audit of UL #OfficeName# - #Area# to UL's Field Services Manual and General criteria for the operation of Various types of bodies performing inspection as detailed in the GIP (Global Inspection Policy).

Dear #Name#, 

This is to confirm our communications pertaining to the audit of UL #OfficeName# - #Area# that is scheduled for #DateFormat(StartDate, 'mmmm dd, yyyy')#. #LeadAuditor# of UL's Corporate Quality Assurance Department will conduct this audit. <cfif Auditor is "" or Auditor is "- None -"><cfelse>#Auditor# will be assisting on this audit.</cfif>

I plan to arrive at #OfficeName# - #Area# at #TimeFormat(StartTime, "h:mm tt")# and begin the assessment with an opening session to review the audit scope and coordinate audit activities with you and your staff. 

It would be appreciated if you could arrange an area that we could work from during the assessment. Preferably, the workspace should have UL network connections for our laptops to access UL reference materials. We will try to be flexible with respect to your staff schedules so as to minimize the impact of the visit upon operations.

This visit might also include a visit to client facilities to audit the activities of one or more Field Reps. If this is the case, we can make special arrangements for the closing meeting. Please see Attachment A for specific details of this possibility. 

The scope of this audit is described in Attachment A.  This visit will focus on areas of the Field Services Manual, and other supporting documents.

If other inspection programs are serviced from this office, pertinent requirements of the GIP, Global Inspection Policy (ISO/IEC 17020), General criteria for the operation of various types of bodies performing inspection, would be applied. Refer to Attachment B for those GIP items.

Also in addition for both the ULI Mark program Inspections and the Other Field Inspection programs, (i.e. FES, LP, etc) any activity directly related to surveillance issues such as product audits, follow-up sample selection, competency of field staff, management of Inspection Programs, and inspection data recording and reporting practices will also be reviewed. 

All Noncompliance and Preventive actions noted during the audit will be discussed with you during a formal closing session anticipated for the afternoon of #DateFormat(EndDate, 'mmmm dd, yyyy')#.

If you have any questions concerning the audit, please let me know. Otherwise, we look forward to working with you and your staff during our visit. 

#LeadAuditor#
Underwriters Laboratories, Inc.
Email: #AuditorEmail#
Phone: #Phone#
Corporate Quality Assurance Department

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>