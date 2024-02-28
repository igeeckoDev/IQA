<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="Status">
UPDATE AuditSchedule
SET
FollowUp='Notes'
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addinfo">
UPDATE ExternalLocation
SET

<cfset N1 = #ReplaceNoCase(Form.e_Notes,chr(13),"<br>", "ALL")#>
Notes='#N1#'

WHERE ID = #URL.exID#	
</cfquery>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ID = #url.exid#
</CFQUERY>

<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<cfoutput query="TPTDP">
<table border="0" width="100%">
<tr><Td class="blog-content">
<a href="javascript:;" onclick="opener.location='TPTDP_Notes.cfm?ID=#ID#';self.close()">Confirm Notes</a> and Close This Window<br>
<a href="Status_Notes.cfm?externallocation=#externallocation#&year=#url.year#&id=#url.id#">Edit</a> Notes<br><br>
<u>Status/Follow-Up Notes for #ExternalLocation#</u>:<br>
#Notes#
</td></tr>
</table>
</cfoutput>