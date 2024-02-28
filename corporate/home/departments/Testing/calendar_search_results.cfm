<cfoutput query="SearchResults">
<!--- Date Variables. Global Doc Audits are handled differently = they only show the start date, as they can go on for long periods of time. --->

<cfset CompareDate = Compare(StartDate, EndDate)>
<cfset Start = #StartDate#>
<cfset Start1 = DateFormat(Start, 'mm')>

<cfif audittype2 is NOT "Global Function/Process">
	<cfset End = #EndDate#>
<cfelse>
	<!--- There are no more 'open ended' Global Desk audits starting in 2014, so, show all dates on the calendar --->
	<cfif URL.Year GTE 2014>
		<cfset End = #EndDate#>
	<cfelse>
    	<cfset End = #StartDate#>
    </cfif>
</cfif>

<cfset End1 = DateFormat(End, 'mm')>

<cfif len(EndDate)>
	<cfif audittype2 is NOT "Global Function/Process">
        <cfset Compare = DateCompare(StartDate, EndDate)>
    <cfelse>
	    <!--- There are no more 'open ended' Global Desk audits starting in 2014, so, show all dates on the calendar --->
    	<cfif URL.Year GTE 2014>
        	<cfset Compare = DateCompare(StartDate, EndDate)>
		<cfelse>
        	<cfset Compare = DateCompare(StartDate, StartDate)>
        </cfif>
    </cfif>
</cfif>

<!--- Component - incDates.cfc. Used to output audit dates --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">
    
	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>
	
	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>
    
    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>
<!--- /// --->

<cfif start1 eq end1>
	<cfswitch expression = #Compare#>
    <cfcase value = "-1">
		<cfif #day# GTE '#day(start)#' AND #day# LTE '#day(end)#'>
            <cfinclude template="calendar_output.cfm">
		</cfif>
    </cfcase>
	<cfcase value = "0">
    	<cfif audittype2 is NOT "Global Function/Process">
			<cfif #day# is '#day(startdate)#' OR #day# is '#day(enddate)#'>	
            	<cfinclude template="calendar_output.cfm">
			</cfif>
		<cfelse>
        	<!--- There are no more 'open ended' Global Desk audits starting in 2014, so, show all dates on the calendar --->
        	<cfif URL.Year GTE 2014>
				<cfif #day# is '#day(startdate)#' OR #day# is '#day(enddate)#'>	
                    <cfinclude template="calendar_output.cfm">
                </cfif>
			<cfelse>
				<cfif #day# is '#day(startdate)#' AND Start1 eq MonthSet>
                    <cfinclude template="calendar_output.cfm">
                </cfif>
			</cfif>
        </cfif>
    </cfcase>
    </cfswitch>
<cfelseif start1 lt end1>
	<cfif start1 is monthset>
    	<cfif #day# gte '#day(start)#'>
            <cfinclude template="calendar_output.cfm">
		</cfif>
	<cfelseif end1 is monthset>
		<cfif #day# lte '#day(end)#'>
       	    <cfinclude template="calendar_output.cfm">
		</cfif>
	</cfif>
</cfif>
</cfoutput>