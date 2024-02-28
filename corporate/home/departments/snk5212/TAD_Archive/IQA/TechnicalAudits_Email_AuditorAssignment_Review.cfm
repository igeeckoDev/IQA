<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Approve Auditor Assignment - Review Email Text">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

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

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.5 Set audit due date and send assignment to the auditor<br /><br />
</cfoutput>
</div>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<cfoutput query="Audit">
<b>Options</b><Br />
:: <a href="TechnicalAudits_Email_AuditorAssignment_Send.cfm?#CGI.Query_String#">Send Email</a><br />
<!---
:: <a href="TechnicalAudits_Email_AuditorAssignment_Edit.cfm?#CGI.Query_String#">Edit Email</a><br />
--->
<Br />

<b>To</b>: #AuditorEmail#<br />
<b>From</b>: Technical Audit Manager<br />
<b>CC</b>: #AuditorManagerEmail#, #ROM#<br />
<b>Subject</b>: Internal Technical Audit (#AuditType2#) - Audit Assignment<br /><br />

<cfinclude template="#IQADir#TechnicalAudits_EmailText_AuditorAssignment.cfm">
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->