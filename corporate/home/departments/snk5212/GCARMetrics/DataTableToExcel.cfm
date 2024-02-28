<cfsavecontent variable="output">
	<cfcontent type="application/msexcel">
	<cfcontent type="text/html">
	
<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariableTitles.cfm">

<!--- perf variables --->
<cfinclude template="shared/incPerfVariables.cfm">

<!--- output search criteria --->
<cfinclude template="shared/incSearchCriteriaExcel.cfm">

<!--- when using custom groupings (from qGrouping.cfm), the queries are too different to include if/else statements in-line --->
<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm" 
	AND isDefined("URL.Group") AND isDefined("URL.GroupName") 
	OR 
	url.refPage eq "/departments/snk5212/GCARMetrics/qProgram_Grouping.cfm" 
	AND isDefined("URL.Group") AND isDefined("URL.GroupName")
	OR 
	url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm" 
	AND isDefined("URL.Group") AND isDefined("URL.GroupName")>
    
<!--- queries --->
<cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT groupName, groupType, ItemName
FROM GCAR_Metrics_Function_Grouping
WHERE groupName = '#url.groupName#'
AND groupType = '#url.var#'
ORDER BY itemName
</cfquery>

<cfset qCARCount.TotalCARs = 0>

<!--- create a query to store the itemName and the count for each row --->
<cfset newQuery = queryNew("RowID, ItemName, CountItem","Integer, VarChar, Integer")>

<!--- i will be used to store rowID's incase there is some confusion --->
<cfset i = 1> 
<cfoutput query="getItems">
	<!--- convert commas in program names to | for searching --->
    <cfset itemNameSearch = #replace(itemName, ", ", "|", "All")#>
    <!--- /// --->
    <cfquery name="getCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Count(*) as CountItem
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
		<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qProgram_Grouping.cfm">
	    	#url.var# LIKE '%#ItemName#%'
    	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
        	#url.var# = '#ItemName#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm">
            #url.var# = '#ItemName#'
            AND #url.var1# = '#url.var1Value#'
        </cfif> 
    <cfinclude template="shared/incManagerAndViewQuery.cfm">
    </cfquery>

	<!--- capture the total for the Current Data Set total --->
    <cfset qCARCount.TotalCARs = getCount.CountItem + qCARCount.TotalCARs>
    
    <!--- Add a new row to the query --->
    <cfset queryAddRow(newQuery)>
    <cfset querySetCell(newQuery, "RowID", i)>
    <cfset querySetCell(newQuery, "ItemName", "#ItemName#")>
    <cfset querySetCell(newQuery, "CountItem", "#getCount.CountItem#")>
    
    <!--- +1 for rowID's --->
    <cfset i = i + 1>
    
    <!--- sort the query we created --->
    <!--- the name of the item is ItemName, which is changed to itemVar when Cfoutput query="getItems" is run on approx line 125 --->
    <cfquery name="getItems" dbtype="query">
    SELECT *
    FROM newQuery
    ORDER BY CountItem DESC
    </cfquery>
</cfoutput>

<cfoutput>
<!--- Find last variable in url to show in table heading --->
<cfif IsDefined("url.var")>
	<cfset SearchHeading = "#Search#">
</cfif>

<!--- Number of columns for CAR Year: MaxYear - MinYear, used on line 53 below --->
<cfset varColumnYears = (#request.maxYear# - #Request.minYear#) + 1>
<!--- Add One for Total (or last two year comparison field) Column, used on line 25 --->
<cfset colspan = #varColumnYears# + 1>
<cfset colSpanPerf = #varColumnYears# + (varColumnYears * 2)>

<table border='1'>
	<tr align='center'>
		<th>&nbsp;</th>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = #colSpanPerf#>
		<cfelseif url.showPerf eq 'No'>
			<cfset colspan = #colSpan#>
		</cfif>
		<cfoutput>
		<th colspan='#colspan#'>Quantity of CARs</th>
		</cfoutput>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = 2>
		<cfelse>
			<cfset colspan = 1>
		</cfif>
		<cfif url.showPerf eq 'Yes'>
		<th colspan='#colspan#'>&nbsp;</th>
		</cfif>
	</tr>
	<tr>
		<th align='center' nowrap>#SearchHeading#</th>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = 3>
		<cfelse>
			<cfset colspan = 1>
		</cfif>
        <cfloop index='i' from='#Request.minYear#' to='#Request.maxYear#'>
			<th colspan='#colspan#' align='center'>#i#</th>
		</cfloop>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = 2>
		<cfelse>
			<cfset colspan = 1>
		</cfif>
        <cfset previousYear = #Request.maxyear# - 1>
		<th colspan='#colspan#' align='center'><cfif url.showPerf eq 'Yes'>#Request.maxYear# vs #previousYear#<cfelse>Total</cfif></th>
	</tr>
	
<cfif url.showPerf eq 'Yes'>
    <tr align="center">
        <th>&nbsp;</td>
        <cfloop index="i" from="1" to="#varColumnYears#">
            <th>CARs</td>
            <th>%</td>
            <th>&nbsp;</td>
        </cfloop>
        <!--- Total section --->
        <th>+/-</th>
    </tr>
</cfif>
</cfoutput>

<cfoutput query="getItems">
<tr class='blog-content' align='center' valign='top'>
	<td align='left'>#itemName#</td>
	<cfset qTotal = 0>
	<cfset perfTotal = 0>
    <cfloop index=i from=#Request.minYear# to=#Request.maxYear#>
        <cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Count(CARNumber) as CARCount
        FROM GCAR_Metrics
        WHERE 
        <cfinclude template="shared/incProgramQuery.cfm">
	        <cfif url.refPage eq "/departments/snk5212/GCARMetrics/qProgram_Grouping.cfm"
				AND isDefined("URL.Group") AND isDefined("URL.GroupName")>
                <!--- convert commas in program names to | for searching --->
    			<cfset itemNameSearch = #replace(itemName, ", ", "|", "All")#>
    			<!--- /// --->
	    	    #url.var# LIKE '%#itemNameSearch#%'
    		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm"
				AND isDefined("URL.Group") AND isDefined("URL.GroupName")>
	    	    #url.var# = '#itemName#'
                AND #url.var1# = '#url.var1Value#'
			<cfelse>
            	#url.var# = '#itemName#'
        	</cfif>
        AND CARYear = #i#
        <cfinclude template="shared/incManagerAndViewQuery.cfm">
        </cfquery>
		
        <cfif url.showPerf eq "Yes">
            <cfquery name='Perf' datasource='UL06046' username='UL06046' password='UL06046'>
            SELECT Count(CARNumber) as Count
            FROM GCAR_Metrics
            WHERE 
            <cfinclude template='shared/incProgramQuery.cfm'>
            #perfField# = '#perfVar#' AND
				<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qProgram_Grouping.cfm"
                    AND isDefined("URL.Group") AND isDefined("URL.GroupName")>
					<!--- convert commas in program names to | for searching --->
                    <cfset itemNameSearch = #replace(itemName, ", ", "|", "All")#>
                    <!--- /// --->
                    #url.var# LIKE '%#itemNameSearch#%'
				<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm"
                    AND isDefined("URL.Group") AND isDefined("URL.GroupName")>
                    #url.var# = '#itemName#'
                    AND #url.var1# = '#url.var1Value#'
                <cfelse>
                    #url.var# = '#itemName#'
                </cfif>
            AND CARYear = #i#
            <cfinclude template='shared/incManagerAndViewQuery.cfm'>
            </cfquery>
        </cfif>
		
		<cfinclude template="shared/incDataTableYearsExcel_ProgGroup.cfm">
	</cfloop>
		<cfinclude template="shared/incDataTableTotalsExcel.cfm">

	</tr>
</cfoutput>
</table>

<!--- for non grouping instances, when url.group does not exist or is exists and is No --->

<cfelse>

<!--- highest number url.var defines sort field, named dValue below--->
<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
	<cfset sortField = "#url.var#">
	<Cfset dValue = "d#url.var#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail.cfm" 
	OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Graph.cfm">
	<cfset sortField = "#url.var1#">
	<Cfset dValue = "d#url.var1#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail2.cfm" 
	OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm">
	<cfset sortField = "#url.var2#">
	<Cfset dValue = "d#url.var2#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail3.cfm">
	<cfset sortField = "#url.var3#">	
	<Cfset dValue = "d#url.var3#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail4.cfm">
	<cfset sortField = "#url.var4#">
	<Cfset dValue = "d#url.var4#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail5.cfm">
	<cfset sortField = "#url.var5#">
	<Cfset dValue = "d#url.var5#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail6.cfm">
	<cfset sortField = "#url.var6#">
	<Cfset dValue = "d#url.var6#">
<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail7.cfm">
	<cfset sortField = "#url.var7#">
	<Cfset dValue = "d#url.var7#">
</cfif>

<cfquery name="qDistinctResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
<!---SELECT DISTINCT #SortField# as #dValue#--->
SELECT Count(docID) as Count, #sortField# as #dValue#
FROM GCAR_Metrics
WHERE 
<cfinclude template="shared/incProgramQuery.cfm">
	<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
	1=1
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail.cfm" 
		OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Graph.cfm">
	#url.var# = '#url.varValue#'
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail2.cfm" 
		OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail3.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail4.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail5.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail6.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	AND #url.var5# = '#url.var5Value#'
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail7.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	AND #url.var5# = '#url.var5Value#'
	AND #url.var6# = '#url.var6Value#'
	</cfif>
<cfinclude template="shared/incManagerAndViewQuery.cfm">
GROUP BY #sortField#
<!--- ORDER BY #sortField# ASC --->
    <!--- Old (alphabetical sort): ORDER BY #url.var# ASC --->
	<cfif isDefined("URL.Sort")>
		<cfif url.sort eq "Total">
            ORDER BY Count DESC
        <cfelseif url.sort eq "Alpha">
            ORDER BY #url.var# ASC
        </cfif>
	<cfelse>
    	ORDER BY Count DESC
    </cfif>
</cfquery>

<cfoutput>
<!--- Find last variable in url to show in table heading --->
<cfif IsDefined("url.var")>
	<cfset SearchHeading = "#Search#">
</cfif>

<cfloop index="i" from="1" to="7">
	<cfif IsDefined("url.var#i#")>
		<cfset SearchHeading = "#Evaluate("Search#i#")#">
	</cfif>
</cfloop>

<!--- Number of columns for CAR Year: MaxYear - MinYear, used on line 53 below --->
<cfset varColumnYears = (#request.maxYear# - #Request.minYear#) + 1>
<!--- Add One for Total (or last two year comparison field) Column, used on line 25 --->
<cfset Colspan = #varColumnYears# + 1>
<cfset colSpanPerf = #varColumnYears# + (varColumnYears * 2)>

<table border='1'>
	<tr align='center'>
		<th>&nbsp;</th>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = #colSpanPerf#>
		<cfelseif url.showPerf eq 'No'>
			<cfset colspan = #colSpan#>
		</cfif>
		<cfoutput>
		<th colspan='#colspan#'>Quantity of CARs</th>
		</cfoutput>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = 2>
		<cfelse>
			<cfset colspan = 1>
		</cfif>
		<cfif url.showPerf eq 'Yes'>
		<th colspan='#colspan#'>&nbsp;</th>
		</cfif>
	</tr>
	<tr>
		<th align='center' nowrap>#SearchHeading#</th>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = 3>
		<cfelse>
			<cfset colspan = 1>
		</cfif>
        <cfloop index='i' from='#Request.minYear#' to='#Request.maxYear#'>
			<th colspan='#colspan#' align='center'>#i#</th>
		</cfloop>
		<cfif url.showPerf eq 'Yes'>
			<cfset colspan = 2>
		<cfelse>
			<cfset colspan = 1>
		</cfif>
        <cfset previousYear = #Request.maxyear# - 1>
		<th colspan='#colspan#' align='center'><cfif url.showPerf eq 'Yes'>#Request.maxYear# vs #previousYear#<cfelse>Total</cfif></th>
	</tr>
	
<cfif url.showPerf eq "Yes">
    <tr align="center">
        <th>&nbsp;</td>
        <cfloop index="i" from="1" to="#varColumnYears#">
            <th>CARs</td>
            <th>%</td>
            <th>&nbsp;</td>
        </cfloop>
        <!--- Total section --->
        <th>+/-</th>
    </tr>
</cfif>
</cfoutput>

<cfoutput query="qDistinctResult">
<tr class='blog-content' align='center' valign='top'>
	<td align='left'>#evaluate("#dValue#")#</td>
	<cfset qTotal = 0>
	<cfset perfTotal = 0>
	<cfloop index=i from=#Request.minYear# to=#Request.maxYear#>
		<cfquery name='qResult' datasource='UL06046' username='UL06046' password='UL06046'>
		SELECT Count(#sortField#) as CARCount, CARYear, #sortField#
		FROM GCAR_Metrics
		WHERE 
		<cfinclude template='shared/incProgramQuery.cfm'>
		<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
		#sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail.cfm" 
			OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Graph.cfm">
		#url.var# = '#url.varValue#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail2.cfm" 
			OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail3.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail4.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail5.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #url.var4# = '#url.var4Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail6.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #url.var4# = '#url.var4Value#'
		AND #url.var5# = '#url.var5Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail7.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #url.var4# = '#url.var4Value#'
		AND #url.var5# = '#url.var5Value#'
		AND #url.var6# = '#url.var6Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		</cfif>
		AND CARYear = #i#
		<cfinclude template='shared/incManagerAndViewQuery.cfm'>
		GROUP BY #sortField#, CARYear
		</cfquery>
		
		<cfquery name='Perf' datasource='UL06046' username='UL06046' password='UL06046'>
		SELECT Count(CARNumber) as Count
		FROM GCAR_Metrics
		WHERE 
		<cfinclude template='shared/incProgramQuery.cfm'>
			<cfif url.showPerf eq "Yes">
				#perfField# = '#perfVar#' AND
			</cfif>
		<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
		#sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail.cfm" 
			OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Graph.cfm">
		#url.var# = '#url.varValue#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail2.cfm" 
			OR url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail3.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail4.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail5.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #url.var4# = '#url.var4Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail6.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #url.var4# = '#url.var4Value#'
		AND #url.var5# = '#url.var5Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail7.cfm">
		#url.var# = '#url.varValue#'
		AND #url.var1# = '#url.var1Value#'
		AND #url.var2# = '#url.var2Value#'
		AND #url.var3# = '#url.var3Value#'
		AND #url.var4# = '#url.var4Value#'
		AND #url.var5# = '#url.var5Value#'
		AND #url.var6# = '#url.var6Value#'
		AND #sortField# = '#Evaluate("#dValue#")#'
		</cfif>
		AND CARYear = #i#
		<cfinclude template='shared/incManagerAndViewQuery.cfm'>
		</cfquery>
		
		<cfinclude template="shared/incDataTableYearsExcel.cfm">
	</cfloop>
		<cfinclude template="shared/incDataTableTotalsExcel.cfm">

	</tr>
</cfoutput>
</table>

<!--- end of qGrouping.cfm if/else --->
</cfif>

<br><br>

<cfif url.showPerf eq "Yes">
<cfoutput>
<table>
<tr>
	<td colspan='12'>
		<b>CAR Performance Legend</b><br>
		For CARs with <B>#perfvarLabel#</B><br>
	</td>
</tr>
<tr>
	<td colspan='12'> <font color="green">Green</font> ( + ) - Greater than or equal to #NumberFormat(green * 100, "999.9")#% - Acceptable</td>
</tr>
<tr>
	<td colspan='12'> Yellow ( - ) - Less than #NumberFormat(green * 100, "999.9")#% and greater than or equal to #NumberFormat(red * 100, "999.9")#% - Improvement Recommended
</tr>	
<tr>
	<td colspan='12'> <font color="Red">Red</font> ( ! ) - Less than #NumberFormat(red * 100, "999.9")#% - Improvement Required
</tr>
</table>
</cfoutput>
</cfif>

<cfheader name="Content-Disposition" value="attachment; filename=DataTableOutput.xls">

</cfsavecontent>

<cfoutput>#output#</cfoutput>