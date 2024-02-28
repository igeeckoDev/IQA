<CFQUERY BLOCKFACTOR="100" NAME="CCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Count(Auditor) as CCNCount
FROM TechnicalAudits_AuditSchedule
WHERE CCN = 'CDEF'
Group By Auditor
Order By Auditor
</cfquery>

<cfdump var="#CCN#">