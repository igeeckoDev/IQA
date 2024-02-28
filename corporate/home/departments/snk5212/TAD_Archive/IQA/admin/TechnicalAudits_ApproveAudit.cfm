<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditDueDate, History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = "Audit Approved for Audit Schedule: #dateformat(curdate, "mm/dd/yyyy")#<br />
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#'">

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	TechnicalAudits_AuditSchedule
SET
	Approved = 'Yes',
	ApprovedDate = #CreateODBCDate(curdate)#, 
    Flag_CurrentStep = 'Audit Details Completed',  
	History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">   

WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">