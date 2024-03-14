<CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

<cfif Audit.NCExistPostAppeal eq "No">
	Flag_CurrentStep = 'Audit Completed and Closed - No Non-Conformances Found After Appeals',
<cfelseif Audit.NCExist eq "No">
	Flag_CurrentStep = 'Audit Completed and Closed - No Non-Conformances Identified',
</cfif>
AuditClosedConfirmDate = #createODBCDate(curdate)#,
AuditClosedConfirm = 'Yes'

WHERE
ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	*
FROM
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfquery Datasource="UL06046" name="getROM" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	Corporate.IQARegion.TechnicalAudits_ROM as ROM, Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM
FROM
	Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE
	Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
	AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
	AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#Audit.OfficeName#'
</CFQUERY>

<cfmail to="#Audit.ROM#, #getROM.SQM#, #AuditorEmail#, #AuditorManagerEmail#, #Request.TechnicalAuditManager#"
	Subject="#Flag_CurrentStep#"
    from="Internal.Quality_Audits@ul.com"
    type="html"
    query="Audit">

	<cfif AuditType2 eq "Full">
        <cfset AuditTypeID = "F">
    <cfelse>
        <cfset AuditTypeID = "P">
    </cfif>

    <cfif RequestType eq "Test">
        <cfset RequestTypeID = "T">
    <cfelse>
        <cfset RequestTypeID = "N">
    </cfif>

    <cfset AuditorLoc = #right(AuditorDept, 3)#>

    <cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

    Audit: #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#<br />
    Step Completed: #Flag_CurrentStep#<br /> <br />

    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#">Link to Audit Details</a><br><br>

	Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
</cfmail>

<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">