<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
UPDATE AuditSchedule
SET 
InitialSiteAudit = #Form.Initial#

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?#CGI.Query_String#" addtoken="No">