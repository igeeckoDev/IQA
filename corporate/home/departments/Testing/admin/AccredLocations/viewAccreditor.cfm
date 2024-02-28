<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" name="AccredLocations" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	AccredLocations.ID <> 0
    AND Accreditors.ID = #URL.ID#
	AND IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<cfif AccredLocations.RecordCount GT 0>

<cfset OfficeHolder = "">

<cfoutput>
<b>#AccredLocations.Accreditor# Accreditations</b><br>
</cfoutput>

<cfoutput query="AccredLocations">

	<cfif OfficeHolder IS NOT OfficeName> 
		<cfif len(OfficeName)>
			<br>
		</cfif>
	<u>#OfficeName#</u><br>
	</cfif>

	 :: <A href="viewItem.cfm?ID=#ID#">#AccredType#</a> <cfif len(AccredType2)>(#AccredType2#)</cfif><br>

<cfset OfficeHolder = OfficeName>
</cfoutput>

<cfelse>

<CFQUERY BLOCKFACTOR="100" name="Accred" Datasource="Corporate">
SELECT 
	Accreditors.Accreditor
FROM 
	Accreditors
WHERE
	Accreditors.ID = #URL.ID#
</cfquery>

<cfoutput>
There are no Accreditations listed for <b>#Accred.Accreditor#</b>.
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->