<CFQUERY BLOCKFACTOR="100" NAME="DAP_Documents" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DAP_Documents.ID as DocumentID, DAP_Documents.DocumentNumber, DAP_Documents.Title, DAP_Documents.CategoryID,
DAP_Documents_Category.CategoryName, DAP_Documents.Status
FROM DAP_Documents, DAP_Documents_Category
WHERE DAP_Documents.ID = #URL.ID#
AND DAP_Documents.CategoryID = DAP_Documents_Category.ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Category" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CategoryName, ID
FROM DAP_Documents_Category
WHERE Status IS NULL
ORDER BY ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='DAP_Documents.cfm'>DAP Documents</a> - Edit - #DAP_Documents.DocumentNumber#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput query="DAP_Documents">
<u>Document Number</u>: #DocumentNumber#<br>
<u>Document Title</u>: #Title#<br>
<u>Category</u>: #CategoryName#<br><br>

	<cfif NOT len(Status)>
		<u>Note</u>: to <b>remove</b> this document from the DAP Document list - select this link:<br>
		<a href="DAP_Documents_Remove.cfm?ID=#URL.ID#">Remove #DocumentNumber#</a><br><br>
	<cfelse>
		<u>Note</u>: This document is currently <b>removed</b> from the public DAP Document List.<br>
		To <b>add</b> this document to the DAP Document list - select this link:<br>
		<a href="DAP_Documents_Reinstate.cfm?ID=#URL.ID#">Reinstate #DocumentNumber#</a><br><br>
	</cfif>
</cfoutput>

<cfform method ="post" id="myform" name="myform" action="DAP_Documents_Edit_Submit.cfm?ID=#URL.ID#" enctype="multipart/form-data">

<cfoutput query="DAP_Documents">
Document Number:<br>
<input type="text" name="DocumentNumber" value="#DocumentNumber#"><br><br>

Title:<Br>
<input type="text" name="Title" value="#Title#" size="100"><br><br>
</cfoutput>

Category:<br>
<cfselect
    queryposition="below"
    name="CategoryID"
    data-bvalidator="required"
    data-bvalidator-msg="Category">

	<cfoutput query="DAP_Documents">
		<option value="#CategoryID#" selected>#CategoryName# (current selection)</option>
	</cfoutput>
	<cfoutput query="Category">
        <option value="#ID#">#CategoryName#
    </cfoutput>
</cfselect>
<br><br>

<input type="submit" value="Submit Changes">
<input type="reset" value="Reset Form"><br /><br />
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->