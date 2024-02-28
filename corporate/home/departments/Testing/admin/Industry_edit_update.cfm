<cfif len(Form.Industry)>
    <CFQUERY Name="origValue" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_Industry
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cfif Form.Industry neq origValue.Industry>
        <CFQUERY Name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * 
        From TechnicalAudits_Industry
        WHERE Industry = '#trim(Form.Industry)#'
        AND ID <> #URL.ID#
        </CFQUERY>
    
        <cfif check.recordCount EQ 0>
            <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_Industry
            SET 
            Industry='#trim(Form.Industry)#'
            WHERE ID = #URL.ID#
            </CFQUERY>
    
            <cflocation url="Industry.cfm?var=Edit&value=#FORM.Industry#&origValue=#origValue.Industry#" ADDTOKEN="No">
        <cfelse>
            <!--- changing Industry name to an already existing Industry --->
            <cflocation url="Industry.cfm?var=EditDuplicate&value=#FORM.Industry#&origValue=#origValue.Industry#" ADDTOKEN="No">
        </cfif>
	<!--- Industry edit - no change made as value is the same --->
    <cfelse>
    	<cflocation url="Industry.cfm?var=NoEditChange&Value=#Form.Industry#" addtoken="no">
    </cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="Industry.cfm?var=Blank" addtoken="no">
</cfif>