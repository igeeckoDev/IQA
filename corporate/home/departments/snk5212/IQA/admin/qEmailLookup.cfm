<CFQUERY NAME="qEmailLookup" datasource="OracleNet" >
select employee_email 
from ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
where last_name = '#form.name#'
</CFQUERY>

<cfoutput query="qEmailLookup">
#employee_email#
</cfoutput>