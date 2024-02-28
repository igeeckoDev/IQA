<cfsetting requestTimeOut="600">

<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT count(*) as empCount, location_code
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
GROUP BY location_code
ORDER BY empCount DESC
</CFQUERY>

<cfdump var="#NameLookup#">