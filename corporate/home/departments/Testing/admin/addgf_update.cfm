<CFQUERY Name="check" Datasource="Corporate">
SELECT * 
From GlobalFunctions
WHERE Function = '#Form.GF#'
</CFQUERY>

<cfif check.recordCount EQ 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ID">
    SELECT MAX(ID) + 1 AS newid FROM GlobalFunctions
    </CFQUERY>
    
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
    INSERT INTO GlobalFunctions(ID)
    VALUES (#ID.newid#)
    </CFQUERY>
    
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
    UPDATE GlobalFunctions
    SET 
    Function='#Form.GF#',
    Owner='#Form.Owner#'
    WHERE ID=#ID.newid#
    </CFQUERY>
    
    <cflocation url="GF.cfm?var=Add&value=#FORM.GF#" addtoken="no">
<cfelse>
	<cflocation url="GF.cfm?var=Duplicate&value=#FORM.GF#" ADDTOKEN="No">
</cfif>