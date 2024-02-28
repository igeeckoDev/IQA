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

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="qEmpLookup">
    <!--- insert auditor into audit schedule table --->
    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    EngManager = '#first_n_middle# #last_name#',
    EngManagerEmail = '#Email#',
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br>
        Engineering Manager Assigned<br />
        Engineering Manager: #first_n_middle# #last_name#<Br />
        Action by: [Regional Operations Manager]<br />
        Date: #curdate# #curTime#" CFSQLTYPE="CF_SQL_CLOB">
    
    WHERE 
    ID = #URL.ID# 
    AND Year_ = #URL.Year#
    </cfquery>
</cfoutput>

<cflocation url="TechnicalAudits_SelectAuditor_Director.cfm?ID=#URL.ID#&Year=#URL.Year#&EngManager_EmpNo=#URL.Person_ID#" addtoken="no">