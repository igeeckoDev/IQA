<CFQUERY BLOCKFACTOR="100" name="Users" Datasource="UL06046">
SELECT 
	SentTo
FROM 
	AuditSurvey_Users
WHERE
	AuditID = 67
    AND AuditYear = 2014
ORDER BY 
	ID
</CFQUERY>

<cfset SurveyUsers = valueList(Users.SentTo, ",")>

<cfdump var="#SurveyUsers#"><br><br>

<cfset Referred = findnocase("david.g.pedersen@ul.com", SurveyUsers)>

<cfdump var="#Referred#">