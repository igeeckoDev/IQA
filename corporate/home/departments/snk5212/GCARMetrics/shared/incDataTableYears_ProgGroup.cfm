<cfoutput>
	<cfset none = " -- ">
	<cfif qResult.RecordCount eq 1 AND qResult.CARCount gt 0>
		<cfif i eq previousYear>
			<cfset NoCountPreviousYear = "No">
		<cfelseif i eq Request.maxYear>
			<cfset NoCountMaxyear = "No">
		</cfif>
		
		<cfset qTotal = qTotal + qResult.CARCount>
		
		<cfif url.showPerf eq "Yes">
			<!--- added for qProgram_Grouping.cfm page to handle zeros --->
        	<cfif qResult.CARCount neq 0>
				<!---<cfset perfTotal = perfTotal + Perf.Count>--->
                <cfset perfPC = Perf.Count / qResult.CARCount>
        
                <cfif perfPC gte #green#>
                    <cfset color = "green">
                <cfelseif perfPC lt #green# AND perfPC gte #red#>
                    <cfset color = "yellow">
                <cfelse>
                    <cfset color = "red">
                </cfif>
            <!--- added for qProgram_Grouping.cfm page to handle zeros --->
            <cfelse>
            	<cfset perfPC = 0>
                <cfset color = "None">
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
            	<!--- added for qProgram_Grouping.cfm page to handle zeros --->
				<cfif color eq "None">
					#none#
				<cfelse>
					<cfif perfPC eq 1>
                        #NumberFormat(perfPC * 100, "999")#
                    <cfelse>
                        <cfset FormatPerfPC = #NumberFormat(perfPC * 100, "999.9")# - 0>
                        #FormatPerfPC#
                    </cfif>
				</cfif>
				
			<cfif i eq previousYear>
				<cfset pcPreviousYear = NumberFormat(perfPC * 100, "999.9")>
			<cfelseif i eq Request.maxYear>
				<cfset pcMaxyear = NumberFormat(perfPC * 100, "999.9")>
			</cfif>
			</td>
			<td>
            	<!--- added for qProgram_Grouping.cfm page to handle zeros --->
				<cfif color neq "None">
	                <img src="images/#color#_dot.jpg" border="0" height="8">
				<cfelse>
                	-
				</cfif>
			</td>
		</cfif>

	<cfelseif qResult.RecordCount eq 1 AND qResult.CARCount eq 0>
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