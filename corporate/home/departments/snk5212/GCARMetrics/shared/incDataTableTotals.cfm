<cfoutput>
	<!--- Totals --->
	<cfif qTotal gt 0>
		<cfif url.showPerf eq "Yes">
			<cfif NoCountPreviousYear eq "No" AND NoCountMaxYear eq "No">
				<td align="center">
					<cfset delta = pcMaxYear - pcPreviousYear>
						<cfif delta gt 0>
							<cfset deltaFontColor = "Green">
						<cfelseif delta eq 0>
							<cfset deltaFontColor = "Black">
						<cfelseif delta lt 0>
							<cfset deltaFontColor = "Red">
						</cfif>
							
					<font color="#deltaFontColor#">
						<b>#delta#</b>
					</font>
				</td>
			<!--- added for qProgram_Grouping.cfm page to handle zeros --->
			<cfelseif NoCountPreviousYear eq "Yes" AND NoCountMaxYear eq "No"
				OR NoCountPreviousYear eq "No" AND NoCountMaxYear eq "Yes">
                <td align="center">#none#</td>
			<cfelseif NoCountPreviousYear eq "Yes" AND NoCountMaxYear eq "Yes">
				<td align="center">#none#</td>
			</cfif>
		<cfelse>
			<td><b>#qTotal#</b></td>
		</cfif>
	<cfelse>
		<td align="center">#none#</td>
	</cfif>
</cfoutput>