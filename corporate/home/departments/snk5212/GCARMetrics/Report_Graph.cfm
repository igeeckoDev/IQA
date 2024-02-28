<cfparam name="url.top" default="-1">

<cfif isDefined("url.top")>
	<cfset top = url.top>
<cfelse>
	<cfif url.sortField eq "CARState">
        <cfset top = url.top>
    <cfelse>
		<cfset url.top = 5>
    	<cfset top = url.top>
	</cfif>
</cfif>

<cfinclude template="shared/incVariables_Report.cfm">

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - View <a href='Report_Details.cfm?ID=#URL.ID#'>#url.Function#</a> Report - CARs by Top #url.top# #SortFieldName#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<h1 align="center">
<cfif url.sortField eq "CARState">
	#url.Function# CARs by #SortFieldName#
<cfelse>
	#url.Function# CARs by Top #Top# #SortFieldName#
</cfif>
</h1>
</cfoutput>
<br />

<cfif isDefined("URL.Group") AND url.Group eq "Yes">
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT groupName, groupType, ItemName
    FROM GCAR_Metrics_Function_Grouping
    WHERE groupName = '#url.function#'
    AND groupType = '#url.functionField#'
    ORDER BY itemName
    </cfquery>
</cfif>

<cfquery name="Graph" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" maxrows="#url.top#">
SELECT Count(*) as qYrTotal, #url.sortField# as varSortField
FROM GCAR_Metrics
WHERE CARYear BETWEEN #Request.minYear# AND #Request.maxYear#
AND
<cfif isDefined("URL.Group") AND url.Group eq "Yes">
	<!--- check where we are in the loop --->
	<cfset z = 1>
    <!--- loop through items in getItems query --->
	(<cfloop query="getItems" endRow="#getItems.RecordCount#">
    	<cfif url.functionField eq "CARProgramAffected">
        	<cfif url.function eq "UL Mark">
	        	<!--- all iterations of UL Mark and ULI Mark in a string --->
                <!--- OLD
                #url.FunctionField# LIKE '%UL Mark%'
                OR #url.FunctionField# LIKE '%ULI Mark%'
				--->
                <!--- NEW --->
               	#url.FunctionField# NOT LIKE '%c-UL Mark%'
				AND #url.FunctionField# NOT LIKE '%UL Mark for%'
				AND (#url.FunctionField# LIKE '%ULI Mark%' OR #url.FunctionField# LIKE '%UL Mark%')
                <!--- /// --->
        	<cfelse>
            	#url.FunctionField# LIKE '%#itemName#%'
            </cfif>
		<cfelse>
	        #url.FunctionField# = '#itemName#'
    	</cfif>
        <!--- add OR for all but the last loop --->
        <cfif z LT getItems.recordcount>OR</cfif>
        <!--- +1 to counter --->
        <cfset z = z+1>
    </cfloop>)
<cfelse>
	<cfif url.FunctionField eq "CARProgramAffected">
        <cfif url.function eq "UL Mark">
			<!--- all iterations of UL Mark and ULI Mark in a string --->
            <!--- OLD
            #url.FunctionField# LIKE '%UL Mark%'
            OR #url.FunctionField# LIKE '%ULI Mark%'
            --->
            <!--- NEW --->
            #url.FunctionField# NOT LIKE '%c-UL Mark%'
            AND #url.FunctionField# NOT LIKE '%UL Mark for%'
            AND (#url.FunctionField# LIKE '%ULI Mark%' OR #url.FunctionField# LIKE '%UL Mark%')
            <!--- /// --->
        <cfelse>
        	#url.FunctionField# LIKE '%#url.function#%'
        </cfif>
    <cfelse>
    	#url.FunctionField# = '#url.Function#'
    </cfif>
</cfif>
AND #url.sortField# <> 'None Listed'
GROUP BY #url.sortField#
ORDER BY qYrTotal DESC, #url.sortField#
</cfquery>

<!--- set 'url.top' value if the sortfield is CARState, in order to show all CAR States --->
<cfif url.sortField is "CARState">
	<cfset top = Graph.RecordCount>
</cfif>

<!--- Create an array --->
<cfset arrGraphData = ArrayNew(2)>

<!--- set the max value variable for later use --->
<cfset varMaxValue = 0>

<!--- if there are 5 years of data, cfloop_to will be 6 (to include TOTAL column). if there are 4 years of data, cfloop_to will be 5 --->
<cfset cfloop_to = ((#Request.maxYear# - #Request.minYear#) + 1) + 1>

<!--- Now populate the array with all "0" - this is to catch empty arrays later --->
<cfloop from="1" to="#top#" index="i">
	<cfloop from="1" to="#cfloop_to#" index="j">
		<cfset arrGraphData[i][j] = "0"><!--- 1=url.sortField, 2=minYear year, 3=+1, 4=+1, 5=maxYear --->
	</cfloop>
</cfloop>

<cfset currentRowLoop = 2>

<cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
	<cfoutput query="Graph">
        <!--- define variable to name the arrGraphData[currentrow][x] variable. x should be 5, 4, 3, 2 --->
        <cfset arrGraphData[currentrow][1] = "#varSortField#">

        <cfquery name="GraphYr" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Count(*) as qYrTotal, #url.sortField#
        FROM GCAR_Metrics
        WHERE CARYear = #i#
        AND #url.sortField# = '#varSortField#'
        AND
		<cfif isDefined("URL.Group") AND url.Group eq "Yes">
            <!--- check where we are in the loop --->
            <cfset z = 1>
            <!--- loop through items in getItems query --->
            (<cfloop query="getItems" endRow="#getItems.RecordCount#">
                <cfif url.functionField eq "CARProgramAffected">
                    <cfif url.function eq "UL Mark">
						<!--- all iterations of UL Mark and ULI Mark in a string --->
                        <!--- OLD
                        #url.FunctionField# LIKE '%UL Mark%'
                        OR #url.FunctionField# LIKE '%ULI Mark%'
                        --->
                        <!--- NEW --->
                        #url.FunctionField# NOT LIKE '%c-UL Mark%'
                        AND #url.FunctionField# NOT LIKE '%UL Mark for%'
                        AND (#url.FunctionField# LIKE '%ULI Mark%' OR #url.FunctionField# LIKE '%UL Mark%')
                        <!--- /// --->
                    <cfelse>
                        #url.FunctionField# LIKE '%#itemName#%'
                    </cfif>
                <cfelse>
                    #url.FunctionField# = '#itemName#'
                </cfif>
                <!--- add OR for all but the last loop --->
                <cfif z LT getItems.recordcount>OR</cfif>
                <!--- +1 to counter --->
                <cfset z = z+1>
            </cfloop>)
        <cfelse>
			<cfif url.FunctionField eq "CARProgramAffected">
                <cfif url.function eq "UL Mark">
					<!--- all iterations of UL Mark and ULI Mark in a string --->
                    <!--- OLD
                    #url.FunctionField# LIKE '%UL Mark%'
                    OR #url.FunctionField# LIKE '%ULI Mark%'
                    --->
                    <!--- NEW --->
                    #url.FunctionField# NOT LIKE '%c-UL Mark%'
                    AND #url.FunctionField# NOT LIKE '%UL Mark for%'
                    AND (#url.FunctionField# LIKE '%ULI Mark%' OR #url.FunctionField# LIKE '%UL Mark%')
                    <!--- /// --->
                <cfelse>
                	#url.FunctionField# LIKE '%#url.function#%'
                </cfif>
            <cfelse>
            	#url.FunctionField# = '#url.Function#'
            </cfif>
        </cfif>
        GROUP BY #url.sortField#
        ORDER BY qYrTotal DESC, #url.sortField#
        </cfquery>

        <cfif len(GraphYr.qYrTotal)>
            <cfset arrGraphData[currentrow][currentRowLoop] = "#GraphYr.qYrTotal#">
                <!--- find and set max value --->
                <cfif GraphYr.qYrTotal gt varMaxValue>
                    <cfset varMaxValue = #GraphYr.qYrTotal#>
                </cfif>
        <cfelse>
            <cfset arrGraphData[currentrow][currentRowLoop] = "0">
        </cfif>
    </cfoutput>
    <cfset currentRowLoop = currentRowLoop + 1>
</cfloop>

<cfif url.sortField eq "CARState">
	<cfset varChartWidth = 650>
<cfelse>
	<cfif top lte 5>
        <cfset varChartWidth = 650>
    <cfelseif top gt 5>
        <cfset varChartWidth = 650 + ((url.top - 5) * 50)>
    </cfif>
</cfif>

<!--- add 5 to the max value so the max value bar in the graph is not at the very TOP of the y axis --->
<cfset varScaleToValue = varMaxValue + 1>

<cfChart
	scaleto="#varScaletoValue#"
    chartheight="400"
    chartwidth="#varChartWidth#"
    format="#url.format#"
    showxgridlines="yes"
    showygridlines="yes"
    showlegend="yes">

    <!---title="#url.Function# - Top #url.Top# CARs by #SortFieldName#"--->

    <!--- set yearSelect for loop --->
    <cfset yearSelect = #Request.minYear#>
    <!--- loop to create all chartseries and chartdata items --->
    <cfloop index="j" from="2" to="#cfloop_to#">
    	<!--- bar chart colors --->
        <cfif j eq 2>
        	<cfset seriesColor = "FF9900">
        <cfelseif j eq 3>
        	<cfset seriesColor = "339900">
        <cfelseif j eq 4>
        	<cfset seriesColor = "6699CC">
        <cfelseif j eq 5>
        	<cfset seriesColor = "FF4040">
        <cfelseif j eq 6>
        	<cfset seriesColor = "660198">
        </cfif>

        <cfChartSeries
            type="bar"
            <!--- Year --->
            serieslabel="#yearSelect#"
            <!--- color --->
            seriescolor="###seriesColor#">
                <cfloop index="i" from="1" to="#arrayLen(arrGraphData)#">
                    <cfchartdata item="#arrGraphData[i][1]#" value="#arrGraphData[i][j]#">
                </cfloop>
        </cfChartSeries>

        <cfset yearSelect = yearSelect + 1>
    </cfloop>
</cfChart>
<Br /><br />

<cfoutput>
<cfsavecontent variable="DataTableOutput">
<table border="1">
	<tr class="blog-title">
    	<Cfset var_colspan = 1 + #cfloop_to#>
    	<td colspan="#var_colspan#" align="center">
        	#url.Function# -<cfif url.SortField neq "CARState"> Top #Top#</cfif> CARs by #SortFieldName#
        </td>
    </tr>
	<tr class="blog-title">
    	<td align="center">#sortFieldName#</td>
        <cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
        	<td align="center">#i#</td>
		</cfloop>
        <td align="center">Total</td>
    </tr>
	<cfloop index="i" from="1" to="#arrayLen(arrGraphData)#">
    <tr class="blog-content">
		<cfloop index="j" from="1" to="#cfloop_to#">
        	<td>#arrGraphData[i][j]#</td>
        </cfloop>
        <cfset Total = arrGraphData[i][2] + arrGraphData[i][3] + arrGraphData[i][4] + arrGraphData[i][5]>
		<cfif cfloop_to eq 6>
        	<cfset Total = Total + arrGraphData[i][6]>
        </cfif>
        <Td><b>#Total#</b></Td>
	</tr>
    </cfloop>
</table><br />
</cfsavecontent>

#DataTableOutput#

<cfif url.sortField eq "CARRootCauseCategory">
<span class="warning">Note - 'Root Cause not Required' is the Root Cause Category for all Observation CARs</span>
<br /><br />
</cfif>

<u>User Options</u> - Click an icon/link below to execute each action.<br />
<cfset xls_filename = "DataTableOutput_#dateformat(now(), 'mmddyyyy')#_#timeformat(now(), 'hhmmss')#.xls">
<CFSET fullfile = "#GCARMetricsPath#xls\#xls_filename#">
<cffile action = "write"
         file = "#fullfile#"
         output = "#DataTableOutput#"
         nameconflict="overwrite">
        :: <a target="_blank" href="xls/#xls_filename#"><img src="#SiteDir#SiteImages/folder_up.png" border="0" align="absmiddle" Alt="Save data table to Excel" /></a> - Save data table to Excel<br />
		:: <a target="_blank" href="QueryToExcel.cfm?View=All&Manager=None&Type=All&var=#url.FunctionField#&varValue=#url.Function#&var1=#url.sortField#&refpage=#CGI.Script_Name#&FullTable=Yes"><img src="#SiteDir#SiteImages/table_row.png" border="0" align="absmiddle" Alt="View CARs in Excel" /></a> - View CARs in data table in Excel<br />
		:: Change Chart Format -
[<cfif url.format eq "flash">
	<cfset newQuery_String = replace(cgi.QUERY_STRING, "format=flash", "format=jpg", "All")>
	<b>Flash</b> :: <a href="#cgi.script_name#?#newQuery_String#">JPG</a>
<cfelseif url.format eq "jpg">
	<cfset newQuery_String = replace(cgi.QUERY_STRING, "format=jpg", "format=flash", "All")>
	<a href="#cgi.script_name#?#newQuery_String#">Flash</a> :: <b>JPG</b>
</cfif>]
<br />

<!--- change the number of items in the graph - i.e., top 3, 5, etc --->
<!--- all items are shown for CARState, so this does not apply to that graph --->
<cfif url.sortField NEQ "CARState">
<!--- how long is url.top? --->
	<cfif top eq 10>
        <cfset varCutQueryStringLength = 7>
    <cfelse>
        <cfset varCutQueryStringlength = 6>
    </cfif>

<!--- new string length = original string length minus length of url.top --->
<cfset newQueryStringLength = (len(cgi.QUERY_STRING) - varCutQueryStringLength)>

<!--- new query string using above string length --->
<cfset newQueryString = left(cgi.QUERY_STRING, newQueryStringLength)>

<!--- drop down to change url.top value --->
:: Change number of "Top Items" shown in chart:<br />
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
<cfloop index="i" from="1" to="10">
		<OPTION VALUE="#cgi.script_name#?#newQueryString#&top=#i#">#i#</OPTION>
</cfloop>
</SELECT>
<Br />
</cfif>
<Br />

<u>Help</u><br />
:: <a href="Overview_TrendReports.cfm">CAR Trend Reports Overview</a><br /><br />
<!--- /// --->
</cfoutput>

<cfquery name="ShowComments" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID,
<cfif url.sortField eq "CARSource" OR url.sortField eq "CARState" OR url.sortField eq "CARRootCauseCategory">
<!--- build the fieldname, i.e., CARSourceComments, CARStateComments, CARRootCauseComments (#url.sortField#+Comments) --->
#url.sortField#Comments as Comments
<cfelse>
<!--- Something other than CARSource or CARState indicates this is the "Top Issues" Graph --->
TopIssuesComments as Comments
</cfif>
FROM GCAR_METRICS_QREPORTS
WHERE
ID = #URL.ID#
<!--- FunctionField = '#url.FunctionField#'
AND Function = '#url.Function#' --->
</cfquery>

<cfoutput>
	<!--- build the fieldname for add/edit comments links, i.e., CARSourceComments, CARStateComments (#url.sortField#+Comments) --->
    <cfif url.sortField eq "CARSource" OR url.sortField eq "CARState" OR url.sortField eq "CARRootCauseCategory">
        <cfset urlComments = "#url.sortField#Comments">
    <cfelse>
    <!--- Something other than CARSource or CARState indicates this is the "Top Issues" Graph --->
        <cfset urlComments = "TopIssuesComments">
    </cfif>
</cfoutput>

<cfoutput query="ShowComments">
<cflock scope="Session" timeout="6">
<!--- Check to see if user is logged in --->
<cfif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "Yes">
	<!--- Show Comments --->
    <b>Quality Analysis - Comments</b><br />
	<cfif isDefined("Comments") AND len(Comments)>
    #Comments#
    <cfelse>
    None Listed
    </cfif><br /><br />

    <!--- Show available admin actions - add/edit --->
	<u>Quality Analyst - Available Actions</u><br />
    <!--- Add new notes and store current notes in history --->
    :: <a href="Report_Details_Notes.cfm?Type=#urlComments#&ID=#ID#&Action=Add">Add New</a> Comments<br />
    <!--- check for existing notes - edit current note --->
    <cfif isDefined("Comments") AND len(Comments)>
    :: <a href="Report_Details_Notes.cfm?Type=#urlComments#&ID=#ID#&Action=Edit">Edit Current</a> Comments<br />
    </cfif>
    <!--- Change number of top issues - all items are shown for CARState, so this does not apply if the url.sortField is CARState --->
	<cfif url.sortField NEQ "CARState">
    :: <a href="Report_ChangeTop.cfm?ID=#ID#&sortField=#url.sortField#">Change</a> Quantity of Top #sortFieldName# Items Shown in Graph<br />
    :: <a href="Report_ViewHistory.cfm?ID=#ID#">View</a> Comment History<br />
    </cfif>
    :: <a href="Report_EmailOwner.cfm?ID=#ID#">Email</a> Owner<br />
    <Br />

<!--- If not logged in, show comments (if any) --->
<cfelse>
	<!--- Show Comments (if any) --->
	<cfif isDefined("Comments") AND len(Comments)>
    <b>Quality Analysis - Comments</b><br />
    #Comments#
    </cfif><br /><br />
</cfif>
</cflock>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->