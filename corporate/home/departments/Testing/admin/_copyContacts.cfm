 <!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Details">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<cfquery name="copyFrom" datasource="Corporate">
SELECT Area, OfficeName, Email, Email2 
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfquery name="copyTo" datasource="Corporate">
SELECT Year_, ID, Area, OfficeName, Email, Email2 
FROM AuditSchedule
WHERE Area = '#copyFrom.Area#'
AND OfficeName = '#copyFrom.OfficeName#'
AND Year_ >= 2010
ORDER BY Year_
</cfquery>

<cfdump var="#copyFrom#">
<cfdump var="#copyTo#">

<cfoutput query="copyTo">
	<cfquery name="doCopy" datasource="Corporate">
	UPDATE AuditSchedule
	SET
	Email='#copyFrom.Email#',
	Email2='#copyFrom.Email2#'
	WHERE ID = #ID#
	AND Year_ = #Year_#
	</cfquery>
</cfoutput>

<cfquery name="outputCopy" datasource="Corporate">
SELECT Year_, ID, Area, OfficeName, Email, Email2 
FROM AuditSchedule
WHERE Area = '#copyFrom.Area#'
AND OfficeName = '#copyFrom.OfficeName#'
AND Year_ >= 2010
ORDER BY Year_
</cfquery>

<cfdump var="#outputCopy#">

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->