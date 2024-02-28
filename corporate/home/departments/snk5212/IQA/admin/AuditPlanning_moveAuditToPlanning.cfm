<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
SELECT * FROM Corporate.AuditSchedule
WHERE
Year_ = #URL.Year#
AND ID = #URL.ID#
AND AuditedBy = 'IQA'
</cfquery>

<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
SELECT
xGUID, ID, Year_, AuditedBy, Month, Approved, AuditType, AuditType2, Area,
OfficeName, AuditArea, LeadAuditor, Auditor, AuditorInTraining,
Email, Email2, BusinessUnit, Status, Desk, SME, AuditDays

FROM
Corporate.AuditSchedule

WHERE
Year_ = #URL.Year#
AND ID = #URL.ID#
AND AuditedBy = 'IQA'
</CFQUERY>

<cfoutput query="getAuditsFromSchedule">
	<CFQUERY BLOCKFACTOR="100" NAME="InsertAudits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO
	UL06046.AuditSchedule_Planning(
	xGUID, ID, Year_, AuditedBy, Month, Approved, AuditType, AuditType2, Area, OfficeName, AuditArea,
	LeadAuditor, Auditor, AuditorInTraining, Email, Email2, BusinessUnit, Status, Desk, SME, AuditDays)

	VALUES(
	#xGUID#, #ID#, #Year_#, '#AuditedBy#', #Month#, 'Yes', '#AuditType#', '#AuditType2#', '#Area#', '#OfficeName#', '#AuditArea#',
	'#LeadAuditor#', ('#Auditor#'), '#AuditorInTraining#', ('#Email#'), ('#Email2#'), ('#BusinessUnit#'), '#Status#', '#Desk#', '#SME#', '#AuditDays#')
	</CFQUERY>
</cfoutput>