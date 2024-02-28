<cfoutput>
	<cfset CompareDate = Compare(StartDate, EndDate)>
	<cfset Start = #StartDate#>
	<cfset End = #EndDate#>
	<cfset Start1 = DateFormat(Start, 'mm')>
	<cfset End1 = DateFormat(End, 'mm')>
	
	<cfif EndDate is NOT "">
	<cfset Compare = DateCompare(StartDate, EndDate)>
	</cfif>

<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
	#MonthAsString(Month)#, #Year#<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">
	#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>
	#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
	<cfif End1 eq Start1>
		#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
	<cfelse>
		#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
	</cfif>
</cfif>
</cfoutput>