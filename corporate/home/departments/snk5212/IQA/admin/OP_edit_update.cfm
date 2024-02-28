<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Add"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 1eb34b78-8505-4fba-bb21-80e087a8c962 Variable Datasource name --->
UPDATE OtherPrograms
SET 
Program='#Form.OP#'
WHERE ID=#URL.ID#
<!---TODO_DV_CORP_002_End: 1eb34b78-8505-4fba-bb21-80e087a8c962 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cflocation url="OP.cfm" addtoken="no">