<cfquery Datasource="Corporate" name="getData">
SELECT
	IQAOffices_Areas.ID, IQAOffices_Areas.LABID, IQAOffices_Areas.Lab, IQAOffices_Areas.LTA,
    IQAtblOffices.ID, IQAtblOffices.OfficeName,
    IQA_LTA_Capabilities.LABID, IQA_LTA_Capabilities.Standard
FROM
	IQAOffices_Areas, IQAtblOffices, IQA_LTA_Capabilities
WHERE
	IQAOffices_Areas.ID = IQAtblOffices.ID AND
    IQA_LTA_Capabilities.LabID = IQAOffices_Areas.LabID AND
    IQAOffices_Areas.LabID = 60
ORDER BY
	IQAtblOffices.OfficeName, IQAOffices_Areas.Lab, IQA_LTA_Capabilities.Standard
</cfquery>

<cfdump var="#getData#">

<cfset OfficeHolder = "">
<cfoutput query="getData">
	<cfif OfficeHolder IS NOT OfficeName>
    <cfIf OfficeHolder is NOT ""><br></cfif>
    <b><u>#OfficeName#</u> - #Lab#</b><br>
    </cfif>
#Standard#<br>

<cfset OfficeHolder = OfficeName>
</cfoutput>