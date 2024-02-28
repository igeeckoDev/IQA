<cfquery name="getGroups" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT groupName, groupType 
FROM GCAR_Metrics_Function_Grouping
GROUP BY groupName, groupType
</cfquery>

<cfoutput query="getGroups">
<b>#GroupName#</b> [field used - #groupType#]<br />

    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ItemName 
    FROM GCAR_Metrics_Function_Grouping
    WHERE GroupName = '#groupName#'
    AND groupType = '#groupType#'
    ORDER BY ItemName
    </cfquery>

    <cfloop query="getItems">
     - #ItemName#<br />
    </cfloop><Br />
</cfoutput>