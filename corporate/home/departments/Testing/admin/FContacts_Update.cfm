<CFQUERY Name="FContact" Datasource="Corporate">
SELECT * From FContact
Order BY FContact
</CFQUERY>

<cfoutput query="FContact">
	<cfif Form.FContact is "#FContact#">
		<cflocation url="FContacts.cfm?msg=duplicate&id=#ID#">
	</cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM FContact
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO FContact(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE FContact
SET 
FContact='#Form.FContact#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="FContacts.cfm" ADDTOKEN="No">