<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#URL.ExternalLocation#'
</CFQUERY>

<cfoutput query="TPTDP">
<cflocation url="TPTDP_Notes.cfm?ID=#ID#" addtoken="no">
</cfoutput>