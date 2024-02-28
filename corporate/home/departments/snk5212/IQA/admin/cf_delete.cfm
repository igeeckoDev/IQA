<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
UPDATE CorporateFunctions
SET

<cfif URL.Action is "Remove">
	STATUS = 'Removed'
<cfelseif URL.Action is "Reinstate">
	STATUS = NULL
</cfif>

WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="cf.cfm" ADDTOKEN="No">