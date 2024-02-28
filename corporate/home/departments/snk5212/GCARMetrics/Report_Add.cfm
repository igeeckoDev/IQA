<cfif cgi.HTTP_REFERER eq "http://usnbkiqas100p/departments/snk5212/GCARMetrics/getEmpNo.cfm?page=Report_Add">
	<cfset url.ReportType = "#form.EmpNo#">
</cfif>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Add a CAR Trend Report">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">	

<cfif NOT isDefined("URL.FunctionField") AND NOT isDefined("URL.Function") AND Not isDefined("URL.sortField")>
    <cfquery name="Categories" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, FunctionField, FunctionFieldName
    FROM GCAR_METRICS_CATEGORIES
    WHERE FunctionField <> 'CARState'
    ORDER BY ID
    </cfquery>
    
    <b>Select a Category</b><Br />
    Select a Category below to view available options:<br /><br />
    
    <cfoutput>
    <u>Custom CAR Grouping</u><br />
    If you would like to create a report from an existing Custom CAR Grouping (<A href="qGroup_Select.cfm">view here</A>), please <a href="GroupReport_Add.cfm?&ReportType=#url.ReportType#">follow this link</a>.<br /><br />
    </cfoutput>
    
    <u>Example</u>: If you wish to create a CAR Trend Report for PDE CARs, select Organization / Function below, then PDE on the following page.<br /><br />
    
    <cfoutput query="Categories">
    :: <a href="Report_Add.cfm?ReportType=#URL.ReportType#&FunctionField=#FunctionField#">#FunctionFieldName#</a><br />
    </cfoutput><Br />
<cfelseif isDefined("URL.FunctionField") AND NOT isDefined("URL.Function") AND Not isDefined("URL.sortField")>
	<b>Category</b><br />
	<cfoutput>#FunctionFieldName#</cfoutput><br><br>  
    
    <cfif url.FunctionField eq "CARProgramAffected">
		<!--- output every CARProgramAffected field from all CARs --->
        <CFQUERY BLOCKFACTOR="100" NAME="programs" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT CARProgramAffected 
        FROM GCAR_Metrics
        ORDER BY CARProgramAffected
        </cfquery>
    
    <!--- create a string/list of the results, the delimiter is !!  --->
		<cfset xyz = #ValueList(programs.CARProgramAffected, '!!')#>
        <!--- output original valuelist xyz
        <cfdump var="#xyz#">
        --->
        
        <!--- each field above may have more than one program listed, when this is true, the delimiter is |
        Some programs also have this value in place of a comma. We need to sub out these program names before we 
        replace the | delimiter with !! Each prog name will get a separate replacement value so we can put them back in appropriately later on --->
        <cfset xyz2 = #replace(xyz, "Nordic Certification Scheme (Denmark|Sweden|Norway|Finland)", "ABC", "All")#>
        <cfset xyz3 = #replace(xyz2, "Radio and Telecommunications Certification Body Program (USA|Canada|Singapore)", "DEF", "All")#>
        <cfset xyz4 = #replace(xyz3, "Ministry of Health|Labor and Welfare (MHLW) - PAL", "GHI", "All")#>
        <cfset xyz5 = #replace(xyz4, "UL Verification Mark for Transmission Performance of Copper Telecommunications Cabling|Levels XP Structured Cabling and Proprietary Structured Cabling", "JKL", "All")#>
        <cfset xyz6 = #replace(xyz5, "Vehicle Certification Agency (VCA)|U.K", "MNO", "All")#>
        <!--- replace all | delimiters in the entire string with !! --->
        <cfset xyz7 = #replace(xyz6, "|", "!!", "All")#>
        <!--- replace the substitution values with the program name, including commas this time --->
        <cfset xyz8 = #replace(xyz7, "ABC", "Nordic Certification Scheme (Denmark, Sweden, Norway, Finland)", "All")#>
        <cfset xyz9= #replace(xyz8, "DEF", "Radio and Telecommunications Certification Body Program (USA, Canada, Singapore)", "All")#>
        <cfset xyz10 = #replace(xyz9, "GHI", "Ministry of Health|Labor and Welfare (MHLW) - PAL", "All")#>
        <cfset xyz11 = #replace(xyz10, "JKL", "UL Verification Mark for Transmission Performance of Copper Telecommunications Cabling, Levels XP Structured Cabling and Proprietary Structured Cabling", "All")#>
        <cfset xyz12 = #replace(xyz11, "ULI Mark", "UL Mark", "All")#>
        <cfset finalString = #replace(xyz12, "MNO", "Vehicle Certification Agency (VCA), U.K", "All")#>
        
        <!--- Convert list to 1 column query var --->
        <cfset query = queryNew("val") />
        <cfloop list="#finalString#" index="i" delimiters="!!">
        <cfset queryAddRow(query) />
        <cfset querySetCell(query, "val", i) />
        </cfloop>
        
        <!--- Remove duplicates and sort results using query of query and "group by" --->
        <cfquery name="sortedQuery" dbtype="query">
        SELECT val, count(*) as numOcurrences
        FROM query
        GROUP BY val
        ORDER BY val
        </cfquery>
        
		Select the specific <cfoutput>#FunctionFieldName#</cfoutput>:<br>
        <cfoutput query="sortedQuery">
        :: <a href="Report_Add.cfm?ReportType=#URL.ReportType#&FunctionField=#url.FunctionField#&Function=#val#">#val#</a><br />
        </cfoutput>     
    <cfelse>
        <cfquery name="SelectFunction" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT DISTINCT #url.FunctionField# as qSelectFunction
        FROM GCAR_METRICS
        ORDER BY qSelectFunction
        </cfquery>
    
        Select the specific <b><cfoutput>#FunctionFieldName#</cfoutput></b>:<br><Br />
        
        <cfoutput query="SelectFunction">
        :: <a href="Report_Add.cfm?ReportType=#URL.ReportType#&FunctionField=#url.FunctionField#&Function=#qSelectFunction#">#qSelectFunction#</a><br />
        </cfoutput>
	</cfif>
<cfelseif isDefined("URL.FunctionField") AND isDefined("URL.Function") AND Not isDefined("URL.sortField")>
    <b>Category</b><br />
	<cfoutput>#FunctionFieldName#</cfoutput><br><br />
    
    <b>Value</b><br />
	<cfoutput>#url.Function#</cfoutput><br><br>

	<cfquery name="sortField" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, FunctionField as sortField, FunctionFieldName as SortFieldName
    FROM GCAR_METRICS_CATEGORIES
    WHERE FunctionField <> '#url.FunctionField#'
    AND (FunctionField <> 'CARRootCauseCategory' AND FunctionField <> 'CARSource' AND FunctionField <> 'CARState')
    ORDER BY ID
    </cfquery>
    
    Select how to sort <b><cfoutput>#url.Function#</cfoutput> CARs</b> in this report:<br><br />
    
    Note: CAR Source, CAR State, and Root Cause Category graphs are included when you create a report, therefore they are not available options below.<br /><br />
    
    <cfoutput query="sortField">
    :: <a href="Report_Add.cfm?ReportType=#url.ReportType#&FunctionField=#FunctionField#&Function=#url.Function#&sortField=#sortField#">#sortFieldName#</a><br />
    </cfoutput>
<cfelseif isDefined("URL.FunctionField") AND isDefined("URL.Function") AND isDefined("URL.sortField")>
    <cfoutput>
    <b>Category</b><br />
    #FunctionFieldName#<br /><br />
    
    <b>Value</b><br />
    #url.Function#<br /><br />
    
    <b>Sort Field</b><br />
    #sortFieldName#<br><br>
    
    <script language="JavaScript">
	<!--
	function func_name() {
    document.ReportForm.submit();
	}
	//-->
    </script>
    
    <form method="post" action="Report_Create.cfm?#CGI.Query_String#" name="ReportForm">
    <Cfif url.ReportType NEQ "QE">
    <b>Employee ID</b><br>
	<input maxlength="5" type="text" name="ReportType" value="#url.ReportType#" displayname="Employee ID"><br>
    Note - Only change this if you are saving this report for a coworker.<br /><br />
    <Cfelse>
    <input type="hidden" name="ReportType" value="#url.ReportType#" />
    </Cfif>
    
    Do you want to create this CAR Trend Report?<br />
    
    <input type="image" value="submitname" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Create Report" name="image"> <a href="javascript:func_name()">Create Report</a><Br />
    </form>

    <!---<a href="Report_Create.cfm?#CGI.Query_String#"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Create Report" /></a> <a href="Report_Create.cfm?#CGI.Query_String#">Create Report</a><br />--->
    
    <a href="Report.cfm"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_cross.png" border="0" alt="Cancel Report" /></a> <a href="Report.cfm">Cancel</a><br />
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->