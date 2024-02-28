<cfoutput>
<!--- query string for switching data set between All/Open/Closed CARs --->
<cfif url.showPerf eq "No">
	<cfset queryStringPerf = "showPerf=No">
	<cfset queryStringSwitchDataSetView = "#queryStringViewChange#&#queryStringPerf#">
	<cfset queryStringSwitchDataSetType = "#queryStringTypeChange#&#queryStringPerf#">
<cfelseif url.showPerf eq "Yes">
	<cfset queryStringPerf = "showPerf=Yes&Perf=#url.Perf#&PerfVar=#url.PerfVar#">
	<cfset queryStringSwitchDataSetView = "#queryStringViewChange#&#queryStringPerf#">
	<cfset queryStringSwitchDataSetType = "#queryStringTypeChange#&#queryStringPerf#">
</cfif>

<b>Search Criteria</b>: <span class="warning"><b>GCAR Metrics Data last updated on #Request.DataDate#</b><br /><br />

<!--- Note - datamart is no longer available, and the replacement (datahub) is under development currently. Until the replacement is finished, GCAR Metrics will not be updated.</b>---></span>

<u>Current Data Set</u> - <b>#url.View# #Type#</b> (#qCARCount.TotalCARs# CARs)<br>
<u>CAR Status</u>: 
<cfif URL.View eq "All">
	<b>All</b> 
	[<a href="#CGI.Script_Name#?View=Open&#queryStringSwitchDataSetView#">Open</a>] 
	[<a href="#CGI.Script_Name#?View=Closed&#queryStringSwitchDataSetView#">Closed</a>] 
	(Does not include New or Submitted CARs)
<cfelseif URL.View eq "Open">
	[<a href="#CGI.Script_Name#?View=All&#queryStringSwitchDataSetView#">All</a>] 
	<b>Open</b> 
	[<a href="#CGI.Script_Name#?View=Closed&#queryStringSwitchDataSetView#">Closed</a>] 
	(Does not include New, Submitted or Closed CARs)
<cfelseif URL.View eq "Closed">
	[<a href="#CGI.Script_Name#?View=All&#queryStringSwitchDataSetView#">All</a>] 
	[<a href="#CGI.Script_Name#?View=Open&#queryStringSwitchDataSetView#">Open</a>]
	<b>Closed</b>
</cfif><br>

<u>Classification</u>: 
<cfif url.Type eq "All">
	<b>All</b> 
	[<a href="#CGI.Script_Name#?Type=Finding&#queryStringSwitchDataSetType#">Findings</a>] 
	[<a href="#CGI.Script_Name#?Type=Observation&#queryStringSwitchDataSetType#">Observations</a>]
<cfelseif url.Type eq "Finding">
	[<a href="#CGI.Script_Name#?Type=All&#queryStringSwitchDataSetType#">All</a>] 
	<b>Findings</b>
	[<a href="#CGI.Script_Name#?Type=Observation&#queryStringSwitchDataSetType#">Observations</a>]
<cfelseif url.Type eq "Observation">
	[<a href="#CGI.Script_Name#?Type=All&#queryStringSwitchDataSetType#">All</a>] 
	[<a href="#CGI.Script_Name#?Type=Finding&#queryStringSwitchDataSetType#">Findings</a>] 
	<b>Observations</b>
</cfif><br>

<!--- Geography --->

<!--- /// --->

<cfif url.Manager neq "None">
	<u>Manager Name</u> - #url.Manager#<br>
</cfif>

<cfif cgi.SCRIPT_NAME eq "/departments/snk5212/GCARMetrics/qManager.cfm" 
	OR cgi.SCRIPT_NAME eq "/departments/snk5212/GCARMetrics/qProgram_Grouping.cfm">
	<cfif isDefined("URL.Group") AND url.Group eq "Yes">
        <u>Custom Grouping</u> - <b>#url.GroupName#</b><br />
        <!---
		<cfif len(getItems.ExcludedName) AND len(getItems.ExcludedType)>
            <u>Exception</u> - <u>#getItems.ExcludedType#</u> does not equal <u>#getItems.ExcludedName#</u><Br />
        </cfif>
		--->
    </cfif>
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
<u>CAR Performance</u> - Percent of CARS with <b>#perfvarLabel#</b> [<a href="#CGI.ScriptName#?#queryString1#&showPerf=No">Remove</a>]<br><br>
</cfif>

<cfif URL.View eq "All">
	* All #Type# (Does not include CARs that have not yet been assigned to a CAR Owner (New and Submitted CARs), or Force Closed CARs)<br>
<cfelseif URL.View eq "Open">
	* Open #Type# (Does not include CARs that have not yet been assigned to a CAR Owner (New and Submitted CARs), or CARs that have been Closed)<br>
<cfelseif URL.View eq "Closed">
	* Closed #Type# (Does not include Force Closed CARs)<br />
</cfif>
</cfoutput>