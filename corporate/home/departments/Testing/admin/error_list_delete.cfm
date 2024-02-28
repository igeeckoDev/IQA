<CFQUERY BLOCKFACTOR="100" NAME="output" DataSource="Corporate">
DELETE FROM ERROR_IQA
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="error_list.cfm" ADDTOKEN="No">