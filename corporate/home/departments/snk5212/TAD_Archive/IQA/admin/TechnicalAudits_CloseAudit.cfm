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

<cfinclude template="#IQADir#TechnicalAudit_incAuditIdentifier.cfm">

<cfform action="#IQADir#TechnicalAudits_CloseAudit_Action.cfm?ID=#URL.ID#&Year=#URL.Year#">

<b>Do you want to Close this Audit?</b><Br>
Yes <cfinput type="checkbox" name="YesNoItem" value="Yes" required="yes" message="Please select Yes if you wish to Close this Audit." /><Br><br>

This action will send a letter indicating the Audit is closed.<br><Br>

<cfinput type="Submit" name="upload" value="Submit">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->