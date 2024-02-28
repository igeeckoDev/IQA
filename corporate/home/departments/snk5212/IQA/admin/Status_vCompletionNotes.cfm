<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<table border="0" width="100%">
<tr><Td class="blog-content">
<cfoutput query="Audit">
<b>Audit #year#-#id#</b><br>
<u>Audit Scope and Report Completion Notes</u>:<br><br>
#CompletionNotes#
</cfoutput>

</TD></tr>
</table>