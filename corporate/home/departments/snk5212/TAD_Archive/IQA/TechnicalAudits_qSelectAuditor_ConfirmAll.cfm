<!--- Audit Details --->
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
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.4 Assigning an Auditor<br /><br />
</cfoutput>
</div>

<cfoutput>
<u>Available Actions</u><br />
:: <b><A href="#IQADir#TechnicalAudits_SelectAuditor_ConfirmAll_Action.cfm?#CGI.QUERY_STRING#">Confirm Selections</A></b><br />
:: The Roles below can be edited on the Audit Details page<br /><br />
</cfoutput>

<b>Audit Details</b><br />
<cfoutput query="Audit">
<u>Audit Number</u>: #URL.Year#-#URL.ID#-#AuditedBy#<br />
<u>Industry</u>: #Industry#<br />
<u>Office Name</u>: #OfficeName#<br />
<cfif len(SNAP)>SNAP Site Status: [#SNAP#]</cfif><Br />
<u>Regional Operations Manager</u>: #ROM#<br />
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
<u>Program</u>: #Program#<br />
<u>Engineering Manager</u>: #EngManager#<br />
<u>Enginering Director</u>: #EngManagerDirector#<br /><br />

<b>Assigned Auditor</b><br />
#Auditor#<br />
#AuditorDept#<Br />
#AuditorOfficeName#<br /><br />

<b>Auditor's Manager</b><br />
#AuditorManager#<br />
#AuditorManagerDept#<Br />
#AuditorManagerOfficeName#<br /><br />
</cfoutput>