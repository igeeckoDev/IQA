<cfoutput>
<cfif url.Manager neq "None">
AND (CAROwner = '#URL.Manager#'
	OR CAROwnersManager = '#URL.Manager#'
	OR CAROwners2ndLevelManager = '#URL.Manager#'
	OR CAROwners3rdLevelManager = '#URL.Manager#'
	OR CAROwners4thLevelManager = '#URL.Manager#'
	OR CARDeptQualityManager = '#URL.Manager#')
	<cfif url.View eq "Open">
	AND CARState NOT LIKE 'Closed%'
	<cfelseif url.View eq "Closed">
	AND CARState LIKE 'Closed%'
	</cfif>
		<cfinclude template="incCARClassification.cfm">
<cfelse>
	<cfif url.View eq "Open">
		AND CARState NOT LIKE 'Closed%'
		<cfinclude template="incCARClassification.cfm">
	<cfelseif url.View eq "Closed">
		AND CARState LIKE 'Closed%'
		<cfinclude template="incCARClassification.cfm">
	<cfelse>
		<cfif url.Type eq "Finding">
		AND CARFindOrObservation = 'Finding'
		<cfelseif url.Type eq "Observation">
		AND CARFindOrObservation = 'Observation'
		</cfif>
	</cfif>
</cfif>
AND CARYear BETWEEN #Request.minYear# AND #Request.maxYear#
</cfoutput>