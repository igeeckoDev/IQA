<CFQUERY Name="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History, AuditedBy
From TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<CFOUTPUT query="Audit">
<b>Audit Details Change History</b>
<br><br>

<u>Auditor Number</u>:<br>
#URL.Year#-#ID#-#AuditedBy# <a href="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#">[View Audit Details]</a>
<br><br>

<u>History</u> (Oldest to Newest)<br>
<cfif len(History)>
	#History#
<cfelse>
	No History
</cfif>
</CFOUTPUT>