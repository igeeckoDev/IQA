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

<!--- loop through subItems query to add data --->
<cfoutput query="SubItems">
	<!--- add data to new row --->
    <CFQUERY DataSource="UL06046" Name="EnterNCaddDetails" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_NC
    SET 
    
    NC_OriginalCount = #Evaluate("Form.NC_#ID#")#,
    CNBD_OriginalCount = #Evaluate("Form.CNBD_#ID#")#,
    NC_AfterAppealCount = #Evaluate("Form.NC_PostAppeal_#ID#")#,
    Analysis = '#replace(Evaluate("Form.Analysis_#ID#"), "'", "!", "All")#'
    
    WHERE SubItemID = #ID#
    AND AuditYear = #URL.Year#
    AND AuditID = #URL.ID#
    </CFQUERY>
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
	<td valign="top" align="center">#Viewing.ItemName#</td>
    <td valign="top" align="center">Sub Item #SubItem#</td>
    <td valign="top" align="center">#Evaluate("Form.NC_#ID#")#</td>
    <td valign="top" align="center">#Evaluate("Form.CNBD_#ID#")#</td>
    <td valign="top" align="center">#Evaluate("Form.NC_PostAppeal_#ID#")#</td>
    <td valign="top" align="left">#replace(Evaluate("Form.Analysis_#ID#"), "'", "!", "All")#</td>
</tr>
</cfoutput>
</Table>