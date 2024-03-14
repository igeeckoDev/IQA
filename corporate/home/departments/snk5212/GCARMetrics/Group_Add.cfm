<cfif cgi.HTTP_REFERER eq "#request.serverProtocol##request.serverDomain#/departments/snk5212/GCARMetrics/getEmpNo.cfm?page=Group_Add">
	<cfif isDefined("Form.EmpNo")>
		<cfset url.ReportType = "#form.EmpNo#">
	</cfif>
</cfif>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "GCAR Metrics - Create Custom CAR Grouping - Add Group">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">

<cfif NOT isDefined("URL.FunctionField") AND NOT isDefined("URL.Function")>
    <cfquery name="Categories" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ID, FunctionField, FunctionFieldName
    FROM GCAR_METRICS_CATEGORIES
    WHERE FunctionField <> 'CARState'
    ORDER BY ID
    </cfquery>

    <b>Select a Category</b><Br />
    Select a category below to view available options:<br /><br />

    <u>Example</u>: If you wish to create a grouping of Canadian sites, select <u>Site Audited</u> below, then select each Canadian site on the following page.<br /><br />

    <cfoutput query="Categories">
    :: <a href="Group_Add.cfm?FunctionField=#FunctionField#">#FunctionFieldName#</a><br />
    </cfoutput><Br />
<cfelseif isDefined("URL.FunctionField") AND NOT isDefined("URL.Function")>
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

		Select the <b><cfoutput>#FunctionFieldName#</cfoutput></b> items you would like to group:<br>
        <cfform action="Group_Create.cfm?FunctionField=#url.FunctionField#">
            <cfoutput query="sortedQuery">
                 <cfinput type="checkbox" name="groupItems" value="#replace(val, ",", "!!", "All")#"> #val#<br />
            </cfoutput><br>
        <input type="Submit" name="Submit" Value="Submit Group Selections" />
        </cfform>
    <cfelse>
        <cfquery name="SelectFunction" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT DISTINCT #url.FunctionField# as qSelectFunction
        FROM GCAR_METRICS
        ORDER BY qSelectFunction
        </cfquery>

        Select the <b><cfoutput>#FunctionFieldName#</cfoutput></b> items you would like to group:<br><Br />
        <cfform action="Group_Create.cfm?FunctionField=#url.FunctionField#">
            <cfoutput query="SelectFunction">
            	<cfinput type="checkbox" name="groupItems" value="#replace(qSelectFunction, ",", "!!", "All")#">
                 #qSelectFunction#<br />
            </cfoutput><br>
        <input type="Submit" name="Submit" Value="Submit Group Selections" />
        </cfform>
    </cfif>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->