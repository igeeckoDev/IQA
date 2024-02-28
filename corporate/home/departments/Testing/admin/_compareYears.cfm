<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Details">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery name="Area" datasource="Corporate">
SELECT DISTINCT Area FROM AuditSchedule
WHERE Year_ >= 2009
ORDER BY Area
</cfquery>

<br>
<cfoutput query="Area">
	<cfquery name="audits" datasource="Corporate">
	SELECT Year_, ID, AuditArea, OfficeName, Status, RescheduleNextYear, Email, Email2 FROM AuditSchedule
	WHERE Area = '#Area#'
	AND AuditedBy = 'IQA'
	AND Year_ >= 2009
	ORDER BY AuditArea, OfficeName, Year_, ID
	</cfquery>

	<a href="_compareYears_detail.cfm?Area=#Area#&AuditedBy=IQA">#Area#</a><br>
	<cfloop query="audits">
	 :: #year_#-#ID# #OfficeName# <cfif Status eq "deleted"><strong>#Status#</strong></cfif> <cfif RescheduleNextYear eq "Yes"><strong>[Rescheduled for Next Year]</strong></cfif> #AuditArea#<Br>
	</cfloop><br>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->