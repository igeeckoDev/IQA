<cfif len(Form.StandardName) AND len(Form.RevisionDate) AND len(Form.RevisionNumber)>
    <CFQUERY Name="origValue" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From TechnicalAudits_Standard
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cfif Form.StandardName neq origValue.StandardName
    	OR Form.RevisionNumber neq origValue.RevisionNumber
        OR Form.RevisionDate neq origValue.RevisionDate>
            <CFQUERY Name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT * 
            From TechnicalAudits_Standard
            WHERE StandardName = '#trim(Form.StandardName)#'
            AND ID <> #URL.ID#
            </CFQUERY>
    
            <cfif check.recordCount EQ 0>
                <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit" username="#OracleDB_Username#" password="#OracleDB_Password#">
                UPDATE TechnicalAudits_Standard
                SET 
                StandardName='#trim(Form.StandardName)#',
                RevisionNumber='#trim(Form.RevisionNumber)#',
                RevisionDate=#CreateODBCDate(Form.RevisionDate)#
                WHERE ID = #URL.ID#
                </CFQUERY>
        
                <cflocation url="Standard.cfm?var=Edit&value=#FORM.StandardName#, (#Form.RevisionNumber#, #Form.RevisionDate#)&origValue=#origValue.StandardName#, (#origValue.RevisionNumber#, #dateformat(origValue.RevisionDate, 'mm/dd/yyyy')#)" ADDTOKEN="No">
        <cfelse>
            <!--- changing Standard Name to an already existing Standard Name --->
            <cflocation url="Standard.cfm?var=EditDuplicate&value=#FORM.StandardName#, (#Form.RevisionNumber#, #Form.RevisionDate#)&origValue=#origValue.StandardName#, (#origValue.RevisionNumber#, #origValue.RevisionDate#)" ADDTOKEN="No">
        </cfif>
   	<cfelse>
	<!--- Standard edit - Name, Date, and Number are the same --->
   		<cflocation url="Standard.cfm?var=NoEditChange&Value=#FORM.StandardName#, (#Form.RevisionNumber#, #Form.RevisionDate#)" addtoken="no">
   	</cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="Standard.cfm?var=Blank" addtoken="no">
</cfif>