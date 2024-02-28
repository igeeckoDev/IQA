<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = "Audit Details Added<br />
#Form.Role#: #Evaluate("Form.#Form.Role#")#<Br />
#Form.Role#Dept: #Evaluate("Form.#Form.Role#Dept")#<Br />
#Form.Role#Office: #Evaluate("Form.#Form.Role#Office")#<br />
#Form.Role#Email: #Evaluate("Form.#Form.Role#Email")#<br />
Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
Date: #curdate# #curTime#'">

<CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

#Form.Role# = '#Evaluate("Form.#Form.Role#")#',
#Form.Role#Dept = '#Evaluate("Form.#Form.Role#Dept")#',
#Form.Role#Office = '#Evaluate("Form.#Form.Role#Office")#',
#Form.Role#Email = '#Evaluate("Form.#Form.Role#Email")#',

History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE ID = #URL.ID# 
AND Year_ = '#URL.Year#'
</CFQUERY>

<cflocation url="TechnicalAudits_AddAudit2.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#Form.Role# added" addtoken="no">