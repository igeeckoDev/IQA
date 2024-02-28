<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "KPI Add New Data">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method="post" id="myform" name="myform" action="KPI_Add_Submit.cfm" enctype="multipart/form-data">

<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) as maxID
FROM KPI
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM KPI
WHERE ID = #maxID.maxID#
</CFQUERY>

<cfoutput query="KPI">
	Currently Published KPI: #MonthAsString(Month)#, #Year_#<br>
	Date Posted: #Dateformat(DatePosted, "mm/dd/yyyy")#<br><br>
</cfoutput>

<b>Please select KPI Year to Add</b> - 4 digits<br>
<cfinput type="text" name="Year_" size="10" data-bvalidator="required" data-bvalidator-msg="KPI Year"><br><br>

<b>Please select KPI Month to Add</b> - 1 or 2 digits, between 1 and 12<br>
<cfinput type="text" name="Month" size="10" data-bvalidator="required" data-bvalidator-msg="KPI Month"><br><br>

<b>Period Ending (date - mm/dd/yyyy format)</b><br>
<cfinput type="text" name="PeriodEnding" size="10" data-bvalidator="required" data-bvalidator-msg="Period Ending (mm/dd/yyyy)"><br><br>

<CFQUERY BLOCKFACTOR="100" name="AuditSurvey" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer
FROM AuditSurvey_Answers, AuditSurvey_Users
WHERE AuditSurvey_Answers.Answer <> 0
AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
AND AuditSurvey_Users.AuditYear = #curYear#
</cfquery>

<cfoutput query="AuditSurvey">
	<b>IQA Customer Satisfaction Survey</b><br>
	<cfinput type="text" name="IQASurvey" value="#numberformat(avgAnswer, "9.99")#" size="10" data-bvalidator="required" data-bvalidator-msg="IQA Survey"><br>

	Data from: <a href="http://usnbkiqas100p/departments/snk5212/IQA/AuditSurvey_Metrics.cfm?Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/AuditSurvey_Metrics.cfm?Year=#curYear#</a><br><br>

<b>Average Number of audits per Scheme</b><br>
<cfinput type="text" name="AvgAuditsPerScheme" size="10" data-bvalidator="required" data-bvalidator-msg="Average Number of Audits per Scheme"><br>
Data can be obtained from this page (on the bottom of the page, see heading "Average Audits per Scheme"<Br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#</a><br>
(adjust year in URL as needed)<br><br>

<b>Current Active Scheme Count</b><br>
<cfinput type="text" name="CurrentSchemeCount" size="10" data-bvalidator="required" data-bvalidator-msg="Current Active Scheme Count"><br>
Data can be obtained from this page (on the bottom of the page, see heading "Adjusted Number of Schemes"<Br>
<a href="http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#</a><br>
(adjust year in URL as needed)<br><br>

	<b>Target (from Audit Planning), Schemes by Quarter</b><br>
	Q1 <cfinput type="text" name="PlannedSchemesQ1" value="#KPI.PlannedSchemesQ1#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q1"><br>
	Q2 <cfinput type="text" name="PlannedSchemesQ2" value="#KPI.PlannedSchemesQ2#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q2"><br>
	Q3 <cfinput type="text" name="PlannedSchemesQ3" value="#KPI.PlannedSchemesQ3#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q3"><br>
	Q4 <cfinput type="text" name="PlannedSchemesQ4" value="#KPI.PlannedSchemesQ4#" size="10" data-bvalidator="required" data-bvalidator-msg="Planned Schemes Q4"><br><br>
	
	<b>Audited Schemes by Quarter</b><br>
	Q1 <cfinput type="text" name="SchemesQ1" value="#KPI.SchemesQ1#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q1"><br>
	Q2 <cfinput type="text" name="SchemesQ2" value="#KPI.SchemesQ2#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q2"><br>
	Q3 <cfinput type="text" name="SchemesQ3" value="#KPI.SchemesQ3#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q3"><br>
	Q4 <cfinput type="text" name="SchemesQ4" value="#KPI.SchemesQ4#" size="10" data-bvalidator="required" data-bvalidator-msg="Covered Schemes Q4"><br>

	Data can be obtained using the following pages:<Br>
	<a href="http://usnbkiqas100p/departments/snk5212/IQA/admin/KPI_SchemesPerAudit.cfm?Year=#CurYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/admin/KPI_SchemesPerAudit.cfm?Year=#CurYear#</a><br>
	<a href="http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/Prog_Plan_KPI.cfm?View=All&Year=#curYear#</a> (adjust year in URL as needed)<br><br>
</cfoutput>
	
<CFQUERY BLOCKFACTOR="100" name="CARSurvey" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer
FROM CARSurvey_Answers, CARSurvey_Users
WHERE CARSurvey_Answers.Answer <> 0
AND CARSurvey_Users.ID = CARSurvey_Answers.USERID
AND
	(CARSurvey_Users.Posted >= TO_DATE('#curYear#-01-01', 'yyyy-mm-dd')
	AND CARSurvey_Users.Posted <= TO_DATE('#curYear#-12-31', 'yyyy-mm-dd'))
</cfquery>

<cfoutput query="CARSurvey">
	<b>Corrective Action Customer Survey</b><br>
	<cfinput type="text" name="CARSurvey" value="#numberformat(avgAnswer, "9.99")#" size="10" data-bvalidator="required" data-bvalidator-msg="CAR Survey"><br>

	Data from: <a href="http://usnbkiqas100p/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=#curYear#" target="_blank">http://usnbkiqas100p/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=#curYear#</a><br><Br>
</cfoutput>

<b>Effectively Closed CAR Percentage</b> (Digits Only)<br>
<cfinput type="text" name="CARVerifiedEffective" size="10" data-bvalidator="required" data-bvalidator-msg="Effectively Closed CAR Percentage"><br>
Data can be obtained from the file named "GCAR Metrics NewImport": <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">QE Office 365 GCAR Metrics</a><br><br>

<b>Median Duration of Corrective Actions - Finding</b><br>
<cfinput type="text" name="CARfindingMedian" size="10" data-bvalidator="required" data-bvalidator-msg="Median Duration of Corrective Actions - Finding"><br>
Data can be obtained from the file named "GCAR Metrics NewImport": <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">QE Office 365 GCAR Metrics</a><br><br>

<b>Median Duration of Corrective Actions - Observation</b><br>
<cfinput type="text" name="CARObservationMedian" size="10" data-bvalidator="required" data-bvalidator-msg="Median Duration of Corrective Actions - Observation"><br>
Data can be obtained from the file named "GCAR Metrics NewImport": <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">QE Office 365 GCAR Metrics</a><br><br>

====<br><br>

The following KPIs can be obtained from this location:<br>
<a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FDAP%20Performance%20Management%2FDAP%20KPI%20Information&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">DAP KPI Calculation Sheets</a><br><bR>

<b>DAP/CTF/External CBTL (Audit) - NPS Score</b><br>
<cfinput type="text" name="NPS" size="10" data-bvalidator="required" data-bvalidator-msg="DAP/CTF/External CBTL (Audit) - NPS Score"><br><br>

<b>Completed Audit Projects before Anniversary Date</b><br>
<cfinput type="text" name="AVD" size="10" data-bvalidator="required" data-bvalidator-msg="Completed Audit Projects before Anniversary Date"><br><br>

<b>Average Number of Clients per DAP Auditor</b><br>
<cfinput type="text" name="DAPAudits" size="10" data-bvalidator="required" data-bvalidator-msg="Average Number of Clients per DAP Auditor"><br><br>

<b>Average Number of Clients per CTF/CBTL Auditor</b><br>
<cfinput type="text" name="CTFAudits" size="10" data-bvalidator="required" data-bvalidator-msg="Average Number of Clients per CTF/CBTL Auditor"><br><br>

<input type="submit" value="Submit KPI Data">
<input type="reset" value="Reset Form"><br /><br />

</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->