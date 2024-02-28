<!--- select Engineering Manager's info --->
<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT first_n_middle, 
	last_name, 
    employee_email as Email, 
    employee_number, 
    Location_Code as Location, 
    Department_Number as Department
    
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 

WHERE Person_ID = '#url.Person_ID#'
</CFQUERY>

<cfset Name = "#qEmpLookup.first_n_middle# #qEmpLookup.last_name#">

<CFQUERY Name="checkForUser" Datasource="Corporate">
SELECT *
From IQADB_Login
WHERE AccessLevel = 'Technical Audit'
AND Email = '#qEmpLookup.Email#'
</CFQUERY>

<cfif checkForUser.recordCount eq 0>
    <CFQUERY Name="ID" Datasource="Corporate">
    SELECT Max(ID)+1 as maxID
    FROM IQADB_Login
    </CFQUERY>
    
    <CFQUERY Name="InsertRow" Datasource="Corporate">
    INSERT INTO IQADB_Login(ID, Username, Name, Email, AccessLevel, Password)
    VALUES(#ID.maxID#, '#qEmpLookup.employee_number#', '#Name#', '#qEmpLookup.Email#', 'Technical Audit', 'temppwd')
    </CFQUERY>
    
    <cflocation url="TechnicalAudits_AccessControl.cfm?msg=#Name# added. Their username is their <b>employee number</b>, and their temporary password is <b>temppwd</b>." addtoken="no">
<cfelse>
	<cflocation url="TechnicalAudits_AccessControl.cfm?msg=#Name# already exists" addtoken="no">
</cfif>