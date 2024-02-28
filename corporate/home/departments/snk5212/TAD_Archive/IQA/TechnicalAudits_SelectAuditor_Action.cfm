<!--- select auditor info --->
<CFQUERY Name="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Location, Dept, Email
From Auditors
WHERE EmpNo = '#url.Auditor_EmpNo#'
</CFQUERY>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="Auditor">

<cfset HistoryUpdate = "
	Auditor Assigned<br />
	Auditor: #Auditor# / #Location# / #Dept#<Br />
	Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
	Date: #curdate# #curTime#">

    <!--- insert auditor into audit schedule table --->
    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    Auditor = '#Auditor#',
    AuditorOfficeName = '#Location#',
    AuditorDept = '#Dept#',
    AuditorEmail = '#Email#',
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

    WHERE 
    ID = #URL.ID# 
    AND Year_ = #URL.Year#
    </cfquery>
</cfoutput>

<cflocation url="#IQADir#TechnicalAudits_SelectAuditor.cfm?#CGI.Query_String#" addtoken="no">