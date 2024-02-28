<cfquery name="deleteCARAdmin" datasource="Corporate" blockfactor="100"> 
DELETE FROM CARAdminList
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="CARAdminList.cfm" addtoken="No">