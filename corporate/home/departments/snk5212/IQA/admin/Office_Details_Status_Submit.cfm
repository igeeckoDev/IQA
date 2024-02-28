<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Current">
SELECT Exist, Log
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<cfif Current.Exist eq Form.Exist>
    
    <cflocation url="Office_Details_Status.cfm?ID=#URL.ID#&msg=No Values Changed" addtoken="no">

<cfelse>
    <cfset AddToLog = "Additional Information Section - Update">
    
    <cfif Current.Exist neq Form.Exist>
        <cfset AddToLog = "Site Status Changed to <cfif Exist eq Yes>Active<cfelse>Inactive</cfif>">
    </cfif>
        
    <cflock scope="session" timeout="5">
        <cfset AddToLog = "#AddToLog#<br>Date: #curdate# #curtime#<br>Username: #SESSION.Auth.Username# / #SESSION.Auth.Email#">
    </cflock>
    
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
    UPDATE IQAtblOffices
    SET 
    
    Exist = '#Form.Exist#',

    <cfif len(Current.Log)>
		Log = <cfqueryparam cfsqltype="cf_sql_clob" value="#AddToLog#<br><br>#Current.Log#">
    <cfelse>
		Log = <cfqueryparam cfsqltype="cf_sql_clob" value="#AddToLog#">
    </cfif>
    
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="Office_Details_Status.cfm?ID=#URL.ID#&msg=Values Updated. See Activity Log for Details" addtoken="no">
</cfif>