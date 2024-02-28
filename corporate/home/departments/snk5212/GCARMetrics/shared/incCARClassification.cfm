<cfoutput>
	<cfif url.Type eq "Finding">
	AND CARFindOrObservation = 'Finding'
	<cfelseif url.Type eq "Observation">
	AND CARFindOrObservation = 'Observation'
	</cfif>
</cfoutput>