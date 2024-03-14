<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Close Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	*
FROM
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	<cfset ReplyTo = "#Audit.TAM#">
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
</cfif>

<cfif Audit.NCExistPostAppeal eq "No">
	<!--- EMAIL ID 17 / 17 a --->
	<cfset Step = "Audit Completed and Closed - No Non-Conformances Found After Appeals">
<cfelseif Audit.NCExist eq "No">
	<!--- EMAIL ID 16 / 16 a--->
	<cfset Step = "Audit Completed and Closed - No Non-Conformances Identified">
<cfelseif Audit.SRCARVerified eq "Yes">
	<!--- EMAIL ID 18 / 18 a --->
	<cfset Step = "Audit Completed and Closed - Corrective Actions Verified">
</cfif>

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

<cfinclude template="#IQADir#TechnicalAudit_incAuditIdentifier.cfm">

<div align="Left" class="blog-time">
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.15 Ready to Close<br /><br />
</cfoutput>
</div>

<cfform action="#IQADir#TechnicalAudits_CloseAudit_Action.cfm?ID=#URL.ID#&Year=#URL.Year#&Action=#URL.Action#">

<b>Do you want to Close this Audit?</b><Br>
Yes <cfinput type="checkbox" name="YesNoItem" value="Yes" required="yes" message="Please select Yes if you wish to Close this Audit." /><Br><br>

<cfoutput query="Audit">

<cfif AuditType2 eq "Full">
	<cfset incTo = "#EngManagerEmail#, #replyTo#, #getROM.ROM#, #getROM.SQM#">
<cfelse>
    <cfset incTo = "#EngManagerEmail#, #replyTo#">
</cfif>

To = #replyTo#, #incTo#<br />
Subject = #Flag_CurrentStep#<br />
From = #Request.TechnicalAuditMailbox#<br />
replyto = #replyTo#<br /><br />

<!--- No NCs OR No NCs after appeal --->
<cfif NCExistPostAppeal eq "No" OR NCExist eq "No">
<!--- EMAIL ID 16 / 16 a---><!--- EMAIL ID 17 / 17 a --->
    Congratulations!<br /><br />

    This email is notification that the <cfif AuditType2 eq "Full">Full<cfelseif AuditType2 eq "In-Process">In-Process</cfif> Internal Technical Audit identified below has been completed and closed. The results of the project audit demonstrated full compliance.<br /><br />

    A detailed review and analysis was conducted in order to determine that the supporting documents, data recording and /or decision granting certification fulfilled UL requirements and were technically correct.<br /><br />

    Project Number: #ProjectNumber#<br /><br />

    Click below to open the audit: #varAuditIdentifier#<br />
    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

	Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

    On behalf of UL, we thank you for the valuable and continued contributions.<br /><br />

    Regards,<br /><br />

    Technical Audit Team<br /><br />

    #ReplyTo# (Technical Audit Manager)<Br />
    <cfif AuditType2 eq "Full">
    #getROM.ROM# (Regional Operations Manager)<br />
    #getROM.SQM# (Site Quality Manager)<br /><br />
    </cfif>

<!--- Corrective Actions Verified --->
<cfelseif Audit.SRCARVerified eq "Yes">
<!--- EMAIL ID 18 / 18 a --->
	Greetings,<br /><br />

    This email is notification that the <cfif AuditType2 eq "Full">Full<cfelseif AuditType2 eq "In-Process">In-Process</cfif> Technical Audit identified below has been completed and closed.<br /><br />

    We verified the corrective actions related to the non-conforming items and deemed the actions as effective. As such, we are closing this audit.<br /><br />

    Click below to open the audit: #varAuditIdentifier#<br />
    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

	Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

	Regards,

    #ReplyTo# (Technical Audit Manager)<Br />
    <cfif AuditType2 eq "Full">
    #getROM.ROM# (Regional Operations Manager)<br />
    #getROM.SQM# (Site Quality Manager)<br /><br />
    </cfif>
</cfif>
</cfoutput>

<cfinput type="Submit" name="upload" value="Submit">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->