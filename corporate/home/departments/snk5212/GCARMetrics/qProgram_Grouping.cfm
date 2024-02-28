<!--- set values for url variables for page 
and subTitle / subTitle2 for StartOfPage.cfm --->
<cfinclude template="shared/incVariables.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariableTitles.cfm">

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
    <cfquery name="getCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Count(*) as CountItem
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
    CARProgramAffected LIKE '%#ItemName#%'
    <cfinclude template="shared/incManagerAndViewQuery.cfm">
    </cfquery>
    
    <cfset qCARCount.TotalCARs = getCount.CountItem + qCARCount.TotalCARs>
    
    <!--- Add a new row to the query --->
    <cfset queryAddRow(newQuery)>
    <cfset querySetCell(newQuery, "RowID", i)>
    <cfset querySetCell(newQuery, "ItemName", "#ItemName#")>
    <cfset querySetCell(newQuery, "CountItem", "#getCount.CountItem#")>
    
    <!--- +1 for rowID's --->
    <cfset i = i + 1>
</cfoutput>
    
<!--- sort the query we created --->
<!--- the name of the item is ItemName, which is changed to itemVar when Cfoutput query="getItems" is run on approx line 125 --->
<cfquery name="getItems" dbtype="query">
SELECT *
FROM newQuery
ORDER BY CountItem DESC
</cfquery>

<cfoutput>
<cfinclude template="shared/incPerfVariables.cfm">

<!--- changing and removing URL parameters for adding/changing CAR Performance, Classification, CAR Status --->
	<cfif isDefined("URL.Group") AND url.Group eq "Yes">
        <cfset groupURLitems = "Group=#URL.Group#&GroupName=#URL.groupName#">
    <cfelse>
		<cfset groupURLitems = "">
    </cfif>

	<!--- all url variables = view, manager, program, type, var --->
    <cfset queryString1 = "View=#url.View#&Manager=#url.Manager#&Program=#Url.Program#&Type=#url.Type#&var=#url.var#&#groupURLitems#">
    
	<!--- url.view is removed --->
    <cfset viewParams = "" />
    <cfloop list="#cgi.query_string#" delimiters="&" index="i">
        <cfif listFirst(i, "=") neq "View" 
			AND listFirst(i, "=") neq "showPerf" 
			AND listFirst(i, "=") neq "perfVar" 
			AND listFirst(i, "=") neq "Perf">
            <cfset viewParams = listAppend(viewParams, i, "&") />
        </cfif>
    </cfloop>
    
    <cfset queryStringViewChange = "#viewParams#">
    
	<!--- url.type is removed --->
    <cfset typeParams = "" />
    <cfloop list="#cgi.query_string#" delimiters="&" index="i">
        <cfif listFirst(i, "=") neq "Type"
			AND listFirst(i, "=") neq "showPerf" 
			AND listFirst(i, "=") neq "perfVar" 
			AND listFirst(i, "=") neq "Perf">
            <cfset typeParams = listAppend(typeParams, i, "&") />
        </cfif>
    </cfloop>

	<cfset queryStringTypeChange = "#typeParams#">
<!--- /// --->

<cfinclude template="shared/incSearchCriteria.cfm">
</cfoutput>

<cfinclude template="shared/incTableHeader.cfm">

	<Cfoutput query="getItems">
        <tr class="blog-content" align="center" valign="top">
            <td align="left">#itemName#</td>
            <!--- convert commas in program names to | for searching --->
			<cfset itemNameSearch = #replace(itemName, ", ", "|", "All")#>
			<!--- /// --->
			<cfset qTotal = 0>    
            <cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
                <cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT Count(CARNumber) as CARCount
                FROM GCAR_Metrics
                WHERE 
                <cfinclude template="shared/incProgramQuery.cfm">
                CARProgramAffected LIKE '%#itemNameSearch#%'
                AND CARYear = #i#
                <cfinclude template="shared/incManagerAndViewQuery.cfm">
                </cfquery>
                
                <cfif url.showPerf eq "Yes">
                    <cfquery name="Perf" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                    SELECT Count(CARNumber) as Count
                    FROM GCAR_Metrics
                    WHERE 
                    <cfinclude template="shared/incProgramQuery.cfm">
                    CARProgramAffected LIKE '%#itemNameSearch#%'
                    AND #perfField# = '#perfVar#'
                    AND CARYear = #i#
                    <cfinclude template="shared/incManagerAndViewQuery.cfm">
                    </cfquery>
                </cfif>
            
            	<!--- incDataTableYears --->
                <cfinclude template="shared/incDataTableYears_ProgGroup.cfm">
            </cfloop>
                <cfinclude template="shared/incDataTableTotals.cfm">
				<td>
<!--- Search Array and Drop Down for Drill Down Menu Items --->
<cfinclude template="shared/incSearchArray.cfm">

<!--- evaluate if url has perf variables. if showperf = yes, include perf and perfvar--->
<cfinclude template="shared/incPerfString.cfm">

<cfset querystring2 = "View=#url.View#&Manager=#url.Manager#&Program=#ItemNameSearch#&Type=#url.Type#">

<cfif qTotal gt 0>
    <SELECT NAME="CriteriaSelect" ONCHANGE="location = this.options[this.selectedIndex].value;">
        <option value="javascript:document.location.reload();">Select Search Criteria
        <option value="javascript:document.location.reload();">
            <cfloop index="i" to="8" from="1">
                <cfif url.var neq varSearch[i][2]>
                    <OPTION VALUE="qManager.cfm?#queryString2#&var=#varSearch[i][2]#&#perfString#">#varSearch[i][1]#
                </cfif>
            </cfloop>
    </SELECT>
<cfelse>
N/A - No CARs Found
</cfif>
				</td>
				<!--- View Data --->
				<td valign="middle">
                	<cfif qTotal gt 0>
                        <a href="QueryToExcel.cfm?#queryString2#&refPage=#CGI.Script_Name#">
                            <img src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0">
                        </a>
                    <cfelse>
                    	--
					</cfif>
				</td>
			</tr>
		</cfoutput>
	</table>
	
<cfinclude template="shared/incSaveQuery.cfm">
	
<cfinclude template="shared/incPerfLinks.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->