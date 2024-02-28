<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Assign Auditor's Manager">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- select auditor info --->
<CFQUERY Name="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Location, Dept, Email
From Auditors
WHERE Email = '#url.AuditorEmail#'
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
WHERE employee_email = '#url.AuditorEmail#'
</CFQUERY>

<b>Select Auditor's Manager</b><br /><br>
<Cfoutput query="qEmpLookup">
<u>Supervisor</u>:<br>
Name: #Supervisor_Name# <a href="TechnicalAudits_SelectAuditor_Manager_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#&Auditor_EmpNo=#employee_number#">
[Select as Auditor's Manager]</a><Br>
Email: #Supervisor_Email#<Br>
Title: #Supervisor_Title#<br><br />

:: <a href="#CGI.SCRIPT_NAME#?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#&Auditor_EmpNo=#employee_number#">
View Supervisor Information
</a><Br>

</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->