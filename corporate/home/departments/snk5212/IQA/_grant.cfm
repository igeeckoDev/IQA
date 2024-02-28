<cfsetting requesttimeout="600">

<cfset var=ArrayNew(1)>

<CFSET var[1] = 'FLASHBACK'>
<CFSET var[2] = 'DEBUG'>
<CFSET var[3] = 'QUERY REWRITE'>
<CFSET var[4] = 'ON COMMIT REFRESH'>
<CFSET var[5] = 'PREFERENCES'>
<CFSET var[6] = 'UPDATE'>
<CFSET var[7] = 'SELECT'>
<CFSET var[8] = 'INSERT'>
<CFSET var[9] = 'INDEX'>
<CFSET var[10] = 'DELETE'>
<CFSET var[11] = 'ALTER'>

<cfloop index="i" from="1" to="11">
<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT *
FROM SYS.USER_TAB_PRIVS
WHERE grantee = 'UL06046'
AND Privilege = '#var[i]#'
</CFQUERY>

<cfoutput>
#var[i]# <br />
#output.recordcount#<br />
</cfoutput>
</cfloop>

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT Table_Name
FROM SYS.USER_TAB_PRIVS
WHERE grantee = 'UL06046'
GROUP BY Table_Name
</CFQUERY>

<cfdump var="#output#">