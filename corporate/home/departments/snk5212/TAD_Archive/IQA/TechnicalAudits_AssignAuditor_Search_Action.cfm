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
    Auditor = '#first_n_middle# #last_name#',
    AuditorEmail = '#Email#',
    AuditorDept = '#Department#',
    AuditorOfficeName = '#Location#',
   
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br>Auditor Assigned<br />
    Auditor: #first_n_middle# #last_name# / #Location# / #Department#<Br />
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#" CFSQLTYPE="CF_SQL_CLOB">
    
    WHERE 
    ID = #URL.ID# 
    AND Year_ = #URL.Year#
    </cfquery>
</cfoutput>

<cflocation url="TechnicalAudits_AssignAuditor_Manager.cfm?#CGI.Query_String#" addtoken="no">