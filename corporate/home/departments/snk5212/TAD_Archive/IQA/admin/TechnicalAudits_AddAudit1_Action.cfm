<!--- check for SQM for form.e_OfficeName --->
<cfquery Datasource="UL06046" name="getROM" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
SELECT 
	Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM, Corporate.IQAtblOffices.ID
FROM 
	Corporate.IQAtblOffices
WHERE 
	Corporate.IQAtblOffices.OfficeName = '#Form.e_OfficeName#'
</CFQUERY>

<!--- add info --->
<CFQUERY Name="xGUID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(xGUID)+1 as max 
FROM TechnicalAudits_AuditSchedule
</CFQUERY>

<CFQUERY Name="ID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_AuditSchedule
WHERE Year_ = '#Form.E_Year#'
</CFQUERY>

<cfif NOT len(ID.MaxID)>
	<cfset ID.maxID = 1000>
</cfif>

<CFQUERY Name="InsertRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO TechnicalAudits_AuditSchedule(xGUID, ID, Year_, AuditedBy)
VALUES(#xGUID.max#, #ID.MaxID#, '#Form.E_Year#', '#Form.AuditedBy#')
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="getRegion" Datasource="Corporate">
SELECT Region, SubRegion
FROM IQAtblOffices
WHERE OfficeName = '#FORM.e_OfficeName#'
</cfquery>

<CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

<!---
<cfif Form.AuditType2 eq "Full" AND Form.Waived eq "Yes">
ProjectPR = 'Waived',
ProjectPRDept = 'N/A',
ProjectPROfficeName = 'N/A',
</cfif>
--->

Flag_CurrentStep = 'Audit Details (1) Entered',
AuditType = '#Form.AuditType#',
E2E = '#Form.e_E2E#',

<!---
<cfif len(Form.AuditDueDate)>
	AuditDueDate = #CreateODBCDate(Form.AuditDueDate)#,
</cfif>
--->

ROM = '#Form.e_ROM#',
<cfif Form.e_TAM neq "None">
TAM = '#Form.e_TAM#',
</cfif>
Industry = '#Form.E_Industry#',
Month = #Form.E_Month#,
OfficeName = '#Form.E_OfficeName#',
SNAP = '#Form.e_SNAP#',
Region = '#getRegion.Region#',
SubRegion = '#getRegion.SubRegion#',
AuditType2 = '#Form.AuditType2#',
<cfif Form.AuditType2 eq "In-Process">
AuditPhase = '#Form.e_AuditPhase#',
</cfif>

History = 'Audit Added: #Form.e_Year#-#ID.MaxID#<Br />
<cfif Form.AuditType2 eq "Full">
	Quarter: Q#Form.E_Month#<br />
<cfelseif Form.AuditType2 eq "In-Process">
	Month: #MonthAsString(Form.E_Month)#<br />
</cfif>
Industry: #Form.E_Industry#<br />
OfficeName: #Form.E_OfficeName#<br />
SNAP: #Form.e_SNAP#<br />
AuditType2: #Form.AuditType2#<br />
<cfif Form.AuditType2 eq "In-Process">
AuditPhase: #Form.e_AuditPhase#<br />
</cfif>
Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
Date: #curdate# #curTime#'

WHERE ID = #ID.MaxID# 
AND Year_ = '#Form.E_Year#'
</CFQUERY>

<cfif NOT len(getROM.SQM)>
	<cflocation url="TechnicalAudits_SQM_Edit.cfm?OfficeID=#getROM.ID#&msg=Please add the SQM for <u>#Form.e_Officename#</u>. Audit Details (1) has been saved as <b>#Form.e_Year#-#ID.MaxID#</b>. You can retrieve this audit to finish adding the Audit Details by going to the Audit Views page." addtoken="no">
<cfelse>
	<cflocation url="TechnicalAudits_AddAudit2.cfm?ID=#ID.MaxID#&Year=#Form.E_Year#" addtoken="no">
</cfif>