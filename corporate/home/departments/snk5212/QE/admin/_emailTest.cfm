<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList">
SELECT * FROM IQADB_LOGIN "LOGIN" 
WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin' OR AccessLevel = 'IQAAuditor')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com'
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com')
ORDER BY Email
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CARAdminList">
SELECT * FROM CARAdminList
WHERE (Status = 'Active' OR Status = 'CAR Administration Support' OR Status = 'In Training')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com'
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com')
ORDER BY Email
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CAR">
SELECT * FROM  CAR_LOGIN "LOGIN" 
WHERE status IS NULL
AND (AccessLevel <> 'AS')
AND Status IS NULL
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality.Audits@ul.com'
AND EMAIL <> 'Internal.Quality.Audits@us.ul.com')
ORDER BY Email
</CFQUERY>
--->

<cfset Emails = #valueList(KBEmailList.Email, ',')#>
<!---<cfset Emails2 = #valueList(CAR.Email, ',')#>--->
<cfset Emails3 = #valueList(CARAdminList.Email, ',')#>
<cfset Emails4 = "Joe.Taylor@ul.com, Steven.T.Margis@ul.com, Walter.E.Ballek@ul.com, Rodney.E.Morton@ul.com, James.E.Feth@ul.com, William.R.Carney@ul.com, Michael.Jorgenson@ul.com, Lenore.J.Berman@ul.com, Michael.Chan@ul.com, Dale.C.Hendricks@ul.com">

<cfoutput>
IQA Login<br>
#replace(Emails, ",", "<br>", "All")#<br /><br>

CAR Admin<br>
#replace(Emails2, ",", "<br>", "All")#<br /><Br>

CAR Login<br>
#replace(Emails3, ",", "<br>", "All")#<br /><br>

Other<br>
#replace(Emails4, ",", "<br>", "All")#<br />
</cfoutput>