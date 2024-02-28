<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IDAdd">
UPDATE IQAOffices_Areas
SET

IQA = 1,
LTA = 0,
Lab= '#Form.Lab#'

WHERE ID = #URL.ID#
AND LABID = #URL.LabID#
</CFQUERY>

<cflocation url="labs.cfm?OfficeName=#URL.ID#" ADDTOKEN="No">