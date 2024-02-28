<cfif len(Form.CCN)>
    <CFQUERY Name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_CCN
    WHERE CCN = '#trim(Form.CCN)#'
    </CFQUERY>
    
    <cfif check.recordCount EQ 0>
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ID">
        SELECT MAX(ID) + 1 AS newid FROM TechnicalAudits_CCN
        </CFQUERY>
        
        <cfif NOT len(ID.newID)>
            <cfset ID.newID = 1>
        </cfif>
        
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO TechnicalAudits_CCN(ID)
        VALUES (#ID.newid#)
        </CFQUERY>
        
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_CCN
        SET 
        CCN='#trim(Form.CCN)#'
        WHERE ID = #ID.newid#
        </CFQUERY>
        
        <!--- CCN added --->
        <cflocation url="CCN.cfm?var=Add&value=#FORM.CCN#" addtoken="no">
    <cfelse>
    	<!--- CCN already exists --->
        <cflocation url="CCN.cfm?var=Duplicate&value=#FORM.CCN#" ADDTOKEN="No">
    </cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="CCN.cfm?var=Blank" addtoken="no">
</cfif>