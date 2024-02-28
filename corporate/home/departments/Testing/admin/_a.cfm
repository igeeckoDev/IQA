<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Email"> 
SELECT Email 
FROM IQADB_LOGIN 
WHERE status IS NULL 
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor') 
AND (EMAIL IS NOT NULL AND EMAIL <> 'Internal.Quality_Audits@ul.com') 
ORDER BY Email
</CFQUERY>

<cfoutput>#valuelist(Email.Email, ", ")#</cfoutput>