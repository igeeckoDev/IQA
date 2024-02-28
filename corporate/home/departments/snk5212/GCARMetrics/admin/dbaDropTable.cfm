<cfif NOT isDefined("URL.Table")>
	No table named.
<cfelse>
    <cfoutput>
        <CFQUERY BLOCKFACTOR="100" NAME="DropTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        Drop TABLE #URL.Table#
        </CFQUERY>
    
    <cfif url.Table eq "GCAR_Metrics_NewImport">
    	<cfset step = 3>
    <cfelseif url.Table eq "GCAR_Metrics_Old">
    	<cfset step = 10>
    </cfif>
    
    <cflocation url="AdminMenu_DataUpdate.cfm?complete=#step#" addtoken="no">
    </cfoutput>
</cfif>