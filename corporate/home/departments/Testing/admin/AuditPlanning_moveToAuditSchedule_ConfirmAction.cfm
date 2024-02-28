<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning Publish to Audit Schedule - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT xGUID, Year_, ID, AuditType2, OfficeName, Area, AuditArea, Month, Desk, SME, 
Status, CancelFile, BusinessUnit, AuditDays, LeadAuditor, Auditor, AuditorInTraining, NotesToLeadAuditor

FROM UL06046.AuditSchedule_Planning

WHERE Year_ = #URL.Year#
AND AuditedBY = 'IQA'

ORDER BY ID
</cfquery>

<cfoutput query="Audit">
<u>Planning</u><br>
xGUID = #xGUID#<br>
#Year_#-#ID#<br /><Br>

<cfquery name="check" datasource="Corporate">
SELECT xGUID FROM AuditSchedule
WHERE xGUID = #xGUID#
</cfquery>

	<cfquery name="AddNewToSched" datasource="Corporate">
	UPDATE AuditSchedule
	SET
	Approved = 'Yes',
	AuditType = 'Quality System',
	AuditType2 = '#AuditType2#',
	OfficeName = '#OfficeName#',
	Area = '#Area#',
	AuditArea = '#AuditArea#',
	Month = #Month#,
	Desk = '#Desk#',
	SME = '#SME#',
	<cfif status eq "deleted">
		Status = <cfif len(Status)>'#Status#'<cfelse>null</cfif>,
		FileCancel = '#CancelFile#',
		CancelRequest = 'Yes',
		CancelRequestDate = #createodbcdate(curdate)#,
		CancelNotes = 'Cancelled during 2016 Audit Planning, see attachment.',
	<cfelseif status eq "Removed">
		Status = 'Removed',
	</cfif>
	BusinessUnit = '#BusinessUnit#',
	AuditDays = '#AuditDays#',
	LeadAuditor = '#LeadAuditor#',
	Auditor = <cfif Auditor eq "- None -" OR NOT len(Auditor)>null<cfelse>'#Auditor#'</cfif>,
	AuditorInTraining = <cfif AuditorInTraining eq "- None -" OR NOT len(AuditorInTraining)>null<cfelse>'#AuditorInTraining#'</cfif>,
	NotesToLeadAuditor = '#NotesToLeadAuditor#',
	Scheduler = '<u>Username:</u> System (Superuser) - <cfoutput>#URL.Year#</cfoutput> Audit Planning Published to <cfoutput>#URL.Year#</cfoutput> Audit Schedule<br><u>Time:</u> #curdate#'

	WHERE xGUID = #xGUID#
	</cfquery>
	
<a href="AuditPlanning.cfm?Year=#URL.Year#">Go to Planning to continue</a>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->