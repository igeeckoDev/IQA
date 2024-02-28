<CFQUERY BLOCKFACTOR="100" NAME="Files" DataSource="Corporate">
SELECT * FROM CARAdminFiles
WHERE CARAdminID = #URL.CARAdminID#
AND ID = #URL.ID#
</cfquery>

<cfquery name="deleteCARAdmin" datasource="Corporate" blockfactor="100"> 
UPDATE CARAdminFiles
SET
Remove = 'Yes'

WHERE ID = #URL.ID#
</cfquery>

<cflocation url="CARAdminView.cfm?ID=#URL.CARAdminID#&msg=File Removed&msg2=#Files.FileName#" addtoken="No">