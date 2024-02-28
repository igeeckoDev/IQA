<cfoutput>
<B>#DateFormat(DateSent, 'mmmm dd, yyyy')#</B><br><br>

<B>#Name#, #Title#<br>
#ContactEmail#<br>
#OfficeName#</b><br><br>

Subject: Quality System Audit of <B>#OfficeName# - #Area#</B><br><br>

Dear <B>#name#</B>,<br><br> 

This is to confirm our communications pertaining to the audit of UL <B>#OfficeName# - #Area#</B> that is scheduled for <B>#DateFormat(StartDate, 'mmmm dd, yyyy')#</B>. <B>#LeadAuditor#</B> will conduct this audit, which will begin with an opening session to review the audit scope and coordinate audit activities with you and your staff. <cfif Auditor is "" or Auditor is "- None -"><cfelse>#Auditor# will be assisting on this audit.</cfif><br><br>

It would be appreciated if you could arrange an area that we could work from during the assessment. Preferably, the workspace should have UL network connections for our laptops to access UL reference materials. We will try to be flexible with respect to your staff schedules so as to minimize the impact of the visit upon operations.<br><br> 

The scope of the audit is described in Attachment A.<br><br>

All Noncompliance and Preventive actions noted during the audit will be discussed with you during a formal closing session on <B>#DateFormat(EndDate, 'mmmm dd, yyyy')#</B>.<br><br>

If you have any questions concerning the audit, please let me know. Otherwise, we look forward to working with you and your staff during our visit.<br><br> 

<B>#LeadAuditor#</B><br>
Underwriters Laboratories, Inc.<br>
Email: <B>#AuditorEmail#</B><br>
Phone: <B>#Phone#</B><br><br>

<cfif cc is ""><cfelse>
cc: <b>#cc#</b><br><br>
</cfif>
</cfoutput>