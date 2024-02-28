<CFQUERY Name="DupCheck" Datasource="Corporate">
SELECT * From FUSAreas
WHERE Area = '#Form.Area#'
AND ID <> #URL.ID#
</CFQUERY>

<cfoutput query="DupCheck">
	<cfif Form.Area is "#Area#">
        <cflocation url="FUS2.cfm?msg=duplicate&id=#DupCheck.ID#" addtoken="no">
    </cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddRD">
UPDATE FUSAreas
SET 
Area='#Form.Area#'
WHERE ID=#url.id#
</CFQUERY>

<cflocation url="FUS2.cfm?msg=edited&id=#ID#" ADDTOKEN="No">