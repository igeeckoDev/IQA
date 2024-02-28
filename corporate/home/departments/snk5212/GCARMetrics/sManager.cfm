<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwnersManager as Managers
FROM GCAR_Metrics
ORDER BY CAROwnersManager
</cfquery>

<cfset qM1 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwners2ndLevelManager as Managers
FROM GCAR_Metrics
ORDER BY CAROwners2ndLevelManager
</cfquery>

<cfset qM2 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwners3rdLevelManager as Managers
FROM GCAR_Metrics
ORDER BY CAROwners3rdLevelManager
</cfquery>

<cfset qM3 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwners4thLevelManager as Managers
FROM GCAR_Metrics
ORDER BY CAROwners4thLevelManager
</cfquery>

<cfset qM4 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARDeptQualityManager as Managers
FROM GCAR_Metrics
ORDER BY CARDeptQualityManager
</cfquery>

<cfset qM5 = ValueList(qManagers.Managers)>

<!--- concatenate with cfsavecontent --->
<cfsavecontent variable="cfstring">
	<cfoutput>
		<cfloop from="1" to="5" index="i">
			#Evaluate("qM#i#")#,
		</cfloop>
	</cfoutput>
</cfsavecontent>

<!--- all strings concatenated 
<cfoutput>#cfstring#</cfoutput>
--->

<!--- Convert list to 1 column query var --->
<cfset query = queryNew("val") />
<cfloop list="#cfString#" index="i" delimiters=",">
<cfset queryAddRow(query) />
<cfset querySetCell(query, "val", i) />
</cfloop>

<!--- Remove duplicates and sort results using query of query and "group by" --->
<cfquery name="sortedQuery" dbtype="query">
SELECT val
FROM query
GROUP BY val
ORDER BY val asc
</cfquery>

<!--- Output table of distinct Managers 
<Table border="1">
<cfoutput query="sortedquery">
<tr>
<td>#val#</td>
</tr>
</cfoutput>
</table>
--->

<cfform name="InputTypeTextAutosuggestTest" method="post" action="vManager.cfm">
<b>Search for Manager Name</b><br />
Start typing Manager's first name and select from available options<Br>

<cfinput 
	name="Name" 
	type="text" 
	autosuggest="#ValueList(sortedQuery.val)#">
<br /><br />

<cfinput 
	name="SubmitName" 
	type="submit" 
	value="Submit">
</cfform>