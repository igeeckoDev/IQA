<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Report Category Control - Reorder Categories">
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

<cfset i = 1>
<cfform action="TechnicalAudits_Category_Recorder_Action.cfm">

<table border="1">
<tr>
    <th>Category Name</th>
    <th>Current Order</th>
    <th>New Order</th>
</tr>
<cfoutput query="Categories">
<cfinput type="hidden" name="ID" value="#ID#">
<tr>
	<td>#CategoryName#</td>
    <td align="center">#alphaOrder#</td>
    <td align="center"><cfinput type="text" maxlength="1" name="alphaOrder" value="#i#"></td>
</tr>
<cfset i = i + 1>
</cfoutput>
</table>

<cfinput type="Submit" name="Submit" value="Submit">

</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->