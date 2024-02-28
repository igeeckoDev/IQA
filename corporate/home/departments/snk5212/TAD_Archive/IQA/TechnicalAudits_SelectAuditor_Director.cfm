<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Assign Engineering Director">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- select auditor info --->
<CFQUERY Name="Roles" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	Auditor, AuditorEmail, AuditorDept, AuditorOfficeName,
	AuditorManager, AuditorManagerEmail, AuditorManagerDept, AuditorManagerOfficeName,
    EngManager, EngManagerEmail
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

<b>Engineering Manager</b><br />
#EngManager#<br />
#EngManagerEmail#<Br /><br />
</cfoutput>

<CFQUERY NAME="qEmpLookup" datasource="OracleNet">
SELECT * 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    <cfif isDefined("url.EngManager_EmpNo")>
        WHERE Person_ID = '#url.EngManager_EmpNo#'
    <cfelseif isDefined("url.Person_ID")>
        WHERE Person_ID = '#url.Person_ID#'
    </cfif>
</CFQUERY>

<b>Select Engineering Director</b><br />
<Cfoutput query="qEmpLookup">
Name: #Supervisor_Name# <a href="TechnicalAudits_SelectAuditor_Director_Final_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#">
[Select as Engineering Director]</a><Br>
Email: #Supervisor_Email#<Br>
Title: #Supervisor_Title#<br><br />

:: <a href="#CGI.SCRIPT_NAME#?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#">
View Supervisor Information
</a><Br>

</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->