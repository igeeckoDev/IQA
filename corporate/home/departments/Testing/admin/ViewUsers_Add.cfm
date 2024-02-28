<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Database Users - Add User">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif structKeyExists(form,'submit')>

<!---
<cfdump var=#Form#>
--->

<cfset varRegion = listGetAt(Form.SubRegion, 1, "!!")>
<cfset varSubRegion = listGetAt(Form.SubRegion, 2, "!!")>

<!---
<cfoutput>
#varRegion#<br>
#varSubRegion#<br>
</cfoutput>
--->

	<CFQUERY BLOCKFACTOR="100" name="getRowID" Datasource="Corporate">
	SELECT MAX(ID)+1 as newID FROM IQADB_Login
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="AddRow" Datasource="Corporate">
	INSERT INTO IQADB_Login(ID, Username, Password, Name, AccessLevel, Region, SubRegion, IQA, Email)
	VALUES(#getRowID.newID#, '#Form.Username#', 'temppwd', '#Form.Name#', '#Form.AccessLevel#', '#varRegion#', '#varSubRegion#', '#Form.IQA#', '#Form.Email#')
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="UpdateRow" Datasource="Corporate">
	UPDATE IQADB_Login
	SET
	<cfif Form.Status eq "Active">
		Status = NULL
	<cfelse>
		Status = '#Form.Status#'
	</cfif>
	WHERE ID = #getRowID.newID#
	</cfquery>

	<cflocation url="ViewUsers.cfm" addtoken="No">
<cfelse>
	<!--- included for Form Validation and Formatted Form Textarea boxes --->
	<!--- form name and id must be "myform" --->
	<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

	<CFQUERY BLOCKFACTOR="100" name="SubRegion" Datasource="Corporate">
	SELECT Region, SubRegion
	FROM IQASubRegion
	ORDER BY Region, SubRegion
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="AccessLevel"  Datasource="Corporate">
	SELECT DISTINCT AccessLevel
	FROM IQADB_Login
	WHERE AccessLevel IS NOT NULL
	ORDER BY AccessLevel
	</cfquery>

	<cfFORM METHOD="POST" id="myform" name="myform" ENCTYPE="multipart/form-data" action="ViewUsers_Add.cfm">

	<b>Name</b> (First Name, Last Name)<br>
	<cfinput type="text" Name="Name" size="80" data-bvalidator="required" data-bvalidator-msg="Name"><br><br>

	<b>Username</b> - No Spaces!<br>
	<cfinput type="text" Name="Username" size="80" data-bvalidator="required" data-bvalidator-msg="Username"><br><br>

	<b>Email</b> (@ul.com)<br>
	<cfinput type="text" Name="Email" size="80" data-bvalidator="required" data-bvalidator-msg="Email"><br><br>

	<u>IQA Auditor</u><br>
	Yes <input type="Radio" Name="IQA" Value="Yes"><br>
	No <INPUT TYPE="Radio" NAME="IQA" value="No" checked><br><br>

	<cfoutput>
		<B>Access Level</B><br>
		<cfSELECT NAME="AccessLevel" data-bvalidator="required" data-bvalidator-msg="Region">
			<option value="">Select Access Level Below
			<cfloop query="AccessLevel">
				<OPTION VALUE="#AccessLevel#">#AccessLevel#</OPTION>
			</cfloop>
		</cfSELECT><br><br>

		<B>Region</B> - Select Corporate for IQA Auditors<br>
		<cfSELECT NAME="SubRegion" data-bvalidator="required" data-bvalidator-msg="Region">
			<option value="">Select Region Below
			<cfloop query="SubRegion">
				<OPTION VALUE="#Region#!!#SubRegion#">#Region# - #SubRegion#<cfif Region eq "Corporate"> (IQA Auditors Only)</cfif></OPTION>
			</cfloop>
		</cfSELECT><br><br>

		<b>Account Status</b><br>
		<cfSELECT NAME="Status" data-bvalidator="required" data-bvalidator-msg="Status">
			<option value="">Select Status Below
			<OPTION value="Active">Active
			<OPTION value="Removed">Inactive / Removed
			<option value="Test">Test Account
		</cfSELECT><br><br>
	</cfoutput>

	<input name="submit" type="submit" value="Add User">
	<input type="reset" value="Reset Form"><br /><br />
	</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->