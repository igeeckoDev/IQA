<cfoutput>
<cfif url.showPerf eq "Yes">
	<cfif IsDefined("url.Perf") AND isDefined("url.perfvar")>
		<cfif url.perf eq "Escalations">
			<cfif url.perfvar eq "Response">
				<cfset perfvar = "No Response Escalations">
				<cfset perfvarLabel = "No Response Escalations">
				<cfset perfField = "MaxResponse">
				<cfset switch = "Implementation">
				<cfset green = #Request.ResponseEscalationGreen#>
				<cfset red = #Request.ResponseEscalationRed#>
			<cfelseif url.perfvar eq "Implementation">
				<cfset perfvar = "No Implementation Escalations">
				<cfset perfvarLabel = "No Implementation Escalations">
				<cfset perfField = "MaxImplement">
				<cfset switch = "Response">
				<cfset green = #Request.ImplementationEscalationGreen#>
				<cfset red = #Request.ImplementationEscalationRed#>
			</cfif>
		<cfelseif url.perf eq "Overdue">
			<cfif url.perfvar eq "Response">
				<cfset perfvar = "0">
				<cfset perfvarLabel = "No Response Overdue Notifications">
				<cfset perfField = "RON">
				<cfset switch = "Implementation">
				<cfset green = #Request.ResponseOverdueGreen#>
				<cfset red = #Request.ResponseOverdueRed#>
			<cfelseif url.perfvar eq "Implementation">
				<cfset perfvar = "0">
				<cfset perfvarLabel = "No Implementation Overdue Notifications">
				<cfset perfField = "ION">
				<cfset switch = "Response">
				<cfset green = #Request.ImplementationOverdueGreen#>
				<cfset red = #Request.ImplementationOverdueRed#>
			</cfif>		
		</cfif>
	</cfif>
</cfif>
</cfoutput>