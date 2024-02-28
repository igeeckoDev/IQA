<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Current">
SELECT VS, WiSE, LHS, LabScope, Log, ULE
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<cfif Current.VS eq Form.VS 
	AND Current.ULE eq Form.ULE
	AND Current.WiSE eq Form.WiSE
    AND Current.LHS eq Form.LHS
    AND Current.LabScope eq Form.LabScope>
    
    <cflocation url="Office_Details.cfm?ID=#URL.ID#&msg=No Values Changed" addtoken="no">

<cfelse>
    <cfset AddToLog = "Additional Information Section - Update">
    
    <cfif Current.VS neq Form.VS>
        <cfset AddToLog = "VS Internal Audit Site set to <b>#Form.VS#</b>">
    </cfif>
    
    <cfif Current.ULE neq Form.ULE>
        <cfset AddToLog = "ULEInternal Audit Site set to <b>#Form.ULE#</b>">
    </cfif>
    
    <cfif Current.WiSE neq Form.WiSE>
        <cfset AddToLog = "#AddToLog#<br>WiSE Internal Audit Site set to <b>#Form.WiSE#</b>">
    </cfif>
    
    <cfif Current.LHS neq Form.LHS>
        <cfset AddToLog = "#AddToLog#<br>LHS Internal Audit Site set to <b>#Form.LHS#</b>">
    </cfif>
    
    <cfif Current.LabScope neq Form.LabScope>
        <cfset AddToLog = "#AddToLog#<br>Lab Scope Review Required set to <b>#Form.LabScope#</b>">
    </cfif>
    
    <cflock scope="session" timeout="5">
        <cfset AddToLog = "#AddToLog#<br>Date: #curdate# #curtime#<br>Username: #SESSION.Auth.Username# / #SESSION.Auth.Email#">
    </cflock>
    
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
    UPDATE IQAtblOffices
    SET 
    
    VS = '#Form.VS#',
    ULE = '#Form.ULE#',
    WiSE = '#Form.WiSE#',
    LHS = '#Form.LHS#',
    LabScope = '#Form.LabScope#',
    <cfif len(Current.Log)>
    Log = <cfqueryparam cfsqltype="cf_sql_clob" value="#AddToLog#<br><br>#Current.Log#">
    <cfelse>
    Log = <cfqueryparam cfsqltype="cf_sql_clob" value="#AddToLog#">
    </cfif>
    
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="Office_Details.cfm?ID=#URL.ID#&msg=Values Updated. See Activity Log for Details" addtoken="no">
</cfif>