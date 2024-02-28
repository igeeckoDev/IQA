<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
UPDATE ExternalLocation
SET

Type='CAP-EA/AA'

WHERE ExternalLocation = 'ACS - Atlanta, Georgia'
</cfquery>