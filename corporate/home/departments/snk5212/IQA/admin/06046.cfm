<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT * 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE employee_number='06046'
</CFQUERY>

<cfdump var="#QEmpLookup#">