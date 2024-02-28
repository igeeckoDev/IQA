<cfoutput>
	<cfif isDefined("url.showPerf")>
		<cfif url.showPerf eq "No">
			<cfset perfString = "showPerf=No">
		<cfelse>
			<cfset perfString = "showPerf=Yes&Perf=#url.Perf#&perfVar=#url.perfVar#">
		</cfif>
	</cfif>
</cfoutput>