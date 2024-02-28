<CFQUERY DataSource="UL06046" Name="Viewing" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_Categories.CategoryName, TechnicalAudits_Items.ItemName, TechnicalAudits_Items.CategoryID
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items
WHERE 
	TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Items.ID = #URL.ItemID#
</CFQUERY>

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.12 Input Non-Conformances<br /><br />
</cfoutput>
</div>

<cfoutput query="Viewing">
Edited Sub Items for <b>#CategoryName#</b>: <b>#ItemName#</b><br /><br />

<u>Available Actions</u><Br>
:: <a href="#IQADir#TechnicalAudits_AddNC_SelectItem.cfm?Year=#URl.Year#&ID=#URL.ID#&CategoryID=#CategoryID#">Confirm</a><br>
:: <a href="#IQADir#TechnicalAudits_AddNC_Edit.cfm?#CGI.Query_String#">Edit</a><br><br>
</cfoutput>

<!--- get max ID --->
<CFQUERY Name="ID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_NC
</CFQUERY>

<cfif NOT len(ID.MaxID)>
	<cfset ID.maxID = 1>
</cfif>

<!--- get subitem ID for looping through query --->
<CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_SubItems.ID, TechnicalAudits_SubItems.SubItem
FROM 
	TechnicalAudits_SubItems
WHERE 
    TechnicalAudits_SubItems.Status IS NULL
    AND TechnicalAudits_SubItems.ItemID = #URL.ItemID#
ORDER BY 
	TechnicalAudits_SubItems.ID
</CFQUERY>

<!--- set max ID to newID --->
<cfset newID = ID.maxID>

<!--- loop through subItems query to add data --->
<cfoutput query="SubItems">
	<!--- add row --->
    <CFQUERY DataSource="UL06046" Name="EnterNCaddRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO TechnicalAudits_NC(ID, AuditYear, AuditID)
    VALUES(#newID#, #URL.Year#, #URL.ID#)
    </CFQUERY>

	<!--- add data to new row --->
    <CFQUERY DataSource="UL06046" Name="EnterNCaddDetails" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_NC
    SET 
    
    SubItemID = #ID#,
    NC_OriginalCount = 0,
    NC_AfterAppealCount = 0,
    CNBD_OriginalCount = 0,
    Analysis = 'N/A'
    
    WHERE ID = #newID#
    </CFQUERY>
    
<cfset newID = newID + 1>
</cfoutput>

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