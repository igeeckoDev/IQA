<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="DeleteBackupData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
DELETE FROM UL06046.AuditSchedule_Planning_Backup
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CopyData" Datasource="UL06046_IN">
INSERT INTO UL06046.AuditSchedule_Planning_Backup
SELECT * FROM UL06046.AuditSchedule_Planning
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="CheckBackup" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*), Year_
FROM UL06046.AuditSchedule_Planning_Backup
GROUP BY Year_
ORDER BY Year_
</cfquery>

<cfdump var="#CheckBackup#">

<CFQUERY BLOCKFACTOR="100" NAME="CheckAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*), Year_
FROM UL06046.AuditSchedule_Planning
GROUP BY Year_
ORDER BY Year_
</cfquery>

<cfdump var="#CheckAuditSchedule#">

<cfmail
	to="Christopher.J.Nicastro@ul.com"
	from="Internal.Quality_Audits@ul.com"
	subject="UL06046.AuditSchedule_Planning Backup Completed"
	type="HTML">
Backup Table - <cfdump var="#CheckBackup#"><Br><br>

AuditSchedule_Planning Table - <cfdump var="#CheckAuditSchedule#">
</cfmail>