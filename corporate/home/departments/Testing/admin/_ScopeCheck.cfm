<!---
<CFQUERY Datasource="Corporate" Name="Audits">
SELECT ID, Year_, AuditType2
FROM AuditSchedule
WHERE AuditedBy = 'IQA'
AND Year_ > 2011
ORDER BY Year_, ID
</CFQUERY>

<cfset IQAScope = "1. The scope of the assessment includes verifying implementation of UL Quality Management System (QMS) as described in the Global Quality Manual, 00-QA-P0001, if applicable, or local Quality Management System Manual. Additional functional, local, program or process policies/procedures will also be utilized as required. Assessment to standard requirements (Guide 65, ISO 17025, ISO 17020, ISO 17021, CAN-P-1500) will be utilized as applicable. Specifics on the scope of this assessment are described in Attachment A. Note: Additional logistics may be addressed during pre-audit communications and/or during the Opening Sessions at each location.<br>2. Verify the effective implementation of previously closed CARs (internal and accreditor) as well as progress on open CARs where applicable.<br>3. Ensure documentation and records meet applicable policies.<br>4. Verify that documentation released/updated since the last audit was conducted, meets applicable UL QMS requirements and the applicable revisions of ISO 17025, ISO 17020, Guide 65, ISO 17021 and/or CAN-P-1500 requirements.">

<cfset MMSScope = "1. The scope of the assessment includes verifying implementation of UL's Quality Management System as described in the Global Quality Manual, 00-QA-P0001. Additional functional, local and or MMS program policies/procedures will also be utilized. Specifics on the scope of this assessment are described in Attachment A. These logistics will be addressed during pre-audit communications and/or during the Opening Session.<br>2. Verify the effective implementation of previously closed CARs (internal and accreditor).<br>3. Review progress on open CARs.<br>4. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17021:2006 requirements and the applicable requirements in the accreditation documents in 00-MB-G0031.<br>5. Review the policy/program manual against the applicable standard requirements for compliance to ISO 17021 and the applicable accreditation documents in 00-MB-G0031.<br>6. Review the policy/program manual against the UL Global Quality Manual requirements.<br>7. Review the SOP(s) against the UL policy/Global Quality Manual for compliance:<br>&nbsp;&nbsp; a.Review any local docs to see if there are conflicts,<br>&nbsp;&nbsp; b. Ensure record retention, location, etc is defined in all SOP's.<br>8. Ensure necessary stakeholders have approved the document.<br>9. Ensure the document meets the two year review &amp; other document control procedure requirements.<br>10. See specific scope letter for additional details.">

<cfset IQAFSScope = "1. Review the policy/program manual against the applicable standard requirements for compliance (ISO 17025, Guide 65, etc)<Br>2. Review the policy/program manual against the Global Quality Manual requirements.<Br>3. Review the SOP(s) against the UL policy/Global Quality Manual for compliance<br>&nbsp;&nbsp; 3a.Review any local docs to see if there are conflicts<br>&nbsp;&nbsp; 3b Ensure record retention, location, etc is defined in all SOP's<br>4. Ensure necessary stakeholders have approved the document<br>5. Ensure the document meets the 2 year review & other document control policy/procedure requirements">

<cfoutput query="Audits">
    <cfif auditType2 is "Field Services">
        <cfset newScope = "#IQAFSScope#">
        <cfset newScopeValue = "FS">	
    <cfelseif auditType2 is "MMS - Medical Management Systems">
        <cfset newScope = "#MMSScope#">
        <cfset newScopeValue = "MMS">
    <cfelse>
        <cfset newScope = "#IQAScope#">
        <cfset newScopeValue = "Standard">
    </cfif>
    
#Year_#-#ID#-IQA [#AuditType2#] Scope=#newScopeValue#<br />
    <CFQUERY Datasource="Corporate" Name="updateScope">
    UPDATE AuditSchedule
    SET
    Scope = '#newScope#'
    WHERE ID = #ID#
    AND Year_ = #Year_#
    </CFQUERY>
</cfoutput>
--->