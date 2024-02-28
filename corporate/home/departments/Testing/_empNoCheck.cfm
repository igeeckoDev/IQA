<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT employee_email, employee_number
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
WHERE employee_number LIKE '4%'
ORDER BY employee_number
</CFQUERY>

<cfdump var="#qEmpLookup#">