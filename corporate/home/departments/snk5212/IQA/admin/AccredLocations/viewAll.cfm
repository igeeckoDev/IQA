<cfif NOT isDefined("url.sort")>
	<cfset url.sort = "Loc">
	<cfset newsort = "Acc">
<cfelse>
	<cfif url.sort is "Loc">
    	<cfset newsort = "Acc">
	<cfelseif url.sort is "Acc">
		<cfset newsort = "Loc">
    </cfif>
</cfif>

<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" name="AccredLocations" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, Accreditors.Accreditor, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	AccredLocations.ID <> 0
    AND IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
<cfif url.sort is "Acc">
ORDER BY
	Accreditor, OfficeName, AccredType
<cfelseif url.sort is "Loc">
ORDER BY
	OfficeName, Accreditor, AccredType
</cfif>
</cfquery>

<cfoutput>
<b>View All Accreditations</b><br />
Current Sort: by <b><cfif url.sort is "Acc">Accreditors<cfelseif url.sort is "Loc">UL Locations</cfif></b><br />
Switch to: by <a href="#CGI.SCRIPT_NAME#?sort=#newsort#"><cfif url.sort is "Acc">UL Locations<cfelseif url.sort is "Loc">Accreditors</cfif></a><br /><br />
</cfoutput>

<cfif AccredLocations.RecordCount GT 0>

<cfset AccredHolder = "">
<cfset OfficeHolder = "">

<cfoutput query="AccredLocations">

<cfif url.sort is "Acc">

	<cfif AccredHolder IS NOT Accreditor> 
		<cfif len(Accreditor)>
			<br>
		</cfif>
	<b>#Accreditor#</b>
    <cfset OfficeHolder = "">
	</cfif>

	<cfif OfficeHolder IS NOT OfficeName> 
		<cfif len(OfficeName)>
			<br>
		</cfif>
	<u>#OfficeName#</u><br>
	</cfif>

<cfelseif url.sort is "Loc">

	<cfif OfficeHolder IS NOT OfficeName> 
		<cfif len(OfficeName)>
			<br>
		</cfif>
	<b>#OfficeName#</b>
    <cfset AccredHolder = "">
	</cfif>

	<cfif AccredHolder IS NOT Accreditor> 
		<cfif len(Accreditor)>
			<br>
		</cfif>
	<u>#Accreditor#</u><br>
	</cfif>

</cfif>
	
	 :: <A href="viewItem.cfm?ID=#ID#">#AccredType#</a> <cfif len(AccredType2)>(#AccredType2#)</cfif><br>

<cfset AccredHolder = Accreditor>
<cfset OfficeHolder = OfficeName>
</cfoutput>

<cfelse>

<cfoutput>
There are no Accreditations Listed.
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->