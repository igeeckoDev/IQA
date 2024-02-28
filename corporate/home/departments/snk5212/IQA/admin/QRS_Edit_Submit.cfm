<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Scope='#FORM.Scope#',
AuditType='#FORM.AuditType#',
Auditor='#Form.Auditor#',
OfficeName='#Form.OfficeName#',
Email='#Form.Email#'

WHERE ID=#url.id# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#url.id# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="scheduleedit">
<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" addtoken="no">
</cfoutput>