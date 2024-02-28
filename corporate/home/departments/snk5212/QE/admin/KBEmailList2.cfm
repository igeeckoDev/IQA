<!---
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList">
SELECT * FROM IQADB_Login
WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin')
AND (EMAIL IS NOT NULL AND EMAIL <> 'Internal.Quality.Audits@ul.com')
ORDER BY Email
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CAR">
SELECT * FROM CAR_Login
WHERE status IS NULL
AND (EMAIL IS NOT NULL AND EMAIL <> 'All' AND EMAIL <> 'Internal.Quality.Audits@ul.com' AND EMAIL <> 'Christopher.J.Nicastro@ul.com')
ORDER BY Email
</CFQUERY>

<cfset Emails = #valueList(KBEmailList.Email, ',')#>
<cfset Emails2 = #valueList(CAR.Email, ',')#>
<cfset Emails3 = "Michelle.S.Lee@ul.com, Tony.Hsu@ul.com, Lenore.J.Berman@ul.com">

<cfoutput>
#Emails#, #Emails2#, #Emails3#
</cfoutput>
--->

<cfmail 
	to="Phillip.Alexandrin@ul.com"
    from="CAR.Process.WebSite@ul.com"
    replyto="Internal.Quality_Audits@ul.com"
    bcc=""
    cc=""
    mailerid=""
    subject="Testing Email"
    failto="Christopher.J.Nicastro@ul.com"
    type="HTML">
Testing Email with FailTo attribute.<br /><br />
Test.
</cfmail>