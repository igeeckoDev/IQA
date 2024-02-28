<b>Accreditations</b> 
<cfif len(Accreditors)>

<cfset OfficeHolder = "">
<cfloop index = "ListElement" list = "#Accreditors#"> 
    <CFQUERY BLOCKFACTOR="100" name="Accreds" Datasource="Corporate">
    SELECT 
        IQAtblOffices.OfficeName, IQAtblOffices.Region, IQAtblOffices.SubRegion, Accreditors.Accreditor, Accreditors.ID, AccredLocations.*
    FROM 
        IQAtblOffices, Accreditors, AccredLocations
    WHERE
        AccredLocations.ID = #ListElement#
        AND IQAtblOffices.ID = AccredLocations.OfficeID
        AND Accreditors.ID = AccredLocations.AccredID
    ORDER BY
        OfficeName, Accreditor, AccredType
    </cfquery>

    <cfoutput query="Accreds">
        <cfif OfficeHolder IS NOT OfficeName> 
            <cfif len(OfficeName)>
                <br>
            </cfif>
        <u>#OfficeName#</u><br>
        </cfif>
     :: #Accreditor# - #AccredType# (#AccredType2#)<Br>
    <cfset OfficeHolder = OfficeName>
    </cfoutput>
</cfloop><br>	

<cfelse>
	<br>
    None Listed<Br><Br />
</cfif>