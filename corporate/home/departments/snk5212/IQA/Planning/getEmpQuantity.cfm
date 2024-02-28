<cfsetting requestTimeOut="300">

<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT Location_Code, COUNT(*) as Count, Organization, Last_Name, First_N_Middle, Department_Number
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
WHERE Last_Name = 'Swift'
GROUP BY Location_Code, Organization, Last_Name, First_N_Middle, Department_Number
ORDER BY Count DESC
</CFQUERY>

<!---
Fields:
DEPARTMENT_NAME DEPARTMENT_NUMBER EFFECTIVE_PAYROLL_DATE EMPLOYEE_CATEGORY EMPLOYEE_EMAIL EMPLOYEE_NUMBER EMPLOYEE_TITLE
EMPLOYEE_TYPE FIRST_N_MIDDLE HIRE_DATE INSPECTION_CENTER LAST_NAME LOCATION LOCATION_CODE LOCATION_ID NORMAL_HOURS
ORGANIZATION PAYROLL_NAME PCS_DEPARTMENT_NAME PERSON_ID PREFERRED_NAME SUPERVISOR_EMAIL SUPERVISOR_EMPLOYEE_NUMBER
SUPERVISOR_NAME SUPERVISOR_PERSON_ID SUPERVISOR_TITLE WORK_COUNTRY WORK_PHONE
--->

<Table border=1>
<tr>
	<th>Location</th>
	<th>Employee Count</th>
	<th>Organization</th>
	<th>First</th>
	<th>Last</th>
	<th>Department_Number</th>
</tr>
<cfoutput query="QEmpLookup">
<tr>
	<td>#Location_Code#</td>
	<td>#Count#</td>
	<td>#Organization#</td>
	<td>#First_N_Middle#</td>
	<td>#Last_Name#</td>
	<td>#Department_Number#</td>
</tr>
</cfoutput>
</table>

<!---
<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT Department_Number, COUNT(*) as Count, Organization
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
WHERE Location_Code = 'Home'
GROUP BY Department_Number, Organization
ORDER BY Count DESC
</CFQUERY>

<cfdump var="#QEmpLookup#">
--->