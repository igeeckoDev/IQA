<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Report Category Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY DataSource="UL06046" Name="Categories" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.ID, TechnicalAudits_Categories.CategoryName, TechnicalAudits_Categories.alphaOrder
FROM 
	TechnicalAudits_Categories
WHERE 
    TechnicalAudits_Categories.Status IS NULL
ORDER BY 
	TechnicalAudits_Categories.alphaOrder
</CFQUERY>

<b>Available Actions</b><br />
<!---
 :: <A href="TechnicalAudits_Category_Reorder.cfm">Reorder</A>  Categories for Audit Reporting. (Currently the Categories are shown in the Audit Report as shown below)<br />
--->
 :: <a href="TechnicalAudits_Category_Add.cfm">Add Category</a><br /><br />

Note: Select Edit next to the Category name below to change its name.<br /><Br />

<table border="1">
<tr>
    <th>Category Name</th>
    <th>Edit</th>
    <th>View Item Names</th>
</tr>
<cfoutput query="Categories">
<tr>
	<td>#CategoryName#</td>
    <td align="center">
    	<A href="TechnicalAudits_Category_Edit.cfm?ID=#ID#">
        	<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
        </A>
	</td>
    <td align="center">
    	<A href="TechnicalAudits_Item.cfm?CategoryID=#ID#">
    		<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
        </A>
	</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->