<cfoutput>
#DateFormat(CurDate, 'mmmm dd, yyyy')#

#Name#, #Title#
#ContactEmail#
#OfficeName#

Subject: Audit of UL #Trim(Area)#

Dear #Name#, 

This confirms our communications regarding the Internal Quality Audits Department assessment of the #OfficeName# - #Trim(Area)# program operations scheduled to begin on #DateFormat(StartDate, 'mmmm dd, yyyy')#. The audit will conclude on #DateFormat(EndDate, 'mmmm dd, yyyy')#. <cfif Auditor is "" or Auditor is "- None -"><cfelse>#Auditor# will be assisting on this audit.</cfif>
 
The purpose of this assessment is to determine compliance to certification requirements, inspection, and/or laboratory requirements of #Area#. Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.
 
Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.

Topics to be covered during the audit include: 

 - Desk Review of Program Manual  (if there is one)
 - Contract review 
 - Certification decision process 
 - Testing and or inspection processes 
 - Document Control 
 - Records 
 - Training 
 - Internal Auditing 
 - Technical Assessments (if applicable) 
 - Management Review 
 - Subcontractor Management (CIP) 
 - Corrective/Preventive Action 
 - Program Office Interface to Affiliates & TPTDP Controls 
 - Accreditation Requirements (in addition to OSHA, ANSI, etc..) 
 - Metrics

Best Regards,

#LeadAuditor#
Underwriters Laboratories, Inc.
Corporate Quality Audits
Email: #AuditorEmail#
Phone: #Phone#

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>