<cfquery name="getID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as newID 
FROM GCAR_Metrics_Function_Grouping
</cfquery>

<cfif NOT isDefined("getID.recordcount")>
	<cfset getID.newID = 1>
</cfif>

<cfset i = #getID.newID#>
<cfloop from="1" to="#ListLen(URL.ItemName)#" index="ItemName">  
    <cfquery name="AddGroup" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO GCAR_Metrics_Function_Grouping(ID, GroupName, GroupType, ItemName)
    VALUES(#i#, '#URL.GroupName#', '#URL.GroupType#', '#replace(ListGetAt(URL.ItemName, ItemName), "!!", ",", "All")#')
    </cfquery>
<cfset i = i + 1>
</cfloop>

<cfquery name="getGroup" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM GCAR_Metrics_Function_Grouping
WHERE GroupName = '#URL.GroupName#'
AND GroupType = '#URL.GroupType#'
ORDER BY ID
</cfquery>

<cflocation url="qGroup_Select.cfm?msg=The Custom Grouping Named #URL.GroupName# has been added" addtoken="no">