<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="addinfo">
UPDATE ExternalLocation
SET

<cfset N1 = #ReplaceNoCase(Form.e_Notes,chr(13),"<br>", "ALL")#>
Notes='#N1#'

WHERE ID = #URL.ID#	
</cfquery>

<cflocation url="TPTDP_Notes.cfm?ID=#URL.ID#" addtoken="no">