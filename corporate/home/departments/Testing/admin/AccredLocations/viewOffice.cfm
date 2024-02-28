<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" name="AccredLocations" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	AccredLocations.ID <> 0
    AND  IQAtblOffices.OfficeName = '#URL.OfficeName#'
	AND IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<cfif AccredLocations.RecordCount GT 0>

<cfoutput>
Region: <b>#URL.Region#</b><br>
SubRegion: <b>#URL.SubRegion#</b><br>
Office: <b>#URL.OfficeName#</b><br>
</cfoutput>

<cfset AccredHolder = "">

<cfoutput query="AccredLocations">

	<cfif AccredHolder IS NOT Accreditor> 
		<cfif len(Accreditor)>
			<br>
		</cfif>
	<u>#Accreditor#</u><br>
	</cfif>
	
	 :: <A href="viewItem.cfm?ID=#ID#">#AccredType#</a> <cfif len(AccredType2)>(#AccredType2#)</cfif><br>

<cfset AccredHolder = Accreditor>
</cfoutput>

<cfelse>

<cfoutput>
There are no Accreditations Listed for #URL.OfficeName#.
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->