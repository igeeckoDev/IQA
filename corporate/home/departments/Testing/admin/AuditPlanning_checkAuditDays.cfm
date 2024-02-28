<cfset startdate = "09/22/2014">
<cfset enddate = "09/22/2014">

<cfset variables.totalWorkingDays = 0>

<Cfoutput>
	<cfloop from="#startdate#" to="#enddate#" index="i">
	<!--- excludes saturday and sunday --->
	    <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
	       <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
	    </cfif>
	</cfloop>

#variables.totalWorkingDays#<Br>
</cfoutput>