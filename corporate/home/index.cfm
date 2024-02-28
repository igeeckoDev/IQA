<cfset A = "Hello">

<cfoutput>
#A#
</cfoutput>

==<br><br>

<CFQUERY Name="test" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2, ID, Year_, lastYear
FROM AuditSchedule
WHERE ID = 1
AND Year_ = 2018
AND AuditedBY = 'IQA'
</CFQUERY>

<cfdump var="#test#">