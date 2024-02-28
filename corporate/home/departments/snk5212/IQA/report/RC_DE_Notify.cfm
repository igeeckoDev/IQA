<cfset Year = #Dateformat(now(), 'yyyy')#>
<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>

<cfif month is 3>
	<cfset n = 1>
	<cfset reportyear = #year# - 1>
<cfelseif month is 6>
	<cfset n = 2>
	<cfset reportyear = #year#>
<cfelseif month is 9>
	<cfset n = 3>
	<cfset reportyear = #year#>
<cfelseif month is 12>
	<cfset n = 4>
	<cfset reportyear = #year#>
</cfif>

<cfif Month is 12 or Month is 3 or Month is 6 or Month is 9>
	<cfif Day is 18>
<cfmail 
	to="Global.InternalQuality@ul.com" 
	from="Internal.Quality_Audits@ul.com"
	subject="Third Party Report Card Quarterly Comments Due (Quarter #n#, #reportyear#)">

Comments for the Third Party Report Card are due for Quarter #n#, #reportyear#.

Please add comments for the Third Party Report Card. Please log in and follow the link below:
http://#CGI.Server_Name#/departments/snk5212/iqa/admin/TPTDP.cfm

To view the report as NAPCO will see it, go to:
http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?Year=#reportyear#
</cfmail>
	</cfif>
<cfelse>
</cfif>
