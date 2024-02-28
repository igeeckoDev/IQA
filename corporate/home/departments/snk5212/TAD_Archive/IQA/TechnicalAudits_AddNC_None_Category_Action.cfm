<!--- get max ID --->
<CFQUERY Name="ID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_NC
</CFQUERY>

<cfif NOT len(ID.MaxID)>
	<cfset ID.maxID = 1>
</cfif>

<!--- get item IDs for looping through query --->
<CFQUERY DataSource="UL06046" Name="Items" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_Items.ID
FROM 
	TechnicalAudits_Items
WHERE 
    TechnicalAudits_Items.Status IS NULL
    AND TechnicalAudits_Items.CategoryID = #URL.CategoryID#
ORDER BY 
	TechnicalAudits_Items.ID
</CFQUERY>

<!--- set max ID to newID --->
<cfset newID = ID.maxID>

<!--- loop through Items query to add data --->
<cfoutput query="Items"> 
    <!--- get subitem ID for looping through query --->
    <CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
       TechnicalAudits_SubItems.ID
    FROM 
        TechnicalAudits_SubItems
    WHERE 
        TechnicalAudits_SubItems.Status IS NULL
        AND TechnicalAudits_SubItems.ItemID = #ID#
    ORDER BY 
        TechnicalAudits_SubItems.ID
    </CFQUERY>
    
	<cfloop index="ListElement" list="#ValueList(SubItems.ID)#">
		<!--- Add New Row --->
        <CFQUERY DataSource="UL06046" Name="EnterNCaddRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO TechnicalAudits_NC(ID, AuditYear, AuditID)
        VALUES(#newID#, #URL.Year#, #URL.ID#)
        </CFQUERY>
    
        <!--- add data to new row --->
        <CFQUERY DataSource="UL06046" Name="EnterNCaddDetails" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_NC
        SET 
        
        SubItemID = #ListElement#,
        NC_OriginalCount = 0,
        NC_AfterAppealCount = 0,
        CNBD_OriginalCount = 0,
        Analysis = 'N/A'
        
        WHERE ID = #newID#
        </CFQUERY>
        
		<!--- +1 to NewID --->
        <cfset newID = newID + 1>
	</cfloop>
</cfoutput>

<!---
<Table border="1">
<tr>
	<th>Item</th>
    <th>SubItem</th>
    <th>NCs</th>
    <th>CNBDs</th>
    <th>NCs After Appeal</th>
    <th>Analysis</th>
</tr>
<cfoutput query="SubItems">
<tr>
	<td valign="top" align="center">Item #URL.ItemID#</td>
    <td valign="top" align="center">Sub Item #SubItem#</td>
    <td valign="top" align="center">0</td>
    <td valign="top" align="center">0</td>
    <td valign="top" align="center">0</td>
    <td valign="top" align="left">N/A</td>
</tr>
</cfoutput>
</Table>
--->

<cflocation url="#IQADir#TechnicalAudits_AddNC_SelectItem.cfm?Year=#URl.Year#&ID=#URL.ID#&CategoryID=#CategoryID#" addtoken="no">