<cfquery Datasource="Corporate" name="Labs"> 
SELECT 
	IQAOffices_Areas.Lab, IQAtblOffices.OfficeName 
FROM 
	IQAOffices_Areas, IQAtblOffices
WHERE 
	LTA = 1
    AND IQAtblOffices.ID = IQAOffices_Areas.ID
ORDER BY 
	OfficeName, Lab
</CFQUERY>

<cfset officeHolder = "">
<cfoutput query="Labs">
	<cfif OfficeHolder IS NOT OfficeName> 
    <cfIf OfficeHolder is NOT ""><br></cfif>
    <b><u>#OfficeName#</u></b><br> 
    </cfif>
    #Lab#<br />
<cfset OfficeHolder = OfficeName>
</cfoutput>