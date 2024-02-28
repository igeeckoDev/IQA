<cfoutput>
#DateFormat(CurDate, 'mmmm dd, yyyy')#

#Name#, #Title#
#ContactEmail#
#OfficeName#

Subject: Quality System Audit of #OfficeName# - #Trim(Area)#

Dear #name#, 

This is to confirm our communications pertaining to the audit of UL #OfficeName# - #Trim(Area)# that is scheduled for #DateFormat(StartDate, 'mmmm dd, yyyy')#. #LeadAuditor# will conduct this audit, which will begin with an opening session to review the audit scope and coordinate audit activities with you and your staff. <cfif Auditor is "" or Auditor is "- None -"><cfelse>#Auditor# will be assisting on this audit.</cfif>

It would be appreciated if you could arrange an area that we could work from during the assessment. Preferably, the workspace should have UL network connections for our laptops to access UL reference materials. We will try to be flexible with respect to your staff schedules so as to minimize the impact of the visit upon operations. 

The scope of the audit is described in Attachment A.

All Noncompliance and Preventive actions noted during the audit will be discussed with you during a formal closing session on #DateFormat(EndDate, 'mmmm dd, yyyy')#.

If you have any questions concerning the audit, please let me know. Otherwise, we look forward to working with you and your staff during our visit. 

#LeadAuditor#
Underwriters Laboratories, Inc.
Email: #AuditorEmail#
Phone: #Phone#

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>