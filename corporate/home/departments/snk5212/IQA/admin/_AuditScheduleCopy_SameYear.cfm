<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Copy Audit (same year copy)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="maxGUID" datasource="Corporate">
SELECT MAX(xGUID)+1 as maxGUID FROM AuditSchedule
</cfquery>

<cfquery name="maxID" datasource="Corporate">
SELECT MAX(ID)+1 as maxID FROM AuditSchedule
WHERE Year_ = #URL.Year#
</cfquery>

<cfif NOT len(maxID.maxID)>
	<cfset maxID.maxID = 1>
</cfif>

<cfquery name="Audit" datasource="Corporate">
SELECT
ID, Year_, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, AuditorInTraining, OfficeName, Area, AuditArea, Month, Email, Email2, Desk

FROM
AuditSchedule

WHERE
Year_ = #URL.Year#
AND ID = #URL.ID#
</cfquery>

<cfoutput query="Audit">
#Year_#-#ID#<br />

<cfquery name="AddNewToSched" datasource="Corporate">
INSERT INTO AuditSchedule (xGUID, ID, Year_, Approved, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, AuditorInTraining, OfficeName, Area,
AuditArea, Month, Email, Email2, Desk)

VALUES(#maxGUID.maxGUID#, #maxID.maxID#, #URL.Year#, 'Yes', '#AuditedBy#', '#AuditType#', '#AuditType2#', '#LeadAuditor#', '#Auditor#', '#AuditorInTraining#',
'#OfficeName#', '#Area#', '#AuditArea#', #Month#, '#Email#', '#Email2#', '#Desk#')
</cfquery>

Added: #URL.Year#-#maxID.maxID#-#AuditedBy# (#maxGUID.maxGUID#)<br />
<a href="auditdetails.cfm?ID=#maxID.maxID#&Year=#URL.Year#">View Audit</a><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->