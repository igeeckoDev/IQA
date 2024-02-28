<cfoutput>
<B>#DateFormat(CurDate, 'mm/dd/yyyy')#</B><br><br>

<B>#Form.e_Name#, #Form.e_Title#<br>
#Form.e_ContactEmail#<br>
#OfficeName#</b><br><br>

Subject: Quality System Audit of <B>#OfficeName# - #Area#</B> <br><br>

Dear <B>#Form.e_name#</B>,<br><br> 

This is to confirm our communications pertaining to the<cfif desk is "Yes"> desk</cfif> audit of UL <B>#OfficeName# - #Area#</B> that is scheduled for <B>#DateFormat(e_StartDate, 'mmmm dd, yyyy')#</B>. <B>#LeadAuditor#</B> will conduct this audit, which will begin with an opening session to review the audit scope and coordinate audit activities with you and your staff. <cfif Aud is "" or Aud is "- None -"><cfelse><b>#Aud#</b> will be assisting on this audit.</cfif><br><br>

<cfif desk is "Yes">Desk Audits are utilized to assess compliance of some processes and/or documentation that does not require an on-site visit. During the course of this assessment you may be contacted with questions for further clarification.<cfelse>It would be appreciated if you could arrange an area that we could work from during the assessment. Preferably, the workspace should have UL network connections for our laptops to access UL reference materials. We will try to be flexible with respect to your staff schedules so as to minimize the impact of the visit upon operations.<br><br>

Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.</cfif><br><br>

The scope of the assessment includes verifying compliance to or implementation of the following UL Policies/Procedures: UL Global Quality Manual, Conformity Assessment Manual (CAM), Global Testing Laboratory Policy (GTLP), Global Product Certification Policy (GPCP), and the Global Inspection Policy (GIP). Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. We recognize that some policies/procedures may not be applicable<cfif Desk is "Yes">.<cfelse> to all locations. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.</cfif><br><br>

All Noncompliance and Preventive actions noted during the audit will be discussed with you during a<cfif Desk is "No"> formal</cfif> closing session on <B><cfif Form.EndDate is "" or Form.EndDate eq Form.e_StartDate>#DateFormat(Form.e_StartDate, 'mmmm dd, yyyy')#<cfelse>#DateFormat(Form.EndDate, 'mmmm dd, yyyy')#</cfif></B>.<br><br>

If you have any questions concerning the audit, please let me know. <cfif Desk is "No">Otherwise, we look forward to working with you and your staff during our visit.</cfif><br><br> 

<B>#LeadAuditor#</B><br>
Underwriters Laboratories, Inc.<br>
Email: <B>#Form.e_AuditorEmail#</B><br>
Phone: <B>#Form.e_Phone#</B><br><br>

<cfif cc is ""><cfelse>
cc: <b>#form.cc#</b><br><br>
</cfif>
</cfoutput>