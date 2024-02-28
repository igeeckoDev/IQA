<!--- select auditor info --->
<CFQUERY Name="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Location, Dept, Email
From Auditors
WHERE EmpNo = '#url.Auditor_EmpNo#'
</CFQUERY>

<cfoutput query="Auditor">
<b>Assigned Auditor</b><br>
#Auditor#<br>
#Location#<br>
#Dept#
</cfoutput><br><br>

<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT * 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    <cfif isDefined("url.Auditor_EmpNo") and NOT isDefined("url.Person_ID")>
        WHERE employee_number = '#url.Auditor_EmpNo#'
    <cfelseif isDefined("url.Person_ID")>
        WHERE Person_ID = '#url.Person_ID#'
    </cfif>
</CFQUERY>

<b>Select Auditor's Manager</b><br /><br>
<Cfoutput query="qEmpLookup">
<u>Supervisor</u>:<br>
Name: #Supervisor_Name# <a href="#IQADir#TechnicalAudits_SelectAuditor_Manager_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#&Auditor_EmpNo=#URL.Auditor_EmpNo#">
[Select as Auditor's Manager]</a><Br>
Email: #Supervisor_Email#<Br>
Title: #Supervisor_Title#<br><br />

:: <a href="#CGI.SCRIPT_NAME#?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#&Auditor_EmpNo=#URL.Auditor_EmpNo#">
View Supervisor Information
</a><Br>
</Cfoutput>