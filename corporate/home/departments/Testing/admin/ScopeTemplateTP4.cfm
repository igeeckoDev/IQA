<cfoutput>
<b>#DateFormat(DateSent, 'mmmm dd, yyyy')#</b><br><br>

<b>#Name# (Sent to: #ContactEmail#)<br>
#ExternalLocation#<br>
#Address1#<br>
#Address2#<br>
#Address3#<br>
#Address4#</B><br><br>

Our Reference: File Number <b>#FileNo#</b><br><br>

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program <br><br>

Dear <b>#Name#</b>,<br><br>

This letter will confirm the planned <cfif desk is "Yes">desk audit of<cfelse>visit to</cfif> <b>#ExternalLocation#</b> for an assessment of general laboratory operations. This is required under UL's Data Acceptance Program and is scheduled for <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b> and will be conducted by <b>#LeadAuditor#</b>.<br><br>

This assessment is to verify continued compliance to ISO/IEC Standard 17025, General Requirements for the Competence of Testing and Calibration Laboratories. It is anticipated that the audit will commence on <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b> and be completed by <b>#DateFormat(EndDate, 'mmmm dd, yyyy')#</b> with a report provided to you containing the assessments results. <cfif desk is "Yes">During the course of this assessment you may be contacted with questions or further clarification.</cfif><br><br>

<cfif desk is "Yes">In preparation for this audit, please provide information on any key changes in your operations since last year's general assessment of laboratory operations, such as changes in your test facilities, personnel, and testing capability.  In addition, please provide us with your most current quality manual, documentation relating to any nonconformances identified in last year's assessment, and most recent internal audit and management review reports.  This information and documentation is requested at your earliest convenience but no later than <b>#DateFormat(StartDate, 'mmmm dd, yyyy')#</b>.</cfif> The specific scope is detailed in Attachment A.<br><br>

<cfif Billable is "Yes">
A Project with a cost limit of <b>#Cost#</b> has been established to cover the time associated with the assessment. <cfif Desk is "No">Travel and living expenses incurred will be billed outside of the cost limit.</cfif><br><br>
</cfif>

If you have any questions concerning this assessment, please let us know.<br><br>

<b>#LeadAuditor#</b><br>
Underwriters Laboratories, Inc.<br>
Email: <b>#AuditorEmail#</b><br>
Phone: <b>#Phone#</b><br><br>

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>