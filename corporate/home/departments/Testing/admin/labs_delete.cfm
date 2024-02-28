<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
DELETE FROM IQAOffices_Areas
WHERE ID = #URL.ID# AND LabID = #URL.LabID#
</CFQUERY>

<cflocation url="labs.cfm?OfficeName=#URL.ID#" ADDTOKEN="No">