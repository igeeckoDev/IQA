<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "Quality Engineering Related Files - Categories">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<cfif isDefined("Form.CategoryName")>

<CFQUERY DataSource="Corporate" Name="AddCategory"> 
UPDATE CARFilesCategory
SET
CategoryName = '#Form.CategoryName#',
CategorySecure = '#Form.CategorySecure#'

WHERE
CategoryID = #URL.ID#
</CFQUERY>

<cflocation url="CARFilesCategories_Edit.cfm?ID=#URL.ID#&Action=Edited&Category=#Form.CategoryName#&OldCategory=#Form.OldCategoryName#&Secure=#Form.CategorySecure#&OldSecure=#Form.OldCategorySecure#" addtoken="No">

<cfelse>

<!--- url Action will be 'Added' or 'Removed' --->
<cfif isDefined("url.Action") AND isDefined("url.Category")>
	<cfoutput>
    <font color="red">Category #URL.Action#</font><Br>
    <u>Old Values</u>: #URL.OldCategory# <cfif URL.OldSecure is "Yes">(Login Required)<cfelse>(Public Category)</cfif><br>
    <u>New Values</u>: #URL.Category# <cfif URL.Secure is "Yes">(Login Required)<cfelse>(Public Category)</cfif>    
    </cfoutput><br /><br />
</cfif>

<CFQUERY DataSource="Corporate" Name="Categories">
SELECT * FROM CARFilesCategory
WHERE CategoryID = #URL.ID#
</cfquery>

<cfoutput query="Categories">

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">

Category Name<br>
<cfinput type="hidden" name="OldCategoryName" value="#CategoryName#">

<cfinput value="#CategoryName#" name="CategoryName" size="75" type="text" required="yes" message="Category Name is required"><br><br>

Login Required to View Category?<br />
<cfinput type="hidden" name="OldCategorySecure" value="#CategorySecure#">

<cfinput type="Radio" value="Yes" name="CategorySecure" checked="#IIF(CategorySecure eq 'Yes', DE('Yes'), DE('No'))#"> Yes 
<cfinput type="Radio" value="No" name="CategorySecure" checked="#IIF(CategorySecure eq 'No', DE('Yes'), DE('No'))#"> No
<Br /><Br />

<INPUT TYPE="Submit" value="Submit" Name="Submit">

</cfform>
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->