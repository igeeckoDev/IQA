<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
SELECT * FROM Corporate.AuditSchedule
WHERE
Year_ = #URL.Year#
AND ID = 187
AND AuditedBy = 'IQA'
</cfquery>

<cfoutput>Audit Schedule: #getAuditsFromSchedule.recordCount#</cfoutput><br>

<!---
<CFQUERY BLOCKFACTOR="100" NAME="getAuditsFromPlanning" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM UL06046.AuditSchedule_Planning B

WHERE
Year_ = #URL.Year#
AND AuditedBy = 'IQA'
AND (Status IS NULL OR status = 'Deleted')
</CFQUERY>

<cfoutput>Audit Planning: #getAuditsFromPlanning.recordCount#</cfoutput><br>
<!--- /// --->
--->

<!---<cfif getAuditsFromPlanning.recordCount EQ 0>--->
	<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
	SELECT
	xGUID, ID, Year_, AuditedBy, Month, Approved, AuditType, AuditType2, Area,
	OfficeName, AuditArea, LeadAuditor, Auditor, AuditorInTraining,
	Email, Email2, BusinessUnit, Status, Desk

	FROM
	Corporate.AuditSchedule

	WHERE
	Year_ = #URL.Year#
	AND ID = 187
	AND AuditedBy = 'IQA'
	</CFQUERY>

	<cfoutput>Audit Schedule: #getAuditsFromSchedule.recordCount#</cfoutput><br>

	<cfoutput query="getAuditsFromSchedule">
		<CFQUERY BLOCKFACTOR="100" NAME="InsertAudits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO
		UL06046.AuditSchedule_Planning(
		xGUID, ID, Year_, AuditedBy, Month, Approved, AuditType, AuditType2, Area, OfficeName, AuditArea,
		LeadAuditor, Auditor, AuditorInTraining, Email, Email2, BusinessUnit, Status, Desk)

		VALUES(
		#xGUID#, #ID#, #Year_#, '#AuditedBy#', #Month#, '#Approved#', '#AuditType#', '#AuditType2#', '#Area#', '#OfficeName#', '#AuditArea#',
		'#LeadAuditor#', ('#Auditor#'), '#AuditorInTraining#', ('#Email#'), ('#Email2#'), ('#BusinessUnit#'), '#Status#', '#Desk#')
		</CFQUERY>
	</cfoutput>

	<CFQUERY BLOCKFACTOR="100" NAME="getAuditsFromPlanning" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *

	FROM
	UL06046.AuditSchedule_Planning

	WHERE
	Year_ = #URL.Year#
	AND ID = 187
	AND AuditedBy = 'IQA'
	</CFQUERY>

	<cfoutput>Audit Planning: #getAuditsFromPlanning.recordCount#</cfoutput><br><br>
<!---
<cfelse>
	Audits already exist in the Planning table for <cfoutput>#URL.Year#</cfoutput>.<br><br>
</cfif>
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->