<cfsetting requesttimeout="600">

<CFQUERY NAME="Employee" datasource="OracleNet" blockfactor="100">
SELECT DISTINCT Department_Name
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
</CFQUERY>

<cfdump var="#Employee#">