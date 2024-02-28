<cfoutput>
<B>#DateFormat(DateSent, 'mmmm dd, yyyy')#</B><br><br>

<b>#Name#, #Title#<br>
#ContactEmail#<br>
#OfficeName#</b><br><br>

<b>Subject:</b> Audit of UL <b>#Area#</b><br><br>

Dear <b>#Name#</b>, <br><br>

This confirms our communications regarding the Internal Quality Audits Department assessment of the <b>#OfficeName# - #Area#</b> program operations scheduled to begin on <B>#DateFormat(StartDate, 'mmmm dd, yyyy')#</B>. The audit will conclude on <B>#DateFormat(EndDate, 'mmmm dd, yyyy')#</b>. <cfif Auditor is "" or Auditor is "- None -"><cfelse>#Auditor# will be assisting on this audit.</cfif><br><br>
 
The purpose of this assessment is to determine compliance to certification requirements, inspection, and/or laboratory requirements of #Area#. Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.<br><br>
 
Desk audits may be conducted prior to the on-site audit to verify compliance with 00-LC-S0258, Data Recording,  Reporting and Related Requirements. Additionally, desk audits may be conducted of data, records and/or documents prior to the on-site visit. Any issues associated with these desk audits will be covered during the on-site audit.<br><br>

Topics to be covered during the audit include: <br><br>

<UL>
<LI>Desk Review of Program Manual  (if there is one)
<LI>Contract review 
<LI>Certification decision process 
<LI>Testing and or inspection processes 
<LI>Document Control 
<LI>Records 
<LI>Training 
<LI>Internal Auditing 
<LI>Technical Assessments (if applicable) 
<LI>Management Review 
<LI>Subcontractor Management (CIP) 
<LI>Corrective/Preventive Action 
<LI>Program Office Interface to Affiliates & TPTDP Controls 
<LI>Accreditation Requirements (in addition to OSHA, ANSI, etc..) 
<LI>Metrics
</UL><br><br>

Best Regards,<br><br>

<b>#LeadAuditor#</b><br>
Underwriters Laboratories, Inc.<br>
Corporate Quality Audits<br>
Email: <b>#AuditorEmail#</b><br>
Phone: <b>#Phone#</b><br><br>

<cfif cc is ""><cfelse>
cc: <b>#cc#</b><br><br>
</cfif>
</cfoutput>