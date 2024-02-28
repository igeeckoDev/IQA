<cfquery name="Audits" datasource="Corporate" blockfactor="100">
SELECT * FROM AuditSchedule
WHERE Status IS NULL
AND AuditedBy = 'IQA'
AND AuditType = 'Quality System'
AND (AuditType2 IS NULL OR AuditType2 = 'Local Function')
ORDER BY OfficeName, Year_, AuditType2, AuditArea
</cfquery>

<cfset OfficeHolder = "">

<cfoutput query="Audits">
	<cfif OfficeHolder IS NOT OfficeName> 
	<cfIf OfficeHolder is NOT ""><br></cfif>
		<b><u>#OfficeName#</u></b><br> 
	</cfif>

	#Year_#-#ID# (#AuditType#/#AuditType2#) - #AuditArea#<br />

<cfset OfficeHolder = OfficeName>
</cfoutput>