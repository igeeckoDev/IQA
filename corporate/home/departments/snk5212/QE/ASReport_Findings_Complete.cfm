<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" NAME="Reports" DataSource="Corporate">
	UPDATE AuditSchedule
	SET
	GCAR = 1,
	GCARConfirmDate = '#curdate#'

	WHERE
	Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER"> AND
	ID = #url.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="SearchResults" DataSource="Corporate">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT YEAR_ as "Year", ID, StartDate, OfficeName, audittype, auditedby, audittype2
 FROM AuditSchedule
 WHERE Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">  AND
	ID = #url.ID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<cfmail TO="Bill.Konigsfeld@ul.com"
		FROM="Raye.Silva@ul.com"
		CC="Cheryl.Adams@ul.com"
		BCC="Christohper.J.Nicastro@ul.com"
		Subject="Findings/Observations Entered into GCAR for #url.year#-#url.id#"
		Query="SearchResults"
		type="HTML">
Findings and/or Observations have been entered for <cfif auditedby is "AS">AS-#year#-#id#<cfelse>#year#-#id#-#auditedby#</cfif><br><br>

Audit Details:<br>
<cfif auditedby is "AS">AS-#year#-#id#<cfelse>#year#-#id#-#auditedby#</cfif><br>
Accreditor: #AuditType#<br>
Audit Start Date: #dateformat(StartDate, "mm/dd/yyyy")#<br>
Location of Audit: #OfficeName#<br><br>
</cfmail>

<cflocation url="ASReports_Details.cfm?#CGI.Query_String#" addtoken="No">