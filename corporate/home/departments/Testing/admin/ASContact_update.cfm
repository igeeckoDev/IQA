<CFQUERY Name="ASContact" Datasource="Corporate">
SELECT * From ASContact
Order BY ASContact
</CFQUERY>

<cfoutput query="ASContact">
	<cfif Form.ASContact is "#ASContact#">
        <cflocation url="ASContact.cfm?msg=duplicate&id=#ID#" ADDTOKEN="No">
    </cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM ASContact
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO ASContact(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE ASContact
SET 
ASContact='#Form.ASContact#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="ASContact.cfm" ADDTOKEN="No">