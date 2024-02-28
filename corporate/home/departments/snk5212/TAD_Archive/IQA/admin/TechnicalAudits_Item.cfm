<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Report Item Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY DataSource="UL06046" Name="Items" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.CategoryName, TechnicalAudits_Items.ItemName, TechnicalAudits_Items.ID
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items
WHERE 
    TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Categories.Status IS NULL
    AND TechnicalAudits_Items.Status IS NULL
	AND TechnicalAudits_Categories.ID = #URL.CategoryID#
ORDER BY 
	TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder
</CFQUERY>

<cfoutput>
<b>Available Actions</b><br />
 :: <a href="TechnicalAudits_Item_Add.cfm">Add Item</a><br /><br />

Viewing Items for Category: <b>#Items.CategoryName#</b> :: <a href="TechnicalAudits_Category.cfm">View All Categories</a>
</cfoutput><br /><br />

<Table border="1">
<tr>
    <th>Item Names</th>
    <th>Edit</th>
    <th>View Sub Item Names</th>
</tr>
<cfoutput query="Items">
	<td>#ItemName#</td>
    <td align="center">
    	<A href="TechnicalAudits_Item_Edit.cfm?ItemID=#ID#">
    		<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
        </A>
    </td>
    <td align="center">
    	<A href="TechnicalAudits_SubItem.cfm?ItemID=#ID#">
    		<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
        </A>
    </td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->