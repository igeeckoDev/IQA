<!---
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList">
SELECT * FROM IQADB_LOGIN "LOGIN" 
WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality.Audits@ul.com')
ORDER BY Email
</CFQUERY>
--->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CARAdminList">
SELECT Email FROM CARAdminList
WHERE Status = 'Active' 
OR Status = 'CAR Administration Support' 
OR Status = 'In Training'
ORDER BY Email
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CAR">
SELECT Email FROM CAR_LOGIN
WHERE status IS NULL
AND (AccessLevel <> 'AS')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com')
ORDER BY Email
</CFQUERY>

<!---
<cfset Emails = #valueList(KBEmailList.Email, ',')#>
--->
<cfset Emails2 = #valueList(CAR.Email, ',')#>
<cfset Emails3 = #valueList(CARAdminList.Email, ';')#>

<cfoutput>#Emails3#</cfoutput>