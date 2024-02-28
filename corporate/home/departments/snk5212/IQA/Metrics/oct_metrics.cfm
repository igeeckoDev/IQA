<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset LastMonth = #CurMonth# - 1>
<cfset DayofMonth = #Dateformat(now(), 'dd')#>

<cfif DayofMonth is 04>

<cfmail
	 to="Global.InternalQuality@ul.com"
	 from="Internal.Quality_Audits@ul.com"
	 Mailerid="Metrics"
	 subject="Monthly Metrics">
	 

Please view http://#CGI.Server_Name#/departments/snk5212/IQA/metrics/monthly_metrics_view.cfm to view metrics for <cfif LastMonth is 1>January's<cfelseif LastMonth is 2>February's<cfelseif LastMonth is 3>March's<cfelseif LastMonth is 4>April's<cfelseif LastMonth is 5>May's<cfelseif LastMonth is 6>June's<cfelseif LastMonth is 7>July's<cfelseif LastMonth is 8>August's<cfelseif LastMonth is 9>September's<cfelseif LastMonth is 10>October's<cfelseif LastMonth is 11>November's<cfelseif LastMonth is 12>December's<cfelse></cfif> audits.
 
</cfmail>

<cfelse>

</cfif>
