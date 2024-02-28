<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='DAP_Documents.cfm'>DAP Documents</a> - Add">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Category" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CategoryName, ID
FROM DAP_Documents_Category
WHERE Status IS NULL
ORDER BY ID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfform method ="post" id="myform" name="myform" action="DAP_Documents_Add_Submit.cfm" enctype="multipart/form-data">

DCS Document Number:<br>
<cfinput type="text" name="DocumentNumber" value="" data-bvalidator="required" data-bvalidator-msg="DCS Document Number"><br><br>

Title:<Br>
<cfinput type="text" name="Title" value="" size="100" data-bvalidator="required" data-bvalidator-msg="Document Title"><br><br>

Category:<br>
<cfselect
    queryposition="below"
    name="CategoryID"
    data-bvalidator="required"
    data-bvalidator-msg="Category">

	<cfoutput query="Category">
        <option value="#ID#">#CategoryName#
    </cfoutput>
</cfselect>
<br><br>

<input type="submit" value="Submit Form">
<input type="reset" value="Reset Form"><br /><br />
</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->