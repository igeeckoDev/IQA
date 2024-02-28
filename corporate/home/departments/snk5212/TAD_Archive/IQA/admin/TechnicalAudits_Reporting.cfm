<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Category, Item, SubItem Structure">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY DataSource="UL06046" Name="Reporting" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.ID as CatID, TechnicalAudits_Categories.CategoryName,
    TechnicalAudits_Items.ID as ItemID, TechnicalAudits_Items.ItemName,
    TechnicalAudits_SubItems.ID as SubItemID, TechnicalAudits_SubItems.SubItem
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems
WHERE 
    TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_Categories.Status IS NULL
    AND TechnicalAudits_Items.Status IS NULL
    AND TechnicalAudits_SubItems.Status IS NULL
ORDER BY 
	TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>

<cfset CatHolder = "">
<cfset ItemHolder = "">

<Table border="1">
<tr>
    <th>Category</th>
    <th>Item</th>
    <th>Sub Item</th>
	<th>i</th>
</tr>
<tr>
<cfset i = 1>
<cfoutput query="Reporting">
	<cfif NOT len(CatHolder)>
    	<td>#CategoryName# #CatID#</td>
    <cfelseif CatHolder NEQ CategoryName>
    	<td colspan="3">&nbsp;</td>
        </tr>
        <cfset ItemHolder = "">
    	<tr>
        <td>#CategoryName# #CatID#</td>
    </cfif>
    
   	<cfif NOT len(ItemHolder)>
        <td>#ItemName# #ItemID#</td>
        <td>#SubItem# #SubItemID#</td>
    <cfelseif ItemHolder NEQ ItemName>
        <td>&nbsp;</td>
        <td>#ItemName# #ItemID#</td>
        <td>#SubItem# #SubItemID#</td>
    <cfelseif ItemHolder EQ ItemName>
    	<td colspan="2">&nbsp;</td>
        <td>#SubItem# #SubItemID#</td>
    </cfif> 

	<td>#i#</td>
	</tr>

<cfset i = i+1>
<cfset CatHolder = CategoryName>
<Cfset ItemHolder = ItemName>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->