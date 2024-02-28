<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID# AND Year_ = #URL.Year#
</cfquery>

<cfif Audit.Approved eq "Yes" OR Audit.Flag_CurrentStep NEQ "Audit Details (1) Entered">
	<cflocation url="#IQADir#TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">
<cfelseif Audit.Flag_CurrentStep eq "Audit Details (1) Entered">
    <CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    Flag_CurrentStep = 'Audit Details (2) Entered'
    
    WHERE ID = #URL.ID# 
    AND Year_ = '#URL.Year#'
    </CFQUERY>
    
    <cflocation url="TechnicalAudits_AddAudit3.cfm?#CGI.Query_String#" addtoken="no">
</cfif>