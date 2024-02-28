<cfoutput>
<u>CAR Count</u> - <b>#qCARCount.TotalCARs# CARs</b><br>

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

<cfif URL.View eq "All">
	* All CARs (Does not include New or Submitted CARs)<br>
<cfelseif URL.View eq "Open">
	* Open CARs (Does not include New, Submitted, or Closed CARs)<br>
</cfif>
</cfoutput>