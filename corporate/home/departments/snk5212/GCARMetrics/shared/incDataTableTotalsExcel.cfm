<cfoutput>
	<!--- Totals --->
	<cfif qTotal gt 0>
		<cfif url.showPerf eq "Yes">
			<cfif NoCountPreviousYear eq "No" AND NoCountMaxYear eq "No">
				<cfset delta = pcMaxYear - pcPreviousYear>
					<cfif delta gt 0>
						<cfset bgColor = "Green">
						<cfset fontColor = "Green">
						<cfset Text = "+">
					<cfelseif delta eq 0>
						<cfset bgColor = "White">
						<cfset fontColor = "Black">
						<cfset Text = "-">
					<cfelseif delta lt 0>
						<cfset bgColor = "Red">
						<cfset fontColor = "Red">
						<cfset Text = "!">
					</cfif>
				<td align="center">
					<font color="#fontColor#"><b>#delta#</b></font>
				</td>
				<td width="10" align="center" bgcolor="#bgColor#">
					<b>#Text#</b>
				</td>
            <!--- added for qProgram_Grouping.cfm page to handle zeros --->
			<cfelseif NoCountPreviousYear eq "Yes" AND NoCountMaxYear eq "No"
				OR NoCountPreviousYear eq "No" AND NoCountMaxYear eq "Yes">
                <td colspan="2" align="center">#none#</td>
			<cfelseif NoCountPreviousYear eq "Yes" AND NoCountMaxYear eq "Yes">
				<td colspan="2" align="center">#none#</td>
			</cfif>
		<cfelse>
			<td><b>#qTotal#</b></td>
		</cfif>
	<cfelse>
		<td align="center">#none#</td>
	</cfif>
</cfoutput>