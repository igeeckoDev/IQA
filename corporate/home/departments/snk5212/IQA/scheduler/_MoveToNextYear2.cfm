<cfset CopyFromYear = #url.year# - 1>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AuditList">
SELECT xGUID, Year_, ID, Area, AuditArea, AuditType2, Status, Month
FROM AuditSchedule
WHERE
Year_ = #CopyFromYear#
AND OfficeName = 'Orange County Lighting Performance Lab'
ORDER BY xGUID
</cfquery>

<cfset auditNotFoundList = "">

<cfoutput query="AuditList">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RelatedAudit">
	SELECT Year_, ID, Area, AuditArea, AuditType2, Status, xGUID, Month
	FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND lastYear = #xGUID#
	</cfquery>

	<cfif RelatedAudit.RecordCount GT 0>
	<!---
	#RelatedAudit.Year_#-#RelatedAudit.ID#<br>
	#MonthAsString(RelatedAudit.Month)#<br>
	#RelatedAudit.Area# / #RelatedAudit.AuditType2#
	--->
	<cfelse>
		<!---#xGUID# #Year_#-#ID# / #MonthAsString(Month)# / #Area# / #AuditType2#<br>--->
		<cfset auditNotFoundList = ListAppend(auditNotFoundList, "#xGUID#")>
	</cfif>
</cfoutput>

<cfquery name="maxGUID" datasource="Corporate">
SELECT MAX(xGUID)+1 as maxGUID FROM AuditSchedule
</cfquery>

<cfset x = maxGUID.maxGUID>

<cfquery name="maxID" datasource="Corporate">
SELECT MAX(ID)+1 as maxID FROM AuditSchedule
WHERE Year_ = #URL.Year#
</cfquery>

<cfif NOT len(maxID.maxID)>
    <cfset maxID.maxID = 1>
</cfif>

<cfset y = maxID.maxID>

<cfset j = 0>

<cfloop index = "ListElement" list = "#auditNotFoundList#">
	<cfset j = j+1>

	<cfquery name="AuditDetails" datasource="Corporate">
	SELECT
	xGUID, ID, Year_, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Email, Email2, Desk, BusinessUnit, report, status, AuditDays

	FROM
	AuditSchedule

	WHERE
	xGUID = #listElement#
	</cfquery>

	<cfoutput query="AuditDetails">
	#xGUID# #Year_#-#ID# (#monthasstring(Month)#) #OfficeName# #AuditType2# #Area# #AuditArea# #Report# <b>#status#</b><br>

	<cfif AuditType2 is "MMS - Medical Management Systems">
	    <cfset ScopeStatement = "#Request.MMSScope#">
	<cfelse>
	    <cfset ScopeStatement = "#Request.IQAScope2016#">
	</cfif>

	<cfquery name="AddNewToSched" datasource="Corporate">
	INSERT INTO AuditSchedule (xGUID, ID, Year_, lastYear, Approved, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Scope, Email, Email2, Desk, BusinessUnit, AuditDays, Scheduler)
	VALUES(#x#, #y#, #nextYear#, #xGUID#, 'Yes', '#AuditedBy#', '#AuditType#', '#AuditType2#', '#LeadAuditor#', '#Auditor#', '#OfficeName#', '#Area#', '#AuditArea#', #Month#, '#ScopeStatement#', '#Email#', '#Email2#', '#Desk#', '#BusinessUnit#', '#AuditDays#', '<u>Username:</u> Auto-Copy (IQA Admin) of Audit #Year_#-#ID# to #nextYear#<br><u>Date:</u> #curdate#')
	</cfquery>

	#j# Added: #nextYear#-#y#-#AuditedBy# (#x#)<br /><br>
	</cfoutput>

	<cfset y = y+1>
	<cfset x = x+1>
</cfloop>