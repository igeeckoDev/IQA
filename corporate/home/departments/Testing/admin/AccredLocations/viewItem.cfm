<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" name="AccredLocations" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, IQAtblOffices.Region, IQAtblOffices.SubRegion, Accreditors.Accreditor, Accreditors.ID, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	AccredLocations.ID = #URL.ID#
	AND IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<cfif AccredLocations.RecordCount GT 0>

<cfoutput query="AccredLocations">
<cfinclude template="incViewItem.cfm">

<table width="600" border="1">
<tr align="left">
<th>Available Actions</th>
</tr>

<tr align="left">
<td>
<a href="editAccred_getEmpNo.cfm?ID=#URL.ID#">Edit</a> this Accreditation<br />
<a href="viewOffice.cfm?Region=#Region#&SubRegion=#SubRegion#&OfficeName=#OfficeName#">View</a> all accreditations for #OfficeName#<br>
<a href="viewAccreditor.cfm?ID=#AccredID#">View</a> all locations with #Accreditor# accreditation<br>
</td>
</tr>
</table>
</cfoutput>

<cfelse>

<cfoutput>
There are no Accreditations Listed.
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->