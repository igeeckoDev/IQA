    <cfquery Datasource="UL06046" name="checkRole" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
    SELECT 
        UL06046.TechnicalAudits_AuditSchedule.AuditorEmail, UL06046.TechnicalAudits_AuditSchedule.AuditorManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerDirectorEmail, Corporate.IQAtblOffices.TechnicalAudits_SQM, Corporate.IQARegion.TechnicalAudits_ROM, UL06046.TechnicalAudits_Industry.Contact, UL06046.TechnicalAudits_AuditSchedule.AppealResponseEmail, UL06046.TechnicalAudits_AuditSchedule.AppealDecisionEmail, UL06046.TechnicalAudits_AuditSchedule.NCEnteredAssignEmail
    FROM 
        UL06046.TechnicalAudits_AuditSchedule, Corporate.IQAtblOffices, Corporate.IQARegion, UL06046.TechnicalAudits_Industry
    WHERE 
        UL06046.TechnicalAudits_AuditSchedule.ID = 1055
        AND UL06046.TechnicalAudits_AuditSchedule.Year_ = 2012
        AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = Corporate.IQAtblOffices.OfficeName
        AND UL06046.TechnicalAudits_AuditSchedule.Region = Corporate.IQARegion.Region
        AND UL06046.TechnicalAudits_AuditSchedule.Industry = UL06046.TechnicalAudits_Industry.Industry
    </CFQUERY>

<cfdump var="#checkRole#">