<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
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

<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#reportyear# AND  Quarter = #n#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfmail 
	to="Christopher.J.Nicastro@ul.com" 
	from="Internal.Quality_Audits@ul.com"
	subject="Third Party Report Card - Quarter #Quarter#, #Year#"
	query="RC">Please view the Third Party Report Card for Quarter #quarter# of #year#:

http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?year=#curyear#

Comments:
<cfset S1 = #ReplaceNoCase(Comments,"<br>",chr(13), "ALL")#>
#S1#
</cfmail>
	</cfif>
<cfelse>
</cfif>
