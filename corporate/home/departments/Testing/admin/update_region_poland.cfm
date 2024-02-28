<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
UPDATE tblOffices
SET
Region = 'Northern EU'
WHERE ID = 64
</CFQUERY>

<CFOUTPUT>Done!!11!!<br>#OfficeName# - #Region#</CFOUTPUT>