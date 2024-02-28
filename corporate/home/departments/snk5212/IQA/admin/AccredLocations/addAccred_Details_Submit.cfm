<CFQUERY Datasource="Corporate" NAME="Check">
SELECT *
FROM AccredLocations
WHERE OfficeID = #FORM.OfficeID#
AND AccredID = #FORM.AccredID#
AND AccredType = '#Form.AccredType#'
AND AccredType2 = '#Form.AccredType2#'
</cfquery>

<cfif Check.Recordcount gt 0>

<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

Warning - This accreditation may already exist. The record(s) below appear to be the same or similar to your entry:<br /><br />

<CFQUERY BLOCKFACTOR="100" name="AccredLocations" Datasource="Corporate">
SELECT 
	IQAtblOffices.OfficeName, IQAtblOffices.Region, IQAtblOffices.SubRegion, Accreditors.Accreditor, Accreditors.ID, AccredLocations.*
FROM 
	IQAtblOffices, Accreditors, AccredLocations
WHERE
	OfficeID = #FORM.OfficeID#
	AND AccredID = #FORM.AccredID#
	AND AccredType = '#Form.AccredType#'
	AND AccredType2 = '#Form.AccredType2#'
	AND IQAtblOffices.ID = AccredLocations.OfficeID
	AND Accreditors.ID = AccredLocations.AccredID
ORDER BY
	OfficeName, Accreditor, AccredType
</cfquery>

<cfoutput query="AccredLocations">
	<cfinclude template="incViewItem.cfm">
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->

<cfelse>

<CFQUERY Datasource="Corporate" NAME="NewID">
SELECT MAX(ID)+1 as NewID FROM AccredLocations
</cfquery>

<CFQUERY Datasource="Corporate" NAME="NewRow1">
INSERT INTO AccredLocations(ID, OfficeID, AccredID, AccredType, AccredType2)
VALUES(#NewID.NewID#, #Form.OfficeID#, #Form.AccredID#, '#Form.AccredType#', '#Form.AccredType2#')
</CFQUERY>

<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<CFQUERY Datasource="Corporate" NAME="NewRow2">
UPDATE AccredLocations
SET
<cfset Dump = #ReplaceNoCase(Form.AccredScope,chr(13),"<br>", "ALL")#>
AccredScope='#Dump#',
LocalAudit='#Form.LocalAudit#',
AuditFrequency=#Form.AuditFrequency#,
AdditionalRequirements='#Form.AdditionalRequirements#',
AdditionalRequirementsNotes='#Form.AdditionalRequirementsNotes#',
Status='#Form.Status#',
Posted=#postDate#,
PostedBy='#Form.PostedBy#',
Notes='#Form.Notes#',
IQANotes='Record added #dateformat(postDate, "mm/dd/yyyy")# by #Form.PostedBy#'

WHERE ID = #NewID.NewID#
</CFQUERY>

<cflocation url="viewItem.cfm?ID=#NewID.NewID#" addtoken="no">

</cfif>