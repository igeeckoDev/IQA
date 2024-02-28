<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset SubTitle = "Quality Engineering Related Files - Categories">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<cfif isDefined("Form.CategoryName")>

<CFQUERY DataSource="Corporate" Name="MaxID">
SELECT MAX(CategoryID)+1 as NewMaxID From CARFilesCategory
</cfquery>

<CFQUERY DataSource="Corporate" Name="AddCategory"> 
INSERT INTO CARFilesCategory(CategoryID, CategoryName, CategorySecure)
VALUES (#maxID.NewMaxID#, '#Form.CategoryName#', '#Form.CategorySecure#')
</cfquery>

<cflocation url="CARFilesCategories.cfm?Action=Added&Category=#Form.CategoryName#" addtoken="No">

<cfelse>

<!--- url Action will be 'Added' or 'Removed' --->
<cfif isDefined("url.Action") AND isDefined("url.Category")>
	<cfoutput>
    <font color="red">Category <b>#URL.Category#</b> - #URL.Action#</font>
    </cfoutput><br /><br />
</cfif>

<CFQUERY DataSource="Corporate" Name="Categories">
SELECT * FROM CARFilesCategory
WHERE CategoryID > 0
ORDER BY CategorySecure DESC, CategoryName
</cfquery>

<cfset SecureHolder = "">

<cfoutput query="Categories">
	<cfif SecureHolder IS NOT CategorySecure>
	<cfIf SecureHolder is NOT "">
		<Br />
	</cfif>
    	<cfif CategorySecure is "Yes">
			<b><u>Categories Requiring Site Login</u></b>
        <cfelse>
        	<b><u>Public Categories</u></b>
        </cfif><Br />
	</cfif>

 - #CategoryName# <a href="CARFilesCategories_Edit.cfm?ID=#CategoryID#">[edit]</a><br>

<cfset SecureHolder = CategorySecure>
</cfoutput><br>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#">

Category Name<br>
<cfinput name="CategoryName" size="75" type="text" required="yes" message="Category Name is required"><br><br>

Login Required to View Category?<br />
<cfinput type="Radio" value="Yes" name="CategorySecure"> Yes 
<cfinput type="Radio" value="No" name="CategorySecure" checked> No
<Br /><Br />

<INPUT TYPE="Submit" value="Submit" Name="Submit">

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->