<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "KPI - View Data">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) as maxID
FROM KPI
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM KPI
WHERE ID = #URL.ID#
</CFQUERY>

<cfoutput query="KPI">
<a href="KPI_Edit.cfm?ID=#ID#"><b>Edit</b> this KPI Data</a><br>

<cfif ID eq maxID.maxID>
	<a href="#IQADir#KPI.cfm"><b>View</b> Graphical KPI Page - CURRENT KPI DATA</a>
<cfelse>
	<a href="#IQADir#KPI.cfm?ID=#URL.ID#"><b>View</b> Graphical KPI Page - HISTORICAL DATA</a>
</cfif><br><br>

<cfif URL.ID eq 0>
This is the draft KPI - <a href="KPI_Publish.cfm?ID=#ID#"><b>Publish</b> this KPI Data</a><br><br>
</cfif>

Currently Published KPI: <b>#MonthAsString(Month)#, #Year_#</b><br>
Date Posted: #Dateformat(DatePosted, "mm/dd/yyyy")#<br>
Period Ending: #Dateformat(PeriodEnding, "mm/dd/yyyy")#<br><br>

<b>IQA Customer Satisfaction Survey</b><br>
#IQASurvey#<br><br>

<b>Average Number of audits per Scheme</b><br>
#AvgAuditsPerScheme#<br><bR>

<b>Current Active Scheme Count</b><br>
#CurrentSchemeCount#<br><br>

<b>Target (from Audit Planning), Schemes by Quarter</b><br>
Q1: #PlannedSchemesQ1#<br>
Q2: #PlannedSchemesQ2#<br>
Q3: #PlannedSchemesQ3#<br>
Q4: #PlannedSchemesQ4#<br><br>

<b>Audited Schemes by Quarter</b><br>
Q1: #SchemesQ1#<br>
Q2: #SchemesQ2#<br>
Q3: #SchemesQ3#<br>
Q4: #SchemesQ4#<br><br>

<b>Corrective Action Customer Survey</b><br>
#CARSurvey#<br><br>

<b>Effectively Closed CAR Percentage</b> (Digits Only)<br>
#CARVerifiedEffective#<br><br>

<b>Median Duration of Corrective Actions - Finding</b><br>
#CARfindingMedian#<br><br>

<b>Median Duration of Corrective Actions - Observation</b><br>
#CARObservationMedian#<br><br>

<b>DAP/CTF/External CBTL (Audit) - NPS Score</b><br>
#NPS#<br><br>

<b>Completed Audit Projects before Anniversary Date</b><br>
#AVD#<br><br>

<b>Average Number of Clients per DAP Auditor</b><br>
#DAPAudits#<br><br>

<b>Average Number of Clients per CTF/CBTL Auditor</b><br>
#CTFAudits#<br><br>

</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->