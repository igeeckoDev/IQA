<cfoutput>
<b><cfset C1 = #CurDate#>#DateFormat(C1, 'mm/dd/yyyy')#</b><br><br>

#Form.Name# (#Form.ContactEmail#)<br>
#Form.Company#<br>
#Form.Address1#<br>
#Form.Address2#<br>
#Form.Address3#<br>
#Form.Address4#<br><br>

Our Reference: File Number <b>#Form.FileNo#</b><br><br>

Subject: General Assessment of Laboratory Operations under UL's Data Acceptance Program <br><br>

Dear <b>#Form.Name#</b>,<br><br>

This letter will confirm the planned visit to <b>#Form.Company#</b> for an assessment of general laboratory operations. This is required under UL's Data Acceptance Program and is scheduled for <b>#Form.StartDate#</b> and will be conducted by <b>#Form.LeadAuditor#</b>.<br><br>

The assessment, to verify compliance to ISO/IEC Standard 17025, General Requirements for the Competence of Testing and Calibration Laboratories, will begin with an opening session for coordination of activities. It is anticipated that a closing session will be held on <b>#Form.EndDate#</b> to discuss and review assessment results.<br><br>

The specific scope is detailed in Attachment A.<br><br>

Please note that the ISO/IEC 17025 standard has been updated to the ISO/IEC17025:2005 edition which includes changes to align with the requirements ISO9001:2000. Starting October 1, 2005, a grace period of one year will be implemented to come into compliance to the new requirements. The scope of the audits for this period will be based on the updated standard, and any non-conformances found against the new requirements will be identified as an "Observation". Starting October 1, 2006, the requirements of ISO/IEC17025:2005 will be audited for full compliance.<br><br>

A Project with a cost limit of <b>#Form.Cost#</b> has been established to cover the time associated with the assessment. Travel and living expenses incurred will be billed outside of the cost limit.<br><br>

If you have any questions concerning this assessment, please let us know.<br><br>

<b>#Form.LeadAuditor#</b><br>
Underwriters Laboratories, Inc.<br>
Email: <b>#Form.AuditorEmail#</b><br>
Phone: <b>#Form.Phone#</b><br><br>
</cfoutput>