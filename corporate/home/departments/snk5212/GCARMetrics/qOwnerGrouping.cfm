<cfquery name="getOwners" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT OwnerName
FROM GCAR_Metrics_Owner_Grouping
WHERE GroupName = 'Laura Elan'
ORDER BY OwnerName
</cfquery>

<cfset qCARCount.TotalCARs = 0>

<!--- create a query to store the itemName and the count for each row --->
<cfset newQuery = queryNew("RowID, OwnerName, CountItem","Integer, VarChar, Integer")>

<!--- i will be used to store rowID's incase there is some confusion --->
<cfset i = 1> 
<cfoutput query="getOwners">
    <cfquery name="getCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Count(docID) as  CountItem
        FROM GCAR_Metrics
        WHERE
        (CAROwner = '#OwnerName#'
        OR CAROwnersManager = '#OwnerName#'
        OR CAROwners2ndLevelManager = '#OwnerName#'
        OR CAROwners3rdLevelManager = '#OwnerName#'
        OR CAROwners4thLevelManager = '#OwnerName#'
        OR CARDeptQualityManager = '#OwnerName#')
        AND CARYear BETWEEN #Request.minYear# AND #Request.maxYear#
    </cfquery>

    <!--- capture the total for the Current Data Set total --->
    <cfset qCARCount.TotalCARs = getCount.CountItem + qCARCount.TotalCARs>
    
    <!--- Add a new row to the query --->
    <cfset queryAddRow(newQuery)>
    <cfset querySetCell(newQuery, "RowID", i)>
    <cfset querySetCell(newQuery, "OwnerName", "#OwnerName#")>
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

<cfdump var="#getItems#">
<br><br>

<Table border="1">
<tr>
<th>Name</th>
<cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
	<cfoutput>
    	<th>#i#</th>
    </cfoutput>
</cfloop>
<th>Total</th>
</tr>
<Cfoutput query="getItems">
<cfset rowTotal = 0>
<tr>
<td>#ownerName#</td>
<cfset qTotal = 0>
<cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
    <cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Count(docID) as CARCount, CARYear
    FROM GCAR_Metrics
    WHERE 
    (CAROwner = '#OwnerName#'
    OR CAROwnersManager = '#OwnerName#'
    OR CAROwners2ndLevelManager = '#OwnerName#'
    OR CAROwners3rdLevelManager = '#OwnerName#'
    OR CAROwners4thLevelManager = '#OwnerName#'
    OR CARDeptQualityManager = '#OwnerName#')
    AND CARYear = #i#
    GROUP BY CARYear
    </cfquery>
    
	<td align="center">
    	<cfif len(qresult.CARCount)>
        	#qResult.CARCount#
            <cfset rowTotal = rowTotal + qResult.CARCount>
        <cfelse>
        	0
            <cfset rowTotal = rowTotal>
        </cfif>
    </td>
</cfloop>
	<td align="center">
    	#rowTotal#
    </td>
</tr>
</Cfoutput>
</Table>