<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT SRCARClosedDueDate
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<!--- add new row --->
<CFQUERY BLOCKFACTOR="100" NAME="checkMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_SRCAR
</CFQUERY>

<cfif NOT len(checkMaxID.MaxID)>
    <cfset checkMaxID.maxID = 1>
</cfif>

<cfif Form.SetDueDate eq "Yes">
	<cfif Form.IssueType eq "SR">
        <!--- 4 weeks / 28 days --->
        <Cfset DueDate = DateAdd('d', 28, curdate)>
    <cfelseif Form.IssueType eq "CAR">
        <!--- 12 weeks / 84  days --->
        <Cfset DueDate = DateAdd('d', 84, curdate)>
    </cfif>
</cfif>

<!--- add row --->
<CFQUERY NAME="AddRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO TechnicalAudits_SRCAR(ID, AuditYear, AuditID)
VALUES(#checkMaxID.maxID#, '#URL.Year#', '#URL.ID#')
</CFQUERY>

<!--- add details --->
<CFQUERY NAME="AddRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_SRCAR
SET

<cfif len(Form.SRCAR_AdditionalNumbers)>
	SRCAR_AdditionalNumbers = '#Form.SRCAR_AdditionalNumbers#',
</cfif>
SRCARNumber = '#Form.SRCARNumber#',
IssueType = '#Form.IssueType#',
<cfif Form.SetDueDate eq "Yes">
	SRCARClosedDueDate = #createODBCDate(DueDate)#,
</cfif>
SRCAREnteredDate = #createODBCDate(curdate)#

WHERE 
ID = #checkMaxID.maxID#
</cfquery>

<cfif Form.SetDueDate eq "Yes">
	<!--- add due date to auditschedule if it has not already been added --->
    <CFQUERY NAME="update" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    SRCARClosedDueDate = #createODBCDate(DueDate)#
    WHERE 
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
</cfif>

<!--- history update --->
<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<!--- indicate if issuetype or srcar_additionalnumbers fields were changed --->

<cfset HistoryUpdate = "
    #Form.IssueType# Number Entered<br>
    Due Date for Corrective Actions to be Closed: #dateformat(Audit.SRCARClosedDueDate, "mm/dd/yyyy")#<br>
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#">

<CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE
ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<cflocation url="#IQADir#TechnicalAudits_AddNC_SelectCategory.cfm?ID=#URL.ID#&Year=#URL.Year#&SRCARStatus=Completed" addtoken="no">