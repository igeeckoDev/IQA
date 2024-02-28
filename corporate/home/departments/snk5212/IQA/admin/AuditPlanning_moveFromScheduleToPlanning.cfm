<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Move Schedule to Planning for #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
SELECT *
FROM Corporate.AuditSchedule
WHERE Year_ = #URL.Year# AND AuditedBy = 'IQA'
ORDER BY ID
</CFQUERY>

<cfoutput query="getAuditsFromSchedule">
	
	<CFQUERY BLOCKFACTOR="100" NAME="InsertAudits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO
	UL06046.AuditSchedule_Planning(
	xGUID, 
	ID, 
	Year_, 
	Approved, 
	AuditedBy, 
	Month, 
	AuditType, 
	AuditType2, 
	LeadAuditor, 
	Auditor, 
	OfficeName, 
	Area, 
	AuditArea, 
	Email, 
	Email2, 
	Desk, 
	<cfif auditdays NEQ "">AuditDays,</cfif>
	BusinessUnit, 
	SME, 
	Status, 
	InitialSiteAudit)
	
	VALUES(
	#xGUID#, 
	#ID#, 
	#Year_#, 
	'Yes', 
	'#AuditedBy#', 
	#Month#, 
	'#AuditType#', 
	'#AuditType2#', 
	'#LeadAuditor#', 
	('#Auditor#'), 
	'#OfficeName#', 
	'#Area#', 
	'#AuditArea#', 
	('#trim(Email)#'), 
	('#trim(Email2)#'), 
	'#Desk#', 
	<cfif auditdays NEQ "">#AuditDays#,</cfif>
	('#BusinessUnit#'), 
	('#SME#'), 
	'#Status#', 
	'#InitialSiteAudit#')
	</CFQUERY>
	
#xGUID# :: #Year_#-#ID#<br>
</cfoutput>

<a href="AuditPlanning.cfm?Year=#URL.Year#">Go to Planning to continue</a>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->