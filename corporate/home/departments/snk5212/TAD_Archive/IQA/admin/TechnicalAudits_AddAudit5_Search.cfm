<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Assign Engineering Director">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.YeaR#
</cfquery>

<div align="Left" class="blog-time">
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.2 Add an audit<br /><br />
</cfoutput>
</div>

<b>Audit Details</b><br />
<cfoutput query="Audit">
<u>Audit Number</u>: #URL.Year#-#URL.ID#-#AuditedBy#<br />
<u>Industry</u>: #Industry#<br />
<u>Office Name</u>: #OfficeName#<br />
<cfif len(SNAP)>SNAP Site Status: [#SNAP#]</cfif><Br />
<u>Regional Operations Manager</u>: #ROM#<br />
<cfif len(TAM)>
<u>Technical Audit Manager/Deputy</u>: #TAM#<br />
</cfif>
<u>Audit Type</u>: #AuditType2# <cfif AuditType2 eq "In-Process">(Phase: #AuditPhase#)</cfif><br />
<u>E2E Audit?</u>: <cfif NOT len(E2E)>Not Selected<cfelse>#E2E#</cfif><br />
<cfif AuditType2 eq "Full">
	<u>Quarter Scheduled</u>: Quarter #Month#
<cfelseif AuditType2 eq "In-Process">
	<u>Month Scheduled</u>: #MonthAsString(Month)#
</cfif><br />
<u>Audit Due Date</u>: <cfif len(AuditDueDate)>#dateformat(AuditDueDate, "mm/dd/yyyy")#<cfelse>None Specified</cfif><br />
<cfif AuditType2 eq "In-Process">
	<u>Project Handler</u>: #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept#<br />
	<u>Project Handler's Manager</u>: #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept#<br />
<cfelseif AuditType2 eq "Full">
	<u>Project Evaluator</u>: #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept#<br>
	<u>Project Evaluator's Manager</u>: #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept#<br>
	<u>Test Data Validator</u>: #TDV# / #TDVOffice# / #TDVDept#<br />
	<u>Test Data Validator's Manager</u>: #TDVManager# / #TDVManagerOffice# / #TDVManagerDept#<br />
</cfif>
<u>Project Number</u>: #ProjectNumber#<br />
<cfif len(FileNumber)>
	<u>File Number</u>: #FileNumber#<br />
</cfif>
<cfif len(Standard)>
	<u>Standard</u>: #Standard#<br />
</cfif>
<cfif len(Standard2)>
	<u>Other Standards</u>: #replace(Standard2, ",", "<br />", "All")#<br />
</cfif>
<u>CCN</u>: #CCN#<br />
<cfif len(CCN2)>
	<u>Other CCNs</u>: #replace(CCN2, ",", "<br />", "All")#<br />
</cfif>
<u>Program</u>: #Program#<br /><br />

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

<b>Select Engineering Director</b><br /><br />

<cfif Audit.AuditType2 eq "In-Process">
	In-Process: Manager of the Project Handler's Manager<br />
<cfelseif Audit.AuditType2 eq "Full">
	Full: Manager of the: Prime Revewier's Manager OR Test Data Validator's Manager<br /><br />
</cfif>

<Cfoutput query="qEmpLookup">
Name: #Supervisor_Name# <a href="TechnicalAudits_AddAudit5_Search_Action.cfm?ID=#ID#&Year=#Year#&Person_ID=#Supervisor_Person_ID#">
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