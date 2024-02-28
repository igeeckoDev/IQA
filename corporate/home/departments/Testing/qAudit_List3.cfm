<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="List">
SELECT Year_, ID, AuditedBy, Area, AuditArea, OfficeName, AuditType, AuditType2 
FROM AuditSchedule
WHERE 
	Status IS Null
	AND  (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
	AND  Year_ = <cfqueryparam value="#url.year#" cfsqltype="cf_sql_integer">

ORDER BY ID
</cfquery>

<cfset i = 0>

<cfoutput query="List">
<a href="auditdetails.cfm?id=#ID#&Year=#year_#">#year_#-#ID#-#AuditedBy#</a> :: 
	<cfif auditedby eq "IQA">
		#replace(officename, "!", ", ", "All")# - #Area#
	<cfelseif auditType eq "Accred">
		#replace(officename, "!", ", ", "All")# - #AuditType#
	<cfelse>
		#replace(officename, "!", ", ", "All")# - #AuditType# #AuditType2# #Area#
	</cfif><br>

<cfset i = #i# + 1>
</cfoutput><br>

<cfoutput>#i#</cfoutput>
