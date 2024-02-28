<cfsetting requesttimeout="3600"> 

<CFQUERY NAME="NameLookup" datasource="OracleNet">
SELECT 
	first_n_middle, 
    last_name,
    employee_title, 
    employee_number,
    location_code, 
    location_ID,
    location,
    department_number,  
    department_name,
    Organization,
    PCS_Department_Name, 
    Work_Country
    
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
</CFQUERY>

<cfdump var="#NameLookup#">