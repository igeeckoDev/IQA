<cfset A = "Hello19">

<cfoutput>
#A#
</cfoutput>

==<br><br>

<CFQUERY DataSource="Corporate2" NAME="Accounts">
SELECT *
FROM AuditSchedule where Year_=2019


</CFQUERY>


<cfdump var="#Accounts#">