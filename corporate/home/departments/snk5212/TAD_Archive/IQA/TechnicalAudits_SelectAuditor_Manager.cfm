<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Assign Engineering Manager">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- select auditor info --->
<CFQUERY Name="Roles" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	Auditor, AuditorEmail, AuditorDept, AuditorOfficeName,
	AuditorManager, AuditorManagerEmail, AuditorManagerDept, AuditorManagerOfficeName
From 
	TechnicalAudits_AuditSchedule
WHERE 
	ID = #URL.ID# AND Year_ = #URL.Year#
</CFQUERY>

<cfoutput query="Roles">
<b>Assigned Auditor</b><br />
#Auditor#<br />
#AuditorDept#<Br />
#AuditorOfficeName#<br /><br />

<b>Auditor's Manager</b><br />
#AuditorManager#<br />
#AuditorManagerDept#<Br />
#AuditorManagerOfficeName#<br /><br />
</cfoutput>

<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT * 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    <cfif isDefined("url.Manager_EmpNo")>
        WHERE Person_ID = '#url.Manager_EmpNo#'
    <cfelseif isDefined("url.Person_ID")>
        WHERE Person_ID = '#url.Person_ID#'
    </cfif>
</CFQUERY>

<b>Select Engineering Manager</b><br />
<Cfoutput query="qEmpLookup">
<u>Employee</u>:<Br />
Name: #first_n_middle# #last_name#<Br /><br />

<u>Supervisor</u>:<br>
Name: #Supervisor_Name# <a href="TechnicalAudits_SelectAuditor_Director_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#">
[Select as Engineering Manager]</a> <A href="TechnicalAudits_SelectAuditor_Manager_newSearch.cfm?ID=#ID#&Year=#Year#">[Search for another employee]</A><Br>
Email: #Supervisor_Email#<Br>
Title: #Supervisor_Title#<br><br />

:: <a href="#CGI.SCRIPT_NAME#?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#&Auditor_EmpNo=#URL.Auditor_EmpNo#">
View Supervisor Information
</a><Br>

</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->