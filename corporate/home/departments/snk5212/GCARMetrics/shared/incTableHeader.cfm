<cfoutput>
<!--- Find last variable in url to show in table heading --->
<cfif IsDefined("url.var")>
	<cfset SearchHeading = "#Search#">
</cfif>

<cfloop index="i" from="1" to="7">
	<cfif IsDefined("url.var#i#")>
		<cfset SearchHeading = "#Evaluate("Search#i#")#">
	</cfif>
</cfloop>

<!--- Number of columns for CAR Year: MaxYear - MinYear, used on line 53 below --->
<cfset varColumnYears = (#request.maxYear# - #Request.minYear#) + 1>
<!--- Add One for Total (or last two year comparison field) Column, used on line 25 --->
<cfset Colspan = #varColumnYears# + 1>
<cfset colSpanPerf = #ColSpan# + (varColumnYears * 2)>

 	<table border="1" style="border-collapse: collapse;">
		<tr align="center">
			<th>&nbsp;</td>
			<cfif url.showPerf eq "Yes">
				<cfset colspan = #colSpanPerf#>
			<cfelse>
				<cfset colspan = #colSpan#>
			</cfif>
			<cfoutput>
			<th colspan="#colspan#">Quantity of CARs</td>
			</cfoutput>
			<th>Drill Down</td>
			<th>Excel</td>
		</tr>
		<tr>
		<cfoutput>
			<th align="center">#SearchHeading#</td>
			<cfif url.showPerf eq "Yes">
				<cfset colspan = 3>
			<cfelse>
				<cfset colspan = 1>
			</cfif>
            <cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
                <th colspan="#colspan#" align="center">#i#</th>
            </cfloop>
            <cfset previousYear = #Request.maxyear# - 1>
			<th align="center"><cfif url.showPerf eq "Yes">#Request.maxYear# vs #previousYear#<cfelse>Total</cfif></td>
			<th align="center">Select Search Criteria</td>
			<th align="center">View CARs</td>
		</cfoutput>
		</tr>
		<cfif url.showPerf eq "Yes">
		<tr align="center">
			<th>&nbsp;</td>
			<cfloop index="i" from="1" to="#varColumnYears#">
                <th>CARs</td>
                <th>%</td>
                <th>&nbsp;</td>
			</cfloop>
			<!--- Total section --->
			<th>+/-</th>
			<!--- Drill Down and Excel --->
			<th>&nbsp;</td>
			<th>&nbsp;</td>
		</tr>
		</cfif>
</cfoutput>