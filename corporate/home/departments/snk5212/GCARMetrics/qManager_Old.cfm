<!--- set values for url variables for page 
and subTitle / subTitle2 for StartOfPage.cfm --->
<cfinclude template="shared/incVariables.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariableTitles.cfm">

<cfif isDefined("URL.Group") AND url.Group eq "Yes">
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT groupName, groupType, ItemName
    FROM GCAR_Metrics_Function_Grouping
    WHERE groupName = '#url.groupName#'
    AND groupType = '#url.var#'
    ORDER BY itemName
    </cfquery>
    
    <cfset qCARCount.TotalCARs = 0>
    
    <cfoutput query="getItems">
        <cfquery name="getCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Count(*) as CountItem
        FROM GCAR_Metrics
        WHERE 
        <cfinclude template="shared/incProgramQuery.cfm">
       	#url.var# = '#ItemName#'
        <cfinclude template="shared/incManagerAndViewQuery.cfm">
        </cfquery>
    
        <cfset qCARCount.TotalCARs = getCount.CountItem + qCARCount.TotalCARs>
    </cfoutput>
<cfelse>
	<!--- url.var defines sort field --->
	<Cfset dValue = "d#url.var#">

    <!--- Total Number of CARs found during the search --->
    <cfquery name="qCARCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Count(*) as TotalCARs
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
    <!--- url.var and url.varValue goes here on subsequent pages --->
    <cfinclude template="shared/incManagerAndViewQuery1.cfm">
    </cfquery>
    
    <!--- order distinct items by the number of CARs in the "Total" column
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Count(docID) as Count, #url.var#
    FROM GCAR_Metrics
    WHERE
    <cfinclude template="shared/incProgramQuery.cfm">
    <!--- url.var and url.varValue goes here on subsequent pages --->
    <cfinclude template="shared/incManagerAndViewQuery1.cfm">
    GROUP BY #url.var#
    ORDER BY Count DESC
    </cfquery>
    --->
    
    <!--- Get list of distinct values in order to loop through and count --->
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT DISTINCT #url.var# as d#url.var#
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
    <!--- url.var and url.varValue goes here on subsequent pages --->
    <cfinclude template="shared/incManagerAndViewQuery1.cfm">
    GROUP BY #url.var#
    ORDER BY #url.var# ASC
    </cfquery>
</cfif>

<cfoutput>
<cfinclude template="shared/incPerfVariables.cfm">

<!--- changing and removing URL parameters for adding/changing CAR Performance, Classification, CAR Status --->
	<cfif isDefined("URL.Group") AND url.Group eq "Yes">
        <cfset groupURLitems = "Group=#URL.Group#&GroupName=#URL.groupName#">
    <cfelse>
		<cfset groupURLitems = "">
    </cfif>

	<!--- all url variables = view, manager, program, type, var --->
    <cfset queryString1 = "View=#url.View#&Manager=#url.Manager#&Program=#Url.Program#&Type=#url.Type#&var=#url.var##groupURLitems#">
    
	<!--- url.view is removed --->
    <cfset viewParams = "" />
    <cfloop list="#cgi.query_string#" delimiters="&" index="i">
        <cfif listFirst(i, "=") neq "View" AND listFirst(i, "=") neq "showPerf">
            <cfset viewParams = listAppend(viewParams, i, "&") />
        </cfif>
    </cfloop>
    
    <cfset queryStringViewChange = "#viewParams#">
    
	<!--- url.type is removed --->
    <cfset typeParams = "" />
    <cfloop list="#cgi.query_string#" delimiters="&" index="i">
        <cfif listFirst(i, "=") neq "Type" AND listFirst(i, "=") neq "showPerf">
            <cfset typeParams = listAppend(typeParams, i, "&") />
        </cfif>
    </cfloop>

	<cfset queryStringTypeChange = "#typeParams#">
<!--- /// --->

<cfinclude template="shared/incSearchCriteria.cfm">
</cfoutput>

<cfinclude template="shared/incTableHeader.cfm">

	<Cfoutput query="getItems">
		<cfif isDefined("URL.Group") AND url.Group eq "Yes">
            <cfset itemVar = itemName>
        <cfelse>
            <cfset itemVar = Evaluate("#dValue#")>
        </cfif>
    
        <tr class="blog-content" align="center" valign="top">
            <td align="left">#itemVar#</td>
			<cfset qTotal = 0>
            <cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
                <cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT Count(#url.var#) as CARCount, CARYear, #url.var#
                FROM GCAR_Metrics
                WHERE 
				<cfinclude template="shared/incProgramQuery.cfm">
                #url.var# = '#ItemVar#'
                AND CARYear = #i#
                <cfinclude template="shared/incManagerAndViewQuery.cfm">
                GROUP BY #url.var#, CARYear
                </cfquery>
                
                <cfif url.showPerf eq "Yes">
                    <cfquery name="Perf" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                    SELECT Count(CARNumber) as Count
                    FROM GCAR_Metrics
                    WHERE 
                    <cfinclude template="shared/incProgramQuery.cfm">
                    #url.var# = '#ItemVar#'
                    AND #perfField# = '#perfVar#'
                    AND CARYear = #i#
                    <cfinclude template="shared/incManagerAndViewQuery.cfm">
                    </cfquery>
                </cfif>
            
                <cfinclude template="shared/incDataTableYears.cfm">
            </cfloop>
                <cfinclude template="shared/incDataTableTotals.cfm">
				<td>
<!--- Search Array and Drop Down for Drill Down Menu Items --->
<cfinclude template="shared/incSearchArray.cfm">

<!--- evaluate if url has perf variables. if showperf = yes, include perf and perfvar--->
<cfinclude template="shared/incPerfString.cfm">

<cfset querystring2 = "View=#url.View#&Manager=#url.Manager#&Program=#Url.Program#&Type=#url.Type#&var=#url.var#&varValue=#itemVar#">

<SELECT NAME="CriteriaSelect" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Search Criteria
	<option value="javascript:document.location.reload();">
		<cfloop index="i" to="8" from="1">
			<cfif url.var neq varSearch[i][2]>
				<OPTION VALUE="qManager_Detail.cfm?#queryString2#&var1=#varSearch[i][2]#&#perfString#">#varSearch[i][1]#
			</cfif>
		</cfloop>
</SELECT>
				</td>
				<!--- View Data --->
				<td valign="middle">
					<a href="QueryToExcel.cfm?#queryString2#&refPage=#CGI.Script_Name#">
						<img src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0">
					</a>
				</td>
			</tr>
		</cfoutput>
	</table>
	
<cfinclude template="shared/incSaveQuery.cfm">
	
<cfinclude template="shared/incPerfLinks.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->