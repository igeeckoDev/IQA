<cfoutput>
#DateFormat(CurDate, 'mmmm dd, yyyy')#

#Name#, #Title#
#ContactEmail#
#OfficeName#

Subject: Audit of UL #Trim(Area)#

Dear #Name#, 

This is to confirm our communications pertaining to the<cfif desk is "Yes"> desk</cfif> audit of the #OfficeName# - #Trim(Area)# program operations scheduled to begin on #DateFormat(StartDate, 'mmmm dd, yyyy')#. The audit will conclude on #DateFormat(EndDate, 'mmmm dd, yyyy')#. <cfif Aud is "" or Aud is "- None -"><cfelse><b>#Aud#</b> will be assisting on this audit.</cfif>
 
<cfif desk is "Yes">Desk Audits are utilized to assess compliance of some processes and/or documentation that does not require an on-site visit. During the course of this assessment you may be contacted with questions for further clarification.<cfelse>Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.</cfif> 
 
The scope of the assessment includes verifying implementation of the following UL Policies/Procedures: UL Global Quality Manual, Conformity Assessment Manual (CAM), Global Testing Laboratory Policy (GTLP), Global Product Certification Policy (GPCP), and the Global Inspection Policy (GIP). Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. We recognize that some policies/procedures may not be applicable to all programs. These logistics will be addressed during pre-audit communications<cfif desk is "Yes">.<cfelse> and/or during the Opening Sessions at each location.</cfif> 

Topics to be covered during the audit include: 

 - Review of Program Manual
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