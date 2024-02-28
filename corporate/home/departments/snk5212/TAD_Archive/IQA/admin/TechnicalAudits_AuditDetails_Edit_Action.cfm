<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT #url.var#, History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfif evaluate("FORM.#url.var#") eq #evaluate("History.#url.var#")#>
	<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
<cfelse>
	<!--- add url.var value --->
    <CFQUERY Name="Assign" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    <cfif url.var eq "CCN" OR url.var eq "CCN2">
    #url.var# = UPPER('#evaluate("form.#url.var#")#'),
    <cfelseif url.var eq "Month">
    #url.var# = #evaluate("form.#url.var#")#,
    <cfelse>
    #url.var# = '#evaluate("form.#url.var#")#',
    </cfif>
    
    <cfset HistoryUpdate1 = "#url.label#: #evaluate("form.#url.var#")#<br />">
    
   	<cfif len(evaluate("History.#url.var#"))>
    	<cfset HistoryUpdate2 = "Old #url.var#: #evaluate("History.#url.var#")#<br />">
    <cfelse>
    	<cfset HistoryUpdate2 = "">
   	</cfif>
    
    <cfset HistoryUpdate3 = "Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />Date: #curdate# #curTime#">
   
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br>#HistoryUpdate1##HistoryUpdate2##HistoryUpdate3#" CFSQLTYPE="CF_SQL_CLOB">
   
    WHERE 
    Year_ = #URL.Year#
    AND ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#url.label# has been updated" addtoken="no">
</cfif>