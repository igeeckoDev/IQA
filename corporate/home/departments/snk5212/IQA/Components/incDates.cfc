<cfcomponent>
	<cffunction name="incDates" access="public" returntype="string">
	<cfargument name="StartDate" required="no" type="string" default="">
        <cfargument name="EndDate" required="no" type="string" default="">
        <cfargument name="Status" type="string" required="no">
        <cfargument name="RescheduleNextYear" type="string" required="no">
        
<cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(Status) is "Deleted">
	<cfset DateOutput = "Cancelled">
<cfelseif Trim(RescheduleNextYear) is "Yes">
	<cfset NextYear = #URL.Year# +1>
	<cfset DateOutput = "Rescheduled for #NextYear#">
<cfelse>				
	<cfif not len(trim(StartDate)) AND not len(trim(EndDate))>
        <cfset DateOutput = "No dates scheduled">
    <cfelseif len(trim(StartDate)) AND not len(trim(EndDate))>
        <cfset DateOutput = "#DateFormat(Start, 'mmmm dd, yyyy')#">
    <cfelseif len(trim(StartDate)) AND len(trim(EndDate))>
        <cfif CompareDate eq 0>
	        <cfset DateOutput = "#DateFormat(Start, 'mmmm dd, yyyy')#">
    	<cfelse>
        	<cfif End1 eq Start1>
    		<!--- start date and end date are in same month --->
            	<cfset DateOutput = "#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#">
        	<cfelse>
        	<!--- start date and end date are in different month --->
            	<cfset DateOutput = "#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#">
        	</cfif>
    	</cfif>
	</cfif>
 </cfif>

		<cfreturn DateOutput>
	</cffunction>
</cfcomponent>