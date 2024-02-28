 <!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Details">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<cfquery name="audits" datasource="Corporate">
SELECT Year_, ID, AuditArea, OfficeName, Status, RescheduleNextYear, Email, Email2 
FROM AuditSchedule
WHERE Area = '#URL.Area#'
AND AuditedBy = 'IQA'
AND Year_ >= 2009
ORDER BY Year_
</cfquery>

<cfoutput><strong>#URL.Area#</strong></cfoutput><br><br>

<cfoutput query="audits">
<u>#year_#-#ID#</u> #OfficeName# (#AuditArea#)<br>
Status: <cfif Status eq "deleted"><strong>#Status#</strong><cfelse>Active</cfif> <cfif RescheduleNextYear eq "Yes"><strong>[Rescheduled for Next Year]</strong></cfif><br>
Primary: #Email#<br>
Others: #Email2#<br>
<cfif Year_ eq 2009>
	<a href="_copyContacts.cfm?ID=#ID#&Year=#Year_#">Copy Contacts</a> to 2010 and 2011<br>
</cfif><br>
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->