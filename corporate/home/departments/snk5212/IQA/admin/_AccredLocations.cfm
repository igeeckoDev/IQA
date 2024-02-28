<CFQUERY BLOCKFACTOR="100" name="AccredLocations" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<cfset OfficeHolder = "">
<cfset AccredHolder = "">

<cfoutput query="AccredLocations">

	<cfif OfficeHolder IS NOT OfficeName> 
		<cfif len(OfficeHolder)>
			<br>
		</cfif>
	<b><u>#OfficeName#</u></b>
	</cfif>
	
	<cfif AccredHolder IS NOT Accreditor> 
		<cfif len(Accreditor)>
			<br>
		</cfif>
	<u>#Accreditor#</u><br>
	</cfif>
	
	 :: <A href="_AccredLocations_Detail.cfm?ID=#ID#">#AccredType#</a><br>

<cfset OfficeHolder = OfficeName>
<cfset AccredHolder = Accreditor>
</cfoutput>