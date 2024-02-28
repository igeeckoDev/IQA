<cfset CopyFromYear = #url.year# - 1>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AuditList">
SELECT xGUID, Year_, ID, Area, AuditArea, AuditType2, Status, Month
FROM AuditSchedule
WHERE Year_ = #CopyFromYear#
AND AuditedBy = 'IQA'
AND (Status IS NULL OR Status = 'Deleted')
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