<cfoutput>
GCAR Data as of #Request.DataDate#<br>
Report Saved #dateformat(now(), "mm/dd/yyyy")#<br><br>

<b>Search Criteria</b>:<br>
<u>CAR Status</u> - <b>#URL.View#</b><Br>
<cfif URL.View eq "All">
	* All CARs (Does not include New or Submitted CARs)<br>
<cfelseif URL.View eq "Open">
	* Open CARs (Does not include New, Submitted, or Closed CARs)<br>
</cfif>

<u>Classification</u> - <b>#Type#</b><br>

<cfif url.Manager neq "None">
	<u>Manager Name</u> - #url.Manager#<br>
</cfif>

<cfif isDefined("URL.Group") AND url.Group eq "Yes">
	<cfif url.refPage eq "/departments/snk5212/GCARMetrics/Report_Table2.cfm">
    	<cfset url.GroupName = "#url.varValue#">
    </cfif>
	<u>Custom Grouping</u> - <b>#url.GroupName#</b><br />
</cfif>

<cfif isDefined("URL.Program") AND url.Program NEQ "Null">
	<cfset newVal = #replace(url.Program, "|", ", ", "All")#>
	<u>Program Name</u> - #newVal#<br>
</cfif>

<cfif IsDefined("url.var")>
	<u>#Search#</u>
	<cfif isDefined("url.varValue")>
	 - #url.varValue#
	<cfelse>
	 by Year
	</cfif><br>
</cfif>

<cfloop index="i" from="1" to="7">
	<cfif IsDefined("url.var#i#")>
		<u>#Evaluate("Search#i#")#</u>
		<cfif isDefined("url.var#i#Value")>
		 - #Evaluate("url.var#i#Value")#
		<cfelse>
		 by Year
		</cfif><br>
	</cfif>
</cfloop><br>

<cfif url.showPerf eq "Yes">
<u>CAR Performance</u> - Percent of CARS with <b>#perfvarLabel#</b><br><br>
</cfif>
</cfoutput>