<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="Status">
UPDATE AuditSchedule
SET
<cfset N1 = #ReplaceNoCase(Form.e_Notes,chr(13),"<br>", "ALL")#>
CompletionNotes = '#N1#'

WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<cfoutput query="Audit">
<table border="0" width="100%">
<tr>
<Td class="blog-content">
<u>Audit Scope and Report Completion Notes for #year#-#id#</u>:<br>
#CompletionNotes#</td>
</tr>
<tr>
<td class="article-end">&nbsp;

</td>
</tr>
<tr>
<Td class="blog-content">
<br>
<a href="javascript:;" onclick="opener.location='#url.page#.cfm?year=#year#&month=#month#';self.close()">Confirm Notes</a> and Close This Window
</td>
</table>
</cfoutput>