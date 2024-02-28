<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Report SubItem Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_Items.ItemName, TechnicalAudits_SubItems.ID, TechnicalAudits_SubItems.SubItem, TechnicalAudits_SubItems.ID, TechnicalAudits_Items.CategoryID
FROM 
	TechnicalAudits_Items, TechnicalAudits_SubItems
WHERE 
    TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_Items.Status IS NULL
    AND TechnicalAudits_SubItems.Status IS NULL
    AND TechnicalAudits_Items.ID = #URL.ItemID#
ORDER BY 
	TechnicalAudits_Items.CategoryID, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>

<cfoutput>
<b>Available Actions</b><br />
 :: <a href="TechnicalAudits_SubItem_Add.cfm">Add Sub Item</a><br /><br />

Viewing Sub Items for Item: <b>#SubItems.ItemName#</b> :: <a href="TechnicalAudits_Item.cfm?CategoryID=#SubItems.CategoryID#">View Category</a>
</cfoutput><br /><br />

<Table border="1">
<tr>
    <th>Sub Item Name</th>
</tr>
<cfoutput query="SubItems">
<tr>
	<td>#SubItem#</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->