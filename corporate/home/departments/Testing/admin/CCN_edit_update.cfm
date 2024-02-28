<cfif len(Form.CCN)>
    <CFQUERY Name="origValue" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_CCN
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cfif Form.CCN neq origValue.CCN>
        <CFQUERY Name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * 
        From TechnicalAudits_CCN
        WHERE CCN = '#trim(Form.CCN)#'
        AND ID <> #URL.ID#
        </CFQUERY>
    
        <cfif check.recordCount EQ 0>
            <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_CCN
            SET 
            CCN='#trim(Form.CCN)#'
            WHERE ID = #URL.ID#
            </CFQUERY>
    
            <cflocation url="CCN.cfm?var=Edit&value=#FORM.CCN#&origValue=#origValue.CCN#" ADDTOKEN="No">
        <cfelse>
            <!--- changing CCN name to an already existing CCN --->
            <cflocation url="CCN.cfm?var=EditDuplicate&value=#FORM.CCN#&origValue=#origValue.CCN#" ADDTOKEN="No">
        </cfif>
	<!--- CCN edit - no change made as value is the same --->
    <cfelse>
    	<cflocation url="CCN.cfm?var=NoEditChange&Value=#Form.CCN#" addtoken="no">
    </cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="CCN.cfm?var=Blank" addtoken="no">
</cfif>