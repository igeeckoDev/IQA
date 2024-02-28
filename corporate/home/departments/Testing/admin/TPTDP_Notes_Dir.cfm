<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#URL.ExternalLocation#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="Status">
UPDATE AuditSchedule
SET
FollowUp='Notes'
WHERE ID = #URL.ID#
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="TPTDP">
<cflocation url="TPTDP_Notes_Add.cfm?ID=#ID#" addtoken="no">
</cfoutput>