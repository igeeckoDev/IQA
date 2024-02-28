<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Complete - Assignment of Auditor and Associated Roles">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- select auditor info --->
<CFQUERY Name="Roles" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	Auditor, AuditorEmail, AuditorDept, AuditorOfficeName,
	AuditorManager, AuditorManagerEmail, AuditorManagerDept, AuditorManagerOfficeName,
    EngManager, EngManagerEmail,
    EngManagerDirector, EngManagerDirectorEmail, EngManagerDirectorDept, EngManagerDirectorOfficeName
From 
	TechnicalAudits_AuditSchedule
WHERE 
	ID = #URL.ID# AND Year_ = #URL.Year#
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

<cfoutput>
<u>Available Actions</u><br />
:: <b><A href="TechnicalAudits_SelectAuditor_ConfirmAll_Action.cfm?#CGI.QUERY_STRING#">Confirm Selections</A></b><br />
:: The Roles below can be edited on the Audit Details page<br /><br />
</cfoutput>

<b>Audit Details</b><br />
<cfoutput query="Audit">
<u>Audit Number</u>: #URL.Year#-#URL.ID#-#AuditedBy#<br />
<u>Project Number</u>: #ProjectNumber#<br />
<u>File Number</u>: #FileNumber#<br />
<u>Audit Type</u>: #AuditType2#<br />
<u>Request Type</u>: #RequestType#<br />
<u>Office Name</u>: #OfficeName#<Br />
<u>Industry</u>: #Industry#<br />
<u>Standard</u>: #Standard#<Br />
<u>CCN</u>: #CCN#<br /><br />
</cfoutput>

<cfoutput query="Roles">
<b>Assigned Auditor</b><br />
#Auditor#<br />
#AuditorDept#<Br />
#AuditorOfficeName#<br /><br />

<b>Auditor's Manager</b><br />
#AuditorManager#<br />
#AuditorManagerDept#<Br />
#AuditorManagerOfficeName#<br /><br />

<b>Engineering Manager</b><br />
#EngManager#<br />
#EngManagerEmail#<Br /><br />

<b>Engineering Director</b><br />
#EngManagerDirector#<br />
#EngManagerDirectorEmail#<br />
#EngManagerDirectorDept#<Br />
#EngManagerDirectorOfficeName#<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->