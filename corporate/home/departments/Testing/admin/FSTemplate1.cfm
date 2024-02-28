<cfoutput>
<B>#DateFormat(CurDate, 'mmmm dd, yyyy')#</B><br><br>

<B>#Form.e_Name#, #Form.e_Title#<br>
#Form.e_ContactEmail#<br>
#OfficeName#</b><br><br>

Subject: Audit of UL <b>#OfficeName# - #Area#</b> to UL's Field Services Manual and General criteria for the operation of Various types of bodies performing inspection as detailed in the GIP (Global Inspection Policy).<br><br>

Dear <b>#Form.e_Name#</b>, <br><br>

This is to confirm our communications pertaining to the audit of UL <b>#OfficeName# - #Area#</b> that is scheduled for <B>#DateFormat(e_StartDate, 'mmmm dd, yyyy')#</B>. <B>#LeadAuditor#</B> of UL's Corporate Quality Assurance Department will conduct this audit. <cfif Auditor is "" or Auditor is "- None -"><cfelse>#Auditor# will be assisting on this audit.</cfif><br><br>

I plan to arrive at <b>#OfficeName# - #Area#</b> at <b>#TimeFormat(e_StartTime, "h:mm tt")#</b> and begin the assessment with an opening session to review the audit scope and coordinate audit activities with you and your staff. <br><br>

It would be appreciated if you could arrange an area that we could work from during the assessment. Preferably, the workspace should have UL network connections for our laptops to access UL reference materials. We will try to be flexible with respect to your staff schedules so as to minimize the impact of the visit upon operations.<br><br>

This visit might also include a visit to client facilities to audit the activities of one or more Field Reps. If this is the case, we can make special arrangements for the closing meeting. Please see Attachment A for specific details of this possibility.<br><br>

The scope of this assessment is described in Attachment A. This visit will focus on areas of the Field Services Manual, as well as verifying implementation of the following UL Policies/Procedures: Conformity Assessment Manual (CAM), Global Testing Laboratory Policy (GTLP), and the Global Product Certification Policy (GPCP). Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope of this assessment are described in Attachment A. We recognize that some policies/procedures may not be applicable to all locations. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions at each location.<br><br>

If other inspection programs are serviced from this office, pertinent requirements of the GIP, Global Inspection Policy (ISO/IEC 17020), General criteria for the operation of various types of bodies performing inspection, would be applied. Refer to Attachment B for those GIP items.<br><br>

Also in addition for both the ULI Mark program Inspections and the Other Field Inspection programs, (i.e. FES, LP, etc) any activity directly related to surveillance issues such as product audits, follow-up sample selection, competency of field staff, management of Inspection Programs, and inspection data recording and reporting practices will also be reviewed. <br><br>

All Findings and Observations noted during the audit will be discussed with you during a formal closing session anticipated for the afternoon of <B><cfif Form.EndDate is "" or Form.EndDate eq Form.e_StartDate>#DateFormat(Form.e_StartDate, 'mmmm dd, yyyy')#<cfelse>#DateFormat(Form.EndDate, 'mmmm dd, yyyy')#</cfif></B>.<br><br>

If you have any questions concerning the audit, please let me know. Otherwise, we look forward to working with you and your staff during our visit. <br><br>

<B>#LeadAuditor#</B><br>
Underwriters Laboratories, Inc.<br>
Email: <B>#Form.e_AuditorEmail#</B><br>
Phone: <B>#Form.e_Phone#</B><br>
Corporate Quality Assurance Department<br><br>

<cfif cc is ""><cfelse>
cc: <b>#form.cc#</b><br><br>
</cfif>
</cfoutput>