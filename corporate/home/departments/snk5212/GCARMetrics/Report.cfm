<cfif isDefined("Form.EmpNo") AND len(Form.EmpNo)>
	<cfset URL.ReportType = "#Form.EmpNo#">
<cfelseif NOT isDefined("Form.EmpNo") OR NOT len(Form.EmpNo)>
	<cfif NOT isDefined("URL.ReportType") 
        OR isDefined("URL.ReportType") AND NOT len(URL.ReportType)>
            <cfset url.ReportType = "All">
    </cfif>
</cfif>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Index of CAR Trend Reports">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<u>Currently Viewing</u>:<Br />
	<cfif url.ReportType eq "All">
        :: <a href="getEmpNo.cfm?page=Report">My CAR Trend Reports</a><br />
        :: <b>All CAR Trend Reports</b><br />
        :: <a href="Report.cfm?ReportType=QE">Quality Engineering (QE) Supported CAR Trend Reports</a>
    <cfelseif url.ReportType eq "QE">
        :: <a href="getEmpNo.cfm?page=Report">My CAR Trend Reports</a><br />
        :: <a href="Report.cfm?ReportType=All">All CAR Trend Reports</a><br />
        :: <b>Quality Engineering (QE) Supported CAR Trend Reports</b>
    <cfelseif url.ReportType neq "QE">
        :: <b>My CAR Trend Reports (#url.ReportType#)</b><br />
        :: <a href="Report.cfm?ReportType=All">All CAR Trend Reports</a><br />
        :: <a href="Report.cfm?ReportType=QE">Quality Engineering (QE) Supported CAR Trend Reports</a>
    </cfif>
</cfoutput>
<br /><br />

<cfquery name="Reports" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Function, FunctionField, sortField, ReportType
FROM GCAR_METRICS_QREPORTS
<cfif isDefined("URL.ReportType")>
WHERE
	<cfif url.ReportType eq "All">
    1=1
    <cfelseif url.ReportType eq "QE">
    ReportType = 'QE'
    <cfelseif len(url.ReportType) AND url.ReportType neq "QE" AND url.ReportType neq "All">
    ReportType = '#url.ReportType#'
    </cfif>
AND Status IS NULL
</cfif>
ORDER BY FunctionField, SortField, Function
</cfquery>

<cflock scope="Session" timeout="6">
<!--- Check to see if user is logged in --->
<cfif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "Yes">
	<!--- Add Report Link --->
    <u>Quality Analyst - Available Actions</u><br />
    :: <a href="Report_Add.cfm?ReportType=QE">Add New Report</a><br />
    :: <a href="Report_Owners.cfm">Owner List / Email Owners</a><br />
    :: <a href="Report_ShowDeleted.cfm">View Deleted Reports</a><br />
    :: <a href="Report_ProgramRegions.cfm">View Program Regions</a><br />
<cfelse>
	<u>Available Actions</u><br />
	:: <a href="getEmpNo.cfm?page=Report_Add">Add New Report</a><br />
</cfif>
	:: <a href="Overview_TrendReports.cfm">CAR Trend Reports - FAQ / Overview</a><br /><br />
</cflock>

<u><b>CAR Trend Reports Available</b></u><br /><br />

<cfif Reports.RecordCount eq 0>
There are currently no 
<cfif url.ReportType EQ "All">
CAR Trend Reports
<cfelse>
	<cfif url.ReportType eq "QE">
    	Quality Engineering Supported CAR Trend Reports.
	<cfelseif url.ReportType neq "QE">
    	CAR Trend Reports for <cfoutput>#url.ReportType#</cfoutput>.
	</cfif>
</cfif>    
<cfelse>

<cfif isDefined("Form.EmpNo")>
    <cflock scope="SESSION" timeout="60">
        <cfset SESSION.Auth = StructNew()>
        <cfset SESSION.Auth.IsLoggedIn = "No">
        <cfset SESSION.Auth.AccessLevel = "UserReportManage">
        <cfset SESSION.Auth.IsLoggedInApp = "#this.Name#">
        <cfset SESSION.Auth.EmpNo = "#Form.EmpNo#">
        <cfset SESSION.Auth.Name = "#Form.EmpNo#">
    </cflock>
</cfif>

<cfset FunctionFieldHolder = "">
<cfset SortFieldHolder = "">

<cfoutput query="Reports">
<cfinclude template="shared/incVariables_Report.cfm">
<cfif FunctionFieldHolder IS NOT FunctionField>
    <cfIf len(FunctionFieldHolder)><br></cfif>
    <!--- translation from field name to label name - i.e., CARTypeNew = Process Impacted, etc --->
    <b>#FunctionFieldName#</b><br>
    <cfset sortFieldHolder = "">
</cfif>

<cfif SortFieldHolder IS NOT SortField>
	<cfif len(SortFieldHolder)><br /></cfif>
    #space2#<u>by #SortFieldName#</u><br />
</cfif>

#space# <a href="Report_Details.cfm?ID=#ID#">#Function#</a> <cfif url.ReportType EQ "All" OR ReportType eq "QE">(#ReportType#)</cfif><br>
<cfset FunctionFieldHolder = FunctionField>
<cfset sortFieldHolder = SortField>
</cfoutput><Br><br>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->