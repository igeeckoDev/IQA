<cfif IsDefined("URL.ID") 
	AND IsDefined("URL.verifyID") 
    AND Hash(URL.ID) IS "#URL.verifyID#">
      
    <CFQUERY Name="User" Datasource="Corporate">
    SELECT Name, Status
    From IQADB_Login
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <Cfif User.Status eq "Removed">
    	<cfset curStatus = user.Status>
    <cfelse>
    	<cfset curStatus = "Active">
    </Cfif>
    
    <cfif Form.Status neq curStatus>
        <CFQUERY Name="UserUpdate" Datasource="Corporate">
        UPDATE IQADB_Login
        SET
        
        <cfif Form.Status eq "Active">
            Status = null
        <cfelseif Form.Status eq "Removed">
            Status = 'Removed'
        </cfif>
        
        WHERE ID = #URL.ID#
        </CFQUERY>
    
        <cflocation url="TechnicalAudits_AccessControl.cfm?msg=Status Updated to #Form.Status# for #User.Name#" addtoken="no">
	<cfelseif Form.Status neq User.Status>
    	<cflocation url="TechnicalAudits_AccessControl.cfm?msg=No Status Change Made for #User.Name#" addtoken="no">
    </cfif>
<cfelse>
	<cflocation url="TechnicalAudits_AccessControl.cfm?msg=Access Denied" addtoken="no">
</cfif>