<cfif len(Form.Industry)>
    <CFQUERY Name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_Industry
    WHERE Industry = '#trim(Form.Industry)#'
    </CFQUERY>
    
    <cfif check.recordCount EQ 0>
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT MAX(ID) + 1 AS newid FROM TechnicalAudits_Industry
        </CFQUERY>
        
        <cfif NOT len(ID.newID)>
            <cfset ID.newID = 1>
        </cfif>
        
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO TechnicalAudits_Industry(ID)
        VALUES (#ID.newid#)
        </CFQUERY>
        
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_Industry
        SET 
        Industry='#trim(Form.Industry)#'
        WHERE ID = #ID.newid#
        </CFQUERY>
        
        <!--- Industry added --->
        <cflocation url="Industry.cfm?var=Add&value=#FORM.Industry#" addtoken="no">
    <cfelse>
    	<!--- Industry already exists --->
        <cflocation url="Industry.cfm?var=Duplicate&value=#FORM.Industry#" ADDTOKEN="No">
    </cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="Industry.cfm?var=Blank" addtoken="no">
</cfif>