<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Add Report Category">
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

<b>Add Category</b><br />

<cfform action="TechnicalAudits_Category_Add_Action.cfm">
<cfinput type="text" name="CategoryName" maxlength="64" size="68"><br /><br />

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>
<br /><Br />

<table border="1">
<tr>
    <th>Category Name</th>
</tr>
<cfoutput query="Categories">
<tr>
	<td>#CategoryName#</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->