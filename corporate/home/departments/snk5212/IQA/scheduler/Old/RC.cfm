<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- 1/28/2008
No longer needed because TP is gone in 2008

<cfset Year = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #Year# + 1>
<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>

<cfif month IS 1>
	<cfset n = 4>
	<cfset reportyear = #year# - 1>
<cfelseif month IS 4>
	<cfset n = 1>
	<cfset reportyear = #year#>
<cfelseif month IS 7>
	<cfset n = 2>
	<cfset reportyear = #year#>
<cfelseif month IS 10>
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

<cfoutput query="RC">
Please view the Third Party Report Card for Quarter #quarter# of #year#:<br><br>

http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?year=#year#<br><br>

Comments:<br><br>
#Comments#
</cfoutput>

--->
