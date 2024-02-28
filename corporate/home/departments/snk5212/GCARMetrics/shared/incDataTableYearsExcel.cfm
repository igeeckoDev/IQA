<cfoutput>
	<cfset none = " -- ">
	<cfif qResult.RecordCount eq 1>
		<cfif i eq previousYear>
			<cfset NoCountPreviousYear = "No">
		<cfelseif i eq Request.maxYear>
			<cfset NoCountMaxYear = "No">
		</cfif>
		
		<cfset qTotal = qTotal + qResult.CARCount>
		
		<cfif url.showPerf eq "Yes">
			<!---<cfset perfTotal = perfTotal + Perf.Count>--->
			<cfset perfPC = Perf.Count / qResult.CARCount>
	
			<cfif perfPC gte #green#>
				<cfset bgColor = "green">
				<cfset Text = "+">
			<cfelseif perfPC lt #green# AND perfPC gte #red#>
				<cfset bgColor = "yellow">
				<cfset Text = "-">
			<cfelse>
				<cfset bgColor = "red">
				<cfset Text = "!">
			</cfif>
		</cfif>
	
	<td>
   		<cfif qResult.CARCount gt 0>
        	#qResult.CARCount#
		<cfelse>
        	#none#
		</cfif>
    </td>
	
		<cfif url.showPerf eq "Yes">
			<td>
				<cfif perfPC eq 1>
					#NumberFormat(perfPC * 100, "999")#
				<cfelse>
					<cfset FormatPerfPC = #NumberFormat(perfPC * 100, "999.9")# - 0>
					#FormatPerfPC#
				</cfif>
				
			<cfif i eq previousYear>
				<cfset pcPreviousYear = NumberFormat(perfPC * 100, "999.9")>
			<cfelseif i eq Request.maxYear>
				<cfset pcMaxYear = NumberFormat(perfPC * 100, "999.9")>
			</cfif>
			</td>
			<td bgcolor="#bgColor#">
				<b>#Text#</b>
			</td>
		</cfif>

	<cfelseif qResult.RecordCount eq 0>
		<cfif i eq previousYear>
			<cfset NoCountPreviousYear = "Yes">
		<cfelseif i eq Request.maxYear>
			<cfset NoCountMaxYear = "Yes">
		</cfif>
		
		<cfset qTotal = qTotal>
		<!---<cfset perfTotal = perftotal>--->	
		<!--- moved to top of this file 
		<cfset none = " -- ">
		--->
		<td align="center">#none#</td>
		<cfif url.showPerf eq "Yes">
			<td align="center">#none#</td>
			<td align="center">-</td>
		</cfif>
	</cfif>
</cfoutput>