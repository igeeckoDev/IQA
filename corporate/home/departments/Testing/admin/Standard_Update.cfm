<cfif len(Form.StandardName) AND len(Form.RevisionDate) AND len(Form.RevisionNumber)>
    <CFQUERY Name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_Standard
    WHERE StandardName = '#trim(Form.StandardName)#'
    AND RevisionDate = #CreateODBCDate(Form.RevisionDate)#
    AND RevisionNumber = '#Form.RevisionNumber#'
    </CFQUERY>
    
    <cfif check.recordCount EQ 0>
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT MAX(ID) + 1 AS newid FROM TechnicalAudits_Standard
        </CFQUERY>
        
        <cfif NOT len(ID.newID)>
            <cfset ID.newID = 1>
        </cfif>
        
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddID" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO TechnicalAudits_Standard(ID)
        VALUES (#ID.newid#)
        </CFQUERY>
        
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_Standard
        SET 
        StandardName='#trim(Form.StandardName)#',
		RevisionDate = #CreateODBCDate(Form.RevisionDate)#,
		RevisionNumber = '#Form.RevisionNumber#'
        WHERE ID = #ID.newid#
        </CFQUERY>
        
        <!--- Standard added --->
        <cflocation url="Standard.cfm?var=Add&value=#FORM.StandardName#, (#Form.RevisionNumber#, #Form.RevisionDate#)" addtoken="no">
    <cfelse>
    	<!--- Standard already exists --->
        <cflocation url="Standard.cfm?var=Duplicate&value=#FORM.StandardName#, (#Form.RevisionNumber#, #Form.RevisionDate#)" ADDTOKEN="No">
    </cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="Standard.cfm?var=Blank" addtoken="no">
</cfif>