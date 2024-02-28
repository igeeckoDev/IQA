<CFQUERY BLOCKFACTOR="100" Name="DocsOutput2" Datasource="Corporate">
SELECT * FROM Policy
WHERE Policy = 'Standard Operating Procedures'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Name="DocsOutput3" Datasource="Corporate">
SELECT * FROM Policy
WHERE Policy = 'Processes'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Name="DocsOutput4" Datasource="Corporate">
SELECT * FROM Policy
Where Policy = 'Work Instructions'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Name="DocsOutput5" Datasource="Corporate">
SELECT * FROM Policy
WHERE Policy = 'Forms'
ORDER BY ID
</CFQUERY>