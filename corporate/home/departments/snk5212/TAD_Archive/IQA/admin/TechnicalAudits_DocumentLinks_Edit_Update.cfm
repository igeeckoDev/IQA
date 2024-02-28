<cfif len(Form.HTTPLinkName) AND len(Form.HTTPLink)>
    <CFQUERY Name="origValue" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    From  TechnicalAudits_Links
    WHERE Label = '#URL.Label#'
    </CFQUERY>
    
    <cfif Form.HTTPLinkName neq origValue.HTTPLinkName
    	OR Form.HTTPLink neq origValue.HTTPLink>
            <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE  TechnicalAudits_Links
            SET 
            HTTPLinkName='#trim(Form.HTTPLinkName)#',
            HTTPLink='#trim(Form.HTTPLink)#'
    		WHERE Label = '#URL.Label#'
            </CFQUERY>
        
            <cflocation url="TechnicalAudits_DocumentLinks.cfm?var=Edit&value=#FORM.HTTPLinkName# / #FORM.HTTPLink#&origValue=#origValue.HTTPLinkName# / #origValue.HTTPLink#)" ADDTOKEN="No">
   	<cfelse>
	<!--- Edit - Name, Date, and Number are the same --->
   		<cflocation url="TechnicalAudits_DocumentLinks.cfm?var=NoEditChange&Value=#FORM.HTTPLinkName# / #FORM.HTTPLink#" addtoken="no">
   	</cfif>
<!--- Form was left blank --->
<cfelse>
	<cflocation url="TechnicalAudits_DocumentLinks.cfm?var=Blank" addtoken="no">
</cfif>