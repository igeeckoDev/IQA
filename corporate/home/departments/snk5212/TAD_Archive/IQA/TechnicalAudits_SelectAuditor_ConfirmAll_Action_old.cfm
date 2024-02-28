<!--- update row --->
<CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

AuditorAssigned = 'Yes',
Flag_CurrentStep = 'Auditor Selected'

WHERE ID = #URL.ID# 
AND Year_ = '#URL.Year#'
</CFQUERY>

<!--- mail to TAM --->

<cflocation url="TechnicalAudits_viewAuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">