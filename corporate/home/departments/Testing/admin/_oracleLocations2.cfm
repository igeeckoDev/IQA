<cfsetting requestTimeOut="600">

<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT first_n_middle, last_name
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE location_code = 'US - Colorado Springs'
ORDER BY last_name
</CFQUERY>

<cfdump var="#NameLookup#">