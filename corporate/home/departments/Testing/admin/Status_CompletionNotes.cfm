<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>	
<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<table border="0" width="100%">
<tr><Td class="blog-content">
<cfoutput query="Audit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="TPTDP" ACTION="Status_CompletionNotes_Submit.cfm?year=#url.year#&id=#url.id#&page=status2">
</cfoutput>

<cfoutput query="Audit">
Audit Scope and Report Completion Notes for #year#-#id#:<br>
<cfset N1 = #ReplaceNoCase(CompletionNotes, "<br>", chr(13), "ALL")#>
<textarea WRAP="PHYSICAL" ROWS="16" COLS="50" NAME="e_Notes" displayname="Notes" Value="#N1#">#N1#</textarea><br><br>
</cfoutput>

<INPUT TYPE="Submit" value="Submit Notes">
</FORM>
</TD></tr>
</table>