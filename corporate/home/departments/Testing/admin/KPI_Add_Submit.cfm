<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "KPI Add New Data">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="AddRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO UL06046.KPI(ID, Year_, Month, DatePosted, PeriodEnding)
VALUES(0, #Form.Year_#, #Form.Month#, #CreateODBCDate(curdate)#, #CreateODBCDate(Form.PeriodEnding)#)
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE UL06046.KPI
SET 
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

WHERE ID = 0
</cfquery>

<cflocation url="KPI_View.cfm?ID=0" addtoken="no">