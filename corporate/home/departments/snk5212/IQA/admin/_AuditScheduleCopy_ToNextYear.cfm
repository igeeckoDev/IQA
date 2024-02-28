<cfset nextYear = url.year + 1>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Copy Audit Schdedule from #URL.Year# to #nextYear#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="maxGUID" datasource="Corporate">
SELECT MAX(xGUID)+1 as maxGUID FROM AuditSchedule
</cfquery>

<cfquery name="maxID" datasource="Corporate">
SELECT MAX(ID)+1 as maxID FROM AuditSchedule
WHERE Year_ = #nextYear#
</cfquery>

<cfif NOT len(maxID.maxID)>
	<cfset maxID.maxID = 1>
</cfif>

<cfquery name="Audit" datasource="Corporate">
SELECT
xGUID, ID, Year_, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, AuditorInTraining, OfficeName, Area, AuditArea, Month, Scope, Email, Email2, Desk, AuditDays, BusinessUnit, Status

FROM
AuditSchedule

WHERE
Year_ = #URL.Year#
AND AuditedBy = 'IQA'
AND Status IS NULL

ORDER BY ID
</cfquery>

<cfset i = maxID.maxID>
<cfset j = maxGUID.maxGUID>

<cfoutput query="Audit">
#Year_#-#ID#-#AuditedBy#<br />

<cfquery name="AddNewToSched" datasource="Corporate">
INSERT INTO AuditSchedule(xGUID, ID, Year_, Approved, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Email, Email2, Desk, AuditDays, BusinessUnit, lastYear, Status)
VALUES(#j#, #i#, #nextYear#, 'Yes', 'IQA', '#AuditType#', '#AuditType2#', '#LeadAuditor#', '#Auditor#', '#OfficeName#', '#Area#', '#AuditArea#', #Month#, '#Email#', '#Email2#', '#Desk#', #AuditDays#, '#BusinessUnit#', #xGUID#, '#Status#')
</cfquery>

Added: #nextYear#-#i#-#AuditedBy# (#j#)<br />
<a href="auditdetails.cfm?ID=#i#&Year=#nextYear#">View Audit</a><br>

<cfset i = i + 1>
<cfset j = j + 1>
</cfoutput>

<cfoutput>
	<a href="AuditPlanning.cfm?Year=#URL.Year#">Go to Planning to continue</a>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->