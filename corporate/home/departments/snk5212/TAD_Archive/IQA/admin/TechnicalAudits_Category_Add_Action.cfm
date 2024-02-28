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
    AND TechnicalAudits_Categories.CategoryName = '#trim(Form.CategoryName)#'
ORDER BY 
	TechnicalAudits_Categories.alphaOrder
</CFQUERY>

<cfoutput>
	<cfif Categories.recordCount GT 0>
        Category Name (#Form.CategoryName#) already in use. (redirect to Add Report Category page with url.msg)
    <cfelseif Categories.recordCount eq 0>
        Category Name (#Form.CategoryName#) available. Proceed with Category Add.
    </cfif>
</cfoutput><br><br>

<cfdump var="#form#">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->