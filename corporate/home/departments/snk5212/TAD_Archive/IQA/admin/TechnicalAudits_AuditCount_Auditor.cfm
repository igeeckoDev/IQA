<CFQUERY NAME="query" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT A.Auditor, DECODE(B.Cnt, NULL, 0, B.Cnt)
FROM (
	SELECT Auditor FROM Auditors 
	WHERE Status IS NULL
	AND Type = 'TechnicalAudit'
    ORDER BY Auditor
    ) A
LEFT JOIN (
	SELECT Auditor, Count(*) as Cnt
    FROM TechnicalAudits_AuditSchedule
    WHERE Auditor IS NOT NULL
    GROUP BY Auditor
    ) B
ON A.Auditor = B.Auditor
</CFQUERY>

<cfdump var="#query#">