<cfoutput>
WHERE
<cfinclude template="incProgramQuery.cfm">
	<cfif url.View eq "Open">
		CARState NOT LIKE 'Closed%' 
	<cfelseif url.View eq "Closed">
		CARState LIKE 'Closed%' 
	<cfelse>
		1=1
	</cfif>
</cfoutput>