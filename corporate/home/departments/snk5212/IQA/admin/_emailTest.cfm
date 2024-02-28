<cfsetting requestTimeOut="600">

<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT COUNT(employee_email) as Count
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_email LIKE '%@ul.com'
</CFQUERY>

<cfoutput query="NameLookup">
@ul.com - #Count#<Br />
</cfoutput>

<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT COUNT(employee_email) as Count
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_email LIKE '%@__.ul.com'
</CFQUERY>

<cfoutput query="NameLookup">
@<b>xx</b>.ul.com - #Count#<Br />
</cfoutput>

<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT employee_email
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_email LIKE '%@__.ul.com'
</CFQUERY>

<cfoutput query="NameLookup">
#employee_email#<Br />
</cfoutput>