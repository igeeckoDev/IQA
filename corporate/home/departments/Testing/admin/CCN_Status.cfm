<CFQUERY Name="CCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CCN
From TechnicalAudits_CCN
WHERE ID = #URL.ID#
</CFQUERY>

<cfif url.Action eq "Remove">
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="RemoveCCN" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_CCN
    SET
    Status = 'Removed'
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="CCN.cfm?ID=#URL.ID#&Value=#CCN.CCN#&var=Status&Action=Removed" ADDTOKEN="No">
<cfelseif url.Action eq "Reinstate">
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReinstateCCN" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_CCN
    SET
    Status = NULL
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="CCN.cfm?ID=#URL.ID#&Value=#CCN.CCN#&var=Status&Action=Active" ADDTOKEN="No">
</cfif>