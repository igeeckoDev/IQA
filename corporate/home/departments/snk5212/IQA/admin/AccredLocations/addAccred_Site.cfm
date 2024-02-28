<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<cfif isDefined("URL.Region") AND NOT isDefined("URL.SubRegion")>
	<CFQUERY BLOCKFACTOR="100" name="SubRegion" Datasource="Corporate">
	SELECT * FROM IQASubRegion
	WHERE Region = '#URL.Region#'
	ORDER BY SubRegion
	</cfquery>
<cfelseif isDefined("URL.SubRegion") AND isDefined("URL.Region")>
	<CFQUERY BLOCKFACTOR="100" name="Offices" Datasource="Corporate">
	SELECT * FROM IQAtblOffices
	WHERE SubRegion = '#URL.SubRegion#'
	AND SuperLocation = 'No'
	ORDER BY OfficeName
	</cfquery>
</cfif>

<cfform>
	<cfif isDefined("URL.Region") AND NOT isDefined("URL.SubRegion")>
		<cfoutput>
		Region: #URL.Region#<br><br>
		</cfoutput>
		Select Subregion:<Br>
		
		<CFSELECT NAME="SubRegion" required="Yes" Message="Select Subregion" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<OPTION Value="">Select Subregion
			<CFOUTPUT QUERY="SubRegion">
				<OPTION VALUE="addAccred_Site.cfm?Region=#URL.Region#&SubRegion=#SubRegion#">#SubRegion#
			</CFOUTPUT>
		</CFSELECT>
		
	<cfelseif isDefined("URL.SubRegion") AND isDefined("URL.Region")>
		<cfoutput>
		Region: #URL.Region#<br>
		Subregion: #URL.SubRegion#<br><br>
		</cfoutput>
		Select Office:<br>
		
		<CFSELECT NAME="OfficeName" required="Yes" Message="Select Office" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<OPTION Value="">Select Office
			<CFOUTPUT QUERY="Offices">
				<OPTION VALUE="addAccred_getEmpNo.cfm?Region=#URL.Region#&SubRegion=#URL.SubRegion#&OfficeName=#OfficeName#">#OfficeName#
			</CFOUTPUT>
		</CFSELECT>
		
	<cfelseif NOT isDefined("URL.Region") AND NOT isDefined("URL.SubRegion")>
		Select Region:<Br>
		
		<CFQUERY BLOCKFACTOR="100" name="Region" Datasource="Corporate">
		SELECT * FROM IQARegion
		WHERE Region <> 'Corporate'
		AND Region <> 'Global'
		AND Region <> 'Field Services'
		AND Region <> 'None'
		ORDER BY Region
		</cfquery>
		
		<CFSELECT NAME="Region" required="Yes" Message="Select Region" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<OPTION Value="">Select Region
			<CFOUTPUT QUERY="Region">
				<OPTION VALUE="addAccred_Site.cfm?Region=#Region#">#Region#
			</CFOUTPUT>
		</CFSELECT>
	</cfif>
</cfform>
	
<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->