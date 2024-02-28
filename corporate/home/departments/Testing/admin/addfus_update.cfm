<cfif form.area is "">
	<cflocation url="FUS2.cfm" addtoken="no">
</cfif>

<CFQUERY Name="DupCheck" Datasource="Corporate">
SELECT * 
From FUSAreas
WHERE Area = '#Form.Area#'
</CFQUERY>

<cfoutput query="DupCheck">
	<cfif Form.Area is "#Area#">
        <cflocation url="FUS2.cfm?msg=duplicate&id=#DupCheck.ID#" addtoken="no">
    </cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FUSID">
SELECT MAX(ID) + 1 AS newid FROM FusAreas
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FUSIDAdd">
INSERT INTO FUSAreas(ID, Area)
VALUES (#FUSID.newid#, '#Form.Area#')
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddRD">
UPDATE FUSAreas
SET 
Area='#Form.Area#'
WHERE ID=#FUSID.newid#
</CFQUERY>

<cflocation url="FUS2.cfm?msg=added&id=#FUSID.newid#" addtoken="no">