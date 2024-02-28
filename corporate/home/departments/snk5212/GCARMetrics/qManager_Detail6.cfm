<!--- set values for url variables for page
and subTitle / subTitle2 for StartOfPage.cfm --->
<cfinclude template="shared/incVariables.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariableTitles.cfm">

<!--- url.var defines sort field --->
<Cfset dValue = "d#url.var6#">

<!--- Total Number of CARs found during the search --->
<cfquery name="qCARCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as TotalCARs
FROM GCAR_Metrics
WHERE
<cfinclude template="shared/incProgramQuery.cfm">
#url.var# = '#trim(url.varValue)#' AND
#url.var1# = '#trim(url.var1Value)#' AND
#url.var2# = '#trim(url.var2Value)#' AND
#url.var3# = '#trim(url.var3Value)#' AND
#url.var4# = '#trim(url.var4Value)#' AND
#url.var5# = '#trim(url.var5Value)#'
<cfinclude template="shared/incManagerAndViewQuery.cfm">
</cfquery>

<!--- Get list of distinct values in order to loop through and count --->
<cfquery name="qDistinctResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
<!--- Old: SELECT DISTINCT #url.var6# as d#url.var6# --->
SELECT Count(docID) as Count, #url.var6# as d#url.var6#
FROM GCAR_Metrics
WHERE
<cfinclude template="shared/incProgramQuery.cfm">
#url.var# = '#trim(url.varValue)#' AND
#url.var1# = '#trim(url.var1Value)#' AND
#url.var2# = '#trim(url.var2Value)#' AND
#url.var3# = '#trim(url.var3Value)#' AND
#url.var4# = '#trim(url.var4Value)#' AND
#url.var5# = '#trim(url.var5Value)#'
<cfinclude template="shared/incManagerAndViewQuery.cfm">
GROUP BY #url.var6#
<!--- Old (alphabetical sort): ORDER BY #url.var6# ASC--->
ORDER BY Count DESC
</cfquery>

<cfoutput>
<cfinclude template="shared/incPerfVariables.cfm">

<!--- query string for Removing CAR Performance and for Adding/Changing CAR Performance on bottom of this page --->
<cfset queryString1 = "View=#url.View#&Manager=#url.Manager#&Program=#Url.Program#&Type=#url.Type#&var=#url.var#&varValue=#varValue#&var1=#url.var1#&var1Value=#url.var1Value#&var2=#url.var2#&var2value=#url.var2value#&var3=#url.var3#&var3value=#url.var3value#&var4=#url.var4#&var4value=#url.var4value#&var5=#url.var5#&var5value=#url.var5value#&var6=#url.var6#">

<cfset queryStringViewChange = "Manager=#url.Manager#&Program=#Url.Program#&Type=#url.Type#&var=#url.var#&varValue=#varValue#&var1=#url.var1#&var1Value=#url.var1Value#&var2=#url.var2#&var2value=#url.var2value#&var3=#url.var3#&var3value=#url.var3value#&var4=#url.var4#&var4value=#url.var4value#&var5=#url.var5#&var5value=#url.var5value#&var6=#url.var6#">

<cfset queryStringTypeChange = "View=#url.View#&Manager=#url.Manager#&Program=#Url.Program#&var=#url.var#&varValue=#varValue#&var1=#url.var1#&var1Value=#url.var1Value#&var2=#url.var2#&var2value=#url.var2value#&var3=#url.var3#&var3value=#url.var3value#&var4=#url.var4#&var4value=#url.var4value#&var5=#url.var5#&var5value=#url.var5value#&var6=#url.var6#">

<cfinclude template="shared/incSearchCriteria.cfm">
</cfoutput>

<cfinclude template="shared/incTableHeader.cfm">

		<cfoutput query="qDistinctResult">
		<tr class="blog-content" align="center" valign="top">
			<td align="left">#Evaluate("#dValue#")#</td>
			<cfset qTotal = 0>
			<cfset perfTotal = 0>
			<cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
				<cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Count(#url.var6#) as CARCount, CARYear, #url.var6#
				FROM GCAR_Metrics
				WHERE
				<cfinclude template="shared/incProgramQuery.cfm">
				#url.var6# = '#Evaluate("#dValue#")#'
				AND #url.var# = '#trim(url.varValue)#'
				AND #url.var1# = '#trim(url.var1Value)#'
				AND #url.var2# = '#trim(url.var2Value)#'
				AND #url.var3# = '#trim(url.var3Value)#'
				AND #url.var4# = '#trim(url.var4Value)#'
				AND #url.var5# = '#trim(url.var5Value)#'
				AND CARYear = #i#
				<cfinclude template="shared/incManagerAndViewQuery.cfm">
				GROUP BY #url.var6#, CARYear
				</cfquery>

				<cfif url.showPerf eq "Yes">
					<cfquery name="Perf" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Count(CARNumber) as Count
					FROM GCAR_Metrics
					WHERE
					<cfinclude template="shared/incProgramQuery.cfm">
					#perfField# = '#perfVar#'
					AND #url.var6# = '#Evaluate("#dValue#")#'
					AND #url.var# = '#trim(url.varValue)#'
					AND #url.var1# = '#trim(url.var1Value)#'
					AND #url.var2# = '#trim(url.var2Value)#'
					AND #url.var3# = '#trim(url.var3Value)#'
					AND #url.var4# = '#trim(url.var4Value)#'
					AND #url.var5# = '#trim(url.var5Value)#'
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

<cfset querystring2 = "View=#url.View#&Manager=#url.Manager#&Program=#Url.Program#&Type=#url.Type#&var=#url.var#&varValue=#varValue#&var1=#url.var1#&var1value=#url.var1value#&var2=#url.var2#&var2value=#url.var2Value#&var3=#url.var3#&var3value=#url.var3Value#&var4=#url.var4#&var4value=#url.var4Value#&var5=#url.var5#&var5value=#url.var5value#&var6=#url.var6#&var6value=#Evaluate("#dValue#")#">

<SELECT NAME="CriteriaSelect" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Search Criteria
	<option value="javascript:document.location.reload();">
	<cfloop index="i" to="8" from="1">
		<cfif url.var neq varSearch[i][2]
			AND url.var1 neq varSearch[i][2]
			AND url.var2 neq varSearch[i][2]
			AND url.var3 neq varSearch[i][2]
			AND url.var4 neq varSearch[i][2]
			AND url.var5 neq varSearch[i][2]
			AND url.var6 neq varSearch[i][2]>
	<OPTION VALUE="qManager_Detail7.cfm?#queryString2#&var7=#varSearch[i][2]#&#perfString#">#varSearch[i][1]#
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