<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
SELECT *
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_email = 'Christopher.J.Nicastro@ul.com'
</CFQUERY>

<cfdump var="#NameLookup#">