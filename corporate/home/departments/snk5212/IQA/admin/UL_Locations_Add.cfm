<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add UL Location">
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
	SELECT MAX(ID)+1 as newID FROM IQAtblOffices
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" name="AddRow" Datasource="Corporate">
	INSERT INTO IQAtblOffices
	(ID, 
	OfficeName, 
	Exist, 
	Physical, 
	Finance, 
	Region, 
	SubRegion, 
	SNAPSite, 
	IC, 
	SuperLocation, 
	VS, 
	WISE, 
	LHS, 
	SNAPAudit, 
	ULE, 
	CB, 
	SNAPList_OfficeName)
	
	VALUES
	(#getRowID.newID#, 
	'#Form.OfficeName#', 
	'Yes', 
	'Yes', 
	'Yes', 
	'#varRegion#', 
	'#varSubRegion#', 
	'#Form.SNAPSite#', 
	'#Form.IC#', 
	'No', 
	'No', 
	'No', 
	'No', 
	'#Form.SNAPSite#', 
	'No', 
	'#Form.CB#', 
	'#Form.SNAPList_OfficeName#')
	</cfquery>

	<cflocation url="select_office.cfm" addtoken="No">
<cfelse>
	<!--- included for Form Validation and Formatted Form Textarea boxes --->
	<!--- form name and id must be "myform" --->
	<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

	<CFQUERY BLOCKFACTOR="100" name="SubRegion" Datasource="Corporate">
	SELECT Region, SubRegion
	FROM IQASubRegion
	ORDER BY Region, SubRegion
	</cfquery>

	<cfFORM METHOD="POST" id="myform" name="myform" ENCTYPE="multipart/form-data" action="UL_Locations_Add.cfm">

	<b>Location Name</b> <br>
	<cfinput type="text" Name="OfficeName" size="120" data-bvalidator="required" data-bvalidator-msg="Location Name"><br><br>

	<u>SNAP Site?</u><br>
	Yes <input type="Radio" Name="SNAPSite" Value="Yes"><br>
	No <INPUT TYPE="Radio" NAME="SNAPSite" value="No" checked><br><br>

	<u>IC Form?</u><br>
	Yes <input type="Radio" Name="IC" Value="Yes"><br>
	No <INPUT TYPE="Radio" NAME="IC" value="No" checked><br><br>
	
	<u>Is this a Certification Body?</u><br>
	Yes <input type="Radio" Name="CB" Value="Yes"><br>
	No <INPUT TYPE="Radio" NAME="CB" value="No" checked><br><br>
	
	<u>SNAP List (Keith Mowry List) Office Name</u><br>
	<cfinput type="text" Name="SNAPList_OfficeName" size="80" data-bvalidator="required" data-bvalidator-msg="SNAP List Office Name"><br><br>

	<cfoutput>
		<B>Region</B> - Select the Region and Sub-Region<br>
		<cfSELECT NAME="SubRegion" data-bvalidator="required" data-bvalidator-msg="Region">
			<option value="">Select Region Below
			<cfloop query="SubRegion">
				<OPTION VALUE="#Region#!!#SubRegion#">#Region# - #SubRegion#</OPTION>
			</cfloop>
		</cfSELECT><br><br>
	</cfoutput>

	<input name="submit" type="submit" value="Add Location">
	<input type="reset" value="Reset Form"><br /><br />
	</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->