<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
DELETE FROM IQAPAGEVIEWS
WHERE
BROWSER = 'OpenTextSiteCrawler/2.9.9 Solaris 10'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
DELETE FROM IQAPAGEVIEWS
WHERE
BROWSER = 'gsa-crawler (Enterprise; MID-00114; Steven.M.Downs@ul.com)'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
SELECT COUNT(ID) as Count FROM IQAPAGEVIEWS
</CFQUERY>

<cfoutput>
Records - #Edit.Count#
</cfoutput>