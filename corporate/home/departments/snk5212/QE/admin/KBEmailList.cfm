<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBEmailList"> 
SELECT * FROM IQADB_Login
WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
AND (EMAIL IS NOT NULL AND EMAIL <> 'Internal.Quality_Audits@ul.com')

UNION

SELECT * FROM CAR_Login
WHERE status IS NULL
AND (EMAIL IS NOT NULL AND EMAIL <> 'All' AND EMAIL <> 'Internal_Quality.Audits@ul.com')

ORDER BY Email
</CFQUERY>

<cfset Emails = #valueList(KBEmailList.Email, ',')#>

<cfset Emails = #valueList(KBEmailList.Email, ',')#>
<cfset Emails2 = "Michelle.S.Lee@ul.com, Tony.Hsu@ul.com, Lenore.J.Berman@ul.com">