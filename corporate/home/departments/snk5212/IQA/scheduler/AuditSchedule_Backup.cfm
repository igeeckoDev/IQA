<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="DeleteBackupData" Datasource="UL06046" username="UL06046" password="UL06046">
DELETE FROM UL06046.AuditSchedule_Backup
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CopyData" Datasource="UL06046_IN">
INSERT INTO UL06046.AuditSchedule_Backup
SELECT * FROM Corporate.AuditSchedule
WHERE Year_ = 2018
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="CheckBackup" Datasource="UL06046" username="UL06046" password="UL06046">
SELECT Count(*), Year_
FROM UL06046.AuditSchedule_Backup
GROUP BY Year_
ORDER BY Year_
</cfquery>

<cfdump var="#CheckBackup#">

<CFQUERY BLOCKFACTOR="100" NAME="CheckAuditSchedule" Datasource="Corporate">
SELECT Count(*), Year_
FROM Corporate.AuditSchedule
GROUP BY Year_
ORDER BY Year_
</cfquery>

<cfdump var="#CheckAuditSchedule#">

<cfmail
	to="Christopher.J.Nicastro@ul.com"
	from="Internal.Quality_Audits@ul.com"
	subject="Corporate.AuditSchedule Backup Completed"
	type="HTML">
Backup Table - <cfdump var="#CheckBackup#"><Br><br>

AuditSchedule Table - <cfdump var="#CheckAuditSchedule#">
</cfmail>