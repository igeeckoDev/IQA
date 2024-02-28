<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT 
first_n_middle,last_name,employee_email,employee_title,employee_type,location_code,department_number,employee_category,preferred_name,department_name 

FROM 
ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 

WHERE 
last_name='#url.last_name#' 
</CFQUERY>

<cfoutput query="QEmpLookup">
#last_name# - #location_code#
</cfoutput>