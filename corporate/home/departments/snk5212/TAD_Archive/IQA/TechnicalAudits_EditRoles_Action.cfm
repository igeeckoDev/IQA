<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

#Form.Role# = '#Evaluate("Form.#Form.Role#")#',
#Form.Role#Dept = '#Evaluate("Form.#Form.Role#Dept")#',
#Form.Role#OfficeName = '#Evaluate("Form.#Form.Role#OfficeName")#',

History='#History.History#<br /><br />
Audit Details Edited<br />
#Form.Role#: #Evaluate("Form.#Form.Role#")#<Br />
#Form.Role#Dept: #Evaluate("Form.#Form.Role#Dept")#<Br />
#Form.Role#OfficeName: #Evaluate("Form.#Form.Role#OfficeName")#<br />
Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
Date: #curdate# #curTime#'

WHERE ID = #URL.ID# 
AND Year_ = '#URL.Year#'
</CFQUERY>

<cflocation url="TechnicalAudits_EditRoles.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#Form.Role# added" addtoken="no">