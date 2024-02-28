<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From ASAccreditors
Order BY Accreditor
</CFQUERY>

<cfoutput query="Accred">
	<cfif Form.Accreditor is "#Accreditor#">
		<cfif Status is "remove">
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
			UPDATE ASAccreditors
            SET 
            Status = NULL
            WHERE Accreditor = '#Form.Accreditor#'
            </CFQUERY>
			<cflocation url="ASAccred.cfm" ADDTOKEN="No">
		<cfelse>
			<cflocation url="ASaccred.cfm?msg=duplicate&id=#ID#" ADDTOKEN="No">
		</cfif>
	</cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM ASAccreditors
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO ASAccreditors(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE ASAccreditors
SET 
Accreditor='#Form.Accreditor#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="ASAccred.cfm" ADDTOKEN="No">