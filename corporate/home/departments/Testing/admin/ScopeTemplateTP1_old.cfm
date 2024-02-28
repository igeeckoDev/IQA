\<cfoutput>		
<b>#DateFormat(curdate, 'mmmm dd, yyyy')#</b><br><br>

<b>#Form.e_Name# (#Form.e_ContactEmail#)<br>
#ExternalLocation#<br>
#Form.e_Address1#<br>
#Form.Address2#<br>
#Form.Address3#<br>
#Form.Address4#</B><br><br>

Our Reference: File Number <b>#Form.e_FileNo#</b><br><br>

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program <br><br>

Dear <b>#Form.e_Name#</b>,<br><br>

This letter will confirm the planned visit to <b>#ExternalLocation#</b> for an assessment of general laboratory operations. This is required under UL's Data Acceptance Program and is scheduled for <b>#DateFormat(Form.e_StartDate, 'mmmm dd, yyyy')#</b> and will be conducted by <b>#LeadAuditor#</b>.<br><br>

The assessment, to verify compliance to ISO/IEC Standard 17025, General Requirements for the Competence of Testing and Calibration Laboratories, will begin with an opening session for coordination of activities. It is anticipated that a closing session will be held on <b><cfif Form.EndDate is "" or Form.EndDate eq Form.e_StartDate>#DateFormat(Form.e_StartDate, 'mmmm dd, yyyy')#<cfelse>#DateFormat(Form.EndDate, 'mmmm dd, yyyy')#</cfif></b> to discuss and review assessment results.<br><br>

The specific scope is detailed in Attachment A.<br><br>

Please note that the ISO/IEC 17025 standard has been updated to the ISO/IEC17025:2005 edition which includes changes to align with the requirements ISO9001:2000. Starting October 1, 2005, a grace period of one year will be implemented to come into compliance to the new requirements. The scope of the audits for this period will be based on the updated standard, and any non-conformances found against the new requirements will be identified as an "Observation". Starting October 1, 2006, the requirements of ISO/IEC17025:2005 will be audited for full compliance.<br><br>

<cfif Billable is "Yes">
A Project with a cost limit of <b>#Form.e_Cost#</b> has been established to cover the time associated with the assessment. Travel and living expenses incurred will be billed outside of the cost limit.<br><br>
</cfif>

If you have any questions concerning this assessment, please let us know.<br><br>

<b>#LeadAuditor#</b><br>
Underwriters Laboratories, Inc.<br>
Email: <b>#Form.e_AuditorEmail#</b><br>
Phone: <b>#Form.e_Phone#</b><br><br>

<cfif cc is ""><cfelse>
cc: #cc#
</cfif>
</cfoutput>