<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Old">
SELECT * FROM ExternalLocation
WHERE ExternalLocation='#URL.TP#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE ExternalLocation
SET 

<cfif IsDefined("Form.Watch")>
Watch=#Form.Watch#,
<cfelse>
Watch=0,
</cfif> 
Comments='#Form.Comments#'

WHERE ExternalLocation='#URL.TP#'
</CFQUERY>

<cflocation url="reportcard.cfm?TP=#URL.TP#" addtoken="no">