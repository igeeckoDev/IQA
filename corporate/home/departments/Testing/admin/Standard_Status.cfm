<CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
From TechnicalAudits_Standard
WHERE ID = #URL.ID#
</CFQUERY>

<cfif url.Action eq "Remove">
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="RemoveStandard" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_Standard
    SET
    Status = 'Removed'
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="Standard.cfm?ID=#URL.ID#&Value=#Standard.StandardName# (#Standard.RevisionNumber#, #Standard.RevisionDate#)&var=Status&Action=Removed" ADDTOKEN="No">
<cfelseif url.Action eq "Reinstate">
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReinstateStandard" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_Standard
    SET
    Status = NULL
    WHERE ID = #URL.ID#
    </CFQUERY>
    
    <cflocation url="Standard.cfm?ID=#URL.ID#&Value=#Standard.StandardName#, (#Standard.RevisionNumber#, #Standard.RevisionDate#)&var=Status&Action=Active" ADDTOKEN="No">
</cfif>