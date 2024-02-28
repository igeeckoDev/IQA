<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History, Notes
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

Flag_CurrentStep = 'Audit Details (3) Entered',
CCN = UPPER('#Form.e_CCN#'),
<cfif len(Form.CCN2)>
CCN2 = UPPER('#Form.CCN2#'),
</cfif>
FileNumber = '#Form.FileNumber#',
Program = '#Form.e_Program#',
ProjectNumber = '#replace(Form.e_ProjectNumber, ".", "_", "All")#',
<cfif len(Form.ProjectLink)>
ProjectLink = '#Form.ProjectLink#',
</cfif>
RequestType = '#Form.e_RequestType#',
Standard = '#Form.Standard#',
<cfif len(Form.Standard2)>
Standard2 = '#Form.Standard2#',
</cfif>

<cfset newNotes = #replace(Form.Notes, "'", "!", "All")#>
Notes = <CFQUERYPARAM VALUE="#History.Notes#<br /><br>#newNotes#" CFSQLTYPE="CF_SQL_CLOB">,

<cfset HistoryUpdate =
	"Audit Details Added<br />
	Primary CCN: #UCASE(Form.e_CCN)#<br />
	<cfif len(Form.CCN2)>
	Other CCNs: #UCASE(Form.CCN2)#<br />
	</cfif>
	FileNumber: #Form.FileNumber#<br />
	Program: #Form.e_Program#<br />
	ProjectNumber: #Form.e_ProjectNumber#<br />
	<cfif len(Form.ProjectLink)>
	ProjectLink: #Form.ProjectLink#<br />
	</cfif>
	RequestType: #Form.e_RequestType#<br />
	Primary Standard: #Form.Standard#<br />
	<cfif len(Form.Standard2)>
	Other Standards: #Form.Standard2#<br />
	</cfif>
	Notes: #Form.Notes#<br />
	Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
	Date: #curdate# #curTime#">

History = <CFQUERYPARAM VALUE="#History.History#<br /><br>#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE ID = #URL.ID#
AND Year_ = '#URL.Year#'
</CFQUERY>

<cflocation url="TechnicalAudits_AddAudit4_Search.cfm?#CGI.QUERY_STRING#" addtoken="no">