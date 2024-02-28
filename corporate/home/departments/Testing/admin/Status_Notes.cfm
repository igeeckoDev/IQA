<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#URL.ExternalLocation#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP2">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<table border="0" width="100%">
<tr><Td class="blog-content">
<cfoutput query="TPTDP">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="TPTDP" ACTION="Status_Notes_Submit.cfm?exID=#ID#&year=#url.year#&id=#url.id#">
</cfoutput>

<cfoutput query="TPTDP">
Status/Follow-Up Notes for #externallocation#:<br>
<cfset N1 = #ReplaceNoCase(Notes, "<br>", chr(13), "ALL")#>
<textarea WRAP="PHYSICAL" ROWS="6" COLS="50" NAME="e_Notes" displayname="Notes" Value="#N1#">#N1#</textarea><br><br>
</cfoutput>

<INPUT TYPE="Submit" value="Submit Notes">
</FORM>
</TD></tr>
</table>