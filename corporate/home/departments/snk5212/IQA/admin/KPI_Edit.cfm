<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "KPI Add New Data">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM KPI
WHERE ID = #URL.ID#
</CFQUERY>

<cfoutput query="KPI">

<cfform method="post" id="myform" name="myform" action="KPI_Edit_Submit.cfm?ID=#URL.ID#" enctype="multipart/form-data">

Currently Published KPI: <b>#MonthAsString(Month)#, #Year_#</b><br>
Date Posted: #Dateformat(DatePosted, "mm/dd/yyyy")#<br>
Period Ending: #Dateformat(PeriodEnding, "mm/dd/yyyy")#<br><br>

<b>Please select KPI Year to Add</b> - 4 digits<br>
<cfinput type="text" name="Year_" size="10" data-bvalidator="required" data-bvalidator-msg="KPI Year" value="#Year_#"><br><br>

<b>Please select KPI Month to Add</b> - 1 or 2 digits, between 1 and 12<br>
<cfinput type="text" name="Month" size="10" data-bvalidator="required" data-bvalidator-msg="KPI Month" value="#month#"><br><br>

<b>Period Ending (date - mm/dd/yyyy format)</b><br>
<cfinput type="text" name="PeriodEnding" size="10" data-bvalidator="required" data-bvalidator-msg="Period Ending (mm/dd/yyyy)" value="#dateformat(PeriodEnding, "mm/dd/yyyy")#"><br><br>

<b>IQA Customer Satisfaction Survey</b><br>
<cfinput type="text" name="IQASurvey" value="#IQASurvey#" size="10" data-bvalidator="required" data-bvalidator-msg="IQA Survey"><br>

Data from: <a href="http://usnbkiqas100p/departments/snk5212/IQA/AuditSurvey_Metrics.cfm?Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/AuditSurvey_Metrics.cfm?Year=#curYear#</a><br><br>

<b>Average Number of audits per Scheme</b><br>
<cfinput type="text" name="AvgAuditsPerScheme" size="10" data-bvalidator="required" data-bvalidator-msg="Average Number of Audits per Scheme" value="#AvgAuditsPerScheme#"><br>

Data can be obtained from this page (on the bottom of the page, see heading "Average Audits per Scheme"<Br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#</a><br>
(adjust year in URL as needed)<br><br>

<b>Current Active Scheme Count</b><br>
<cfinput type="text" name="CurrentSchemeCount" size="10" data-bvalidator="required" data-bvalidator-msg="Current Active Scheme Count" value="#CurrentSchemeCount#"><br>

Data can be obtained from this page (on the bottom of the page, see heading "Adjusted Number of Schemes"<Br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#</a><br>
(adjust year in URL as needed)<br><br>

<b>Target (from Audit Planning), Schemes by Quarter</b><br>
Q1 <cfinput type="text" name="PlannedSchemesQ1" value="#PlannedSchemesQ1#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q1"><br>
Q2 <cfinput type="text" name="PlannedSchemesQ2" value="#PlannedSchemesQ2#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q2"><br>
Q3 <cfinput type="text" name="PlannedSchemesQ3" value="#PlannedSchemesQ3#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q3"><br>
Q4 <cfinput type="text" name="PlannedSchemesQ4" value="#PlannedSchemesQ4#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q4"><br><br>
	
<b>Audited Schemes by Quarter</b><br>
Q1 <cfinput type="text" name="SchemesQ1" value="#SchemesQ1#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q1"><br>
Q2 <cfinput type="text" name="SchemesQ2" value="#SchemesQ2#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q2"><br>
Q3 <cfinput type="text" name="SchemesQ3" value="#SchemesQ3#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q3"><br>
Q4 <cfinput type="text" name="SchemesQ4" value="#SchemesQ4#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q4"><br><br>

Data can be obtained using the following pages:<Br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/admin/KPI_SchemesPerAudit.cfm?Year=#CurYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/admin/KPI_SchemesPerAudit.cfm?Year=#CurYear#</a><br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#</a> (adjust year in URL as needed)<br><br>

<b>Corrective Action Customer Survey</b><br>
<cfinput type="text" name="CARSurvey" value="#CARSurvey#" size="10" data-bvalidator="required" data-bvalidator-msg="CAR Survey"><br>

Data from: <a href="http://usnbkiqas100p/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=#curYear#</a><br><Br>

<b>Effectively Closed CAR Percentage</b> (Digits Only)<br>
<cfinput type="text" name="CARVerifiedEffective" size="10" data-bvalidator="required" data-bvalidator-msg="Effectively Closed CAR Percentage" value="#CARVerifiedEffective#"><br>

Data can be obtained from the file named "GCAR Metrics NewImport": <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">QE Office 365 GCAR Metrics</a><br><br>

<b>Median Duration of Corrective Actions - Finding</b><br>
<cfinput type="text" name="CARfindingMedian" size="10" data-bvalidator="required" data-bvalidator-msg="Median Duration of Corrective Actions - Finding" value="#CARFindingMedian#"><br>

Data can be obtained from the file named "GCAR Metrics NewImport": <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">QE Office 365 GCAR Metrics</a><br><br>

<b>Median Duration of Corrective Actions - Observation</b><br>
<cfinput type="text" name="CARObservationMedian" size="10" data-bvalidator="required" data-bvalidator-msg="Median Duration of Corrective Actions - Observation" value="#CARObservationMedian#"><br>

Data can be obtained from the file named "GCAR Metrics NewImport": <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">QE Office 365 GCAR Metrics</a><br><br>

The following KPIs can be obtained from this location:<br>
<a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FDAP%20Performance%20Management%2FDAP%20KPI%20Information&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">DAP KPI Calculation Sheets</a><br><bR>

<b>DAP/CTF/External CBTL (Audit) - NPS Score</b><br>
<cfinput type="text" name="NPS" size="10" data-bvalidator="required" data-bvalidator-msg="DAP/CTF/External CBTL (Audit) - NPS Score" value="#NPS#"><br><br>

<b>Completed Audit Projects before Anniversary Date</b><br>
<cfinput type="text" name="AVD" size="10" data-bvalidator="required" data-bvalidator-msg="Completed Audit Projects before Anniversary Date" value="#AVD#"><br><br>

<b>Average Number of Clients per DAP Auditor</b><br>
<cfinput type="text" name="DAPAudits" size="10" data-bvalidator="required" data-bvalidator-msg="Average Number of Clients per DAP Auditor" value="#DAPAudits#"><br><br>

<b>Average Number of Clients per CTF/CBTL Auditor</b><br>
<cfinput type="text" name="CTFAudits" size="10" data-bvalidator="required" data-bvalidator-msg="Average Number of Clients per CTF/CBTL Auditor" value="#CTFAudits#"><br><br>

<input type="submit" value="Submit KPI Data">
<input type="reset" value="Reset Form"><br /><br />

</cfform>
</cfoutput>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->