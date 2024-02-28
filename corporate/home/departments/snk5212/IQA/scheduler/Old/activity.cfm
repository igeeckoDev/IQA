<cfset Year = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #Year# + 1>
<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>

<cfif Month is 2 or Month is 5 or Month is 8 or Month is 11>
	<cfif Day is 01>

<cfif month IS 2>
	<cfset n = 4>
	<cfset reportyear = #year# - 1>
<cfelseif month IS 5>
	<cfset n = 1>
	<cfset reportyear = #year#>
<cfelseif month IS 8>
	<cfset n = 2>
	<cfset reportyear = #year#>
<cfelseif month IS 11>
	<cfset n = 3>
	<cfset reportyear = #year#>
</cfif>

<cfmail 
	to="William.R.Carney@ul.com" 
	from="Internal.Quality_Audits@ul.com"
	bcc="Christopher.J.Nicastro@ul.com, global.internalquality@ul.com, Internal.Quality_Audits@ul.com"
	subject="IQA Activity Reports - Quarter #n#, #Year#">
Please view the IQA Activity Reports for Quarter #n# of #year#:

Main IQA Activity Listing:
http://#CGI.Server_Name#/departments/snk5212/IQA/metrics_region.cfm

Views available:
  - Audited Program Coverage
  - Audited Site Coverage
  - Audited NACPO Programs Coverage
</cfmail>
	</cfif>
<cfelse>
</cfif>
