<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "KPI Add New Data">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE UL06046.KPI
SET 
Year_ = #Form.Year_#,
Month = #Form.Month#,
PeriodEnding = #CreateODBCDate(Form.PeriodEnding)#,
DatePosted = #CreateODBCDate(curdate)#,
IQASurvey = #Form.IQASurvey#, 
CARObservationMedian = #Form.CARObservationMedian#,
NPS = #Form.NPS#,
CARSurvey = #Form.CARSurvey#,
CARVerifiedEffective = #Form.CARVerifiedEffective#,
CARFindingMedian = #Form.CARFindingMedian#,
AVD = #Form.AVD#,
DAPAudits = #Form.DAPAudits#,
CTFAudits = #Form.CTFAudits#,
SchemesQ1 = #Form.SchemesQ1#,
SchemesQ2 = #Form.SchemesQ2#,
SchemesQ3 = #Form.SchemesQ3#,
SchemesQ4 = #Form.SchemesQ4#,
CurrentSchemeCount = #Form.CurrentSchemeCount#,
AVGAuditsPerScheme = #Form.AVGAuditsPerScheme#,
PlannedSchemesQ1 = #Form.PlannedSchemesQ1#,
PlannedSchemesQ2 = #Form.PlannedSchemesQ2#,
PlannedSchemesQ3 = #Form.PlannedSchemesQ3#,
PlannedSchemesQ4 = #Form.PlannedSchemesQ4#

WHERE ID = #URL.ID#
</cfquery>

<cflocation url="KPI_View.cfm?ID=#URL.ID#" addtoken="no">