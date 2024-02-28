<CFQUERY Name="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Industry
From TechnicalAudits_Industry
WHERE ID = #URL.ID#
</CFQUERY>

<cfif url.Action eq "Remove">
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="RemoveIndustry" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_Industry
    SET
    Status = 'Removed'
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="Industry.cfm?ID=#URL.ID#&Value=#Industry.Industry#&var=Status&Action=Removed" ADDTOKEN="No">
<cfelseif url.Action eq "Reinstate">
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReinstateIndustry" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_Industry
    SET
    Status = NULL
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="Industry.cfm?ID=#URL.ID#&Value=#Industry.Industry#&var=Status&Action=Active" ADDTOKEN="No">
</cfif>