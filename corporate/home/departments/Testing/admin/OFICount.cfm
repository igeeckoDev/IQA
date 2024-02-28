<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View1">
SELECT Year_, ID, Summary
FROM Report
WHERE AuditedBy = 'IQA'
AND (Summary LIKE '%Opportunity for Improvement%' OR Summary LIKE '%OFI%' OR Summary LIKE '%Opportunities%' OR Summary LIKE '%opportunities%')
ORDER BY Year_, ID
</cfquery>

<cfoutput query="View1">
<B>#Year_#-#ID#</B><br>
#Summary#<br><Br>
</cfoutput>