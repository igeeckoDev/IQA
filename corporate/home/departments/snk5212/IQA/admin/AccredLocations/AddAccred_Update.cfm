<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From Accreditors
Order BY Accreditor
</CFQUERY>

<cfoutput query="Accred">
<cfif Form.Accreditor is "#Accreditor#">
	<cfif Status is "remove">
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
        UPDATE Accreditors
        SET 
        Status = NULL
        WHERE Accreditor = '#Form.Accreditor#'
        </CFQUERY>
    		<cflocation url="AddAccred.cfm" addtoken="no">
    	<cfelse>
   			<cflocation url="AddAccred.cfm?msg=duplicate&id=#ID#" addtoken="no">
    </cfif>
</cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM Accreditors
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO Accreditors(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE Accreditors
SET 
Accreditor='#Form.Accreditor#'
WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="AddAccred.cfm" addtoken="no">