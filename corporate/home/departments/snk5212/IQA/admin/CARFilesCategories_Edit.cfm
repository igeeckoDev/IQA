<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Quality Engineering Related Files - Categories">
<cfinclude template="SOP.cfm">

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

<cflocation url="CARFilesCategories.cfm?ID=#URL.ID#&Action=Edited&Category=#Form.CategoryName#&OldCategory=#Form.OldCategoryName#&Secure=#Form.CategorySecure#&OldSecure=#Form.OldCategorySecure#" addtoken="No">

<cfelse>

<br>
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

<cfinclude template="EOP.cfm">

<!--- / --->