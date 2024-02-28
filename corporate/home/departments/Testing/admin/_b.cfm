<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBEmailList"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE status IS NULL
AND (AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin')
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com')
ORDER BY Email

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CAR"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * FROM  IQADB_LOGIN  "LOGIN" WHERE status IS NULL
AND (EMAIL IS NOT NULL
AND EMAIL <> 'Internal.Quality_Audits@ul.com')
ORDER BY Email

<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfset Emails = #valueList(KBEmailList.Email, ',')#>
<cfset Emails2 = #valueList(CAR.Email, ',')#>
<cfset Emails3 = "Michelle.S.Lee@ul.com, Tony.Hsu@ul.com">

<cfoutput>#emails#, #emails2#, #emails3#</cfoutput>