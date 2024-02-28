<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfset var=ArrayNew(2)>
<cfset var[1][1] = 3>
<cfset var[2][1] = 6>
<cfset var[3][1] = 9>
<cfset var[4][1] = 12>
<cfset var[1][2] = "Q1">
<cfset var[2][2] = "Q2">
<cfset var[3][2] = "Q3">
<cfset var[4][2] = "Q4">

<cfloop from="1" to="4" index="i">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Q#i#">
SELECT * FROM Check
<cfif url.quarter is 1>
WHERE month <= #var[i][1]#
<cfelseif url.quarter is 2>
WHERE month BETWEEN 4 and #var[i][1]#
<cfelseif url.quarter is 3>
WHERE month BETWEEN 7 and #var[i][1]#
<cfelseif url.quarter is 4>
WHERE month BETWEEN 10 and #var[i][1]#
</cfif>
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
ORDER BY Month, ID
</cfquery>
</cfloop>

<table><tr><td class="blog-content">
<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#url.year# AND  Quarter = #url.quarter#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="RC">
<cfif Comments is "">
<cfelse>
<b>Comments</b><br>
#Comments#<br><br>
</cfif>
</cfoutput>

<cfset holder = "">
<cfoutput query="Q#url.quarter#" group="ID">
<cfif status is "Deleted">
<cfelse>
	<cfif Holder IS NOT Month> 
	<cfIf Holder is NOT ""><br></cfif>
	<b>#MonthAsString(Month)#</b><br>
	</cfif>
	<cfif report is NOT "Completed">
	 (No Report Filed)<br>
	<cfelse>
	<cfif Watch is 1>
	<font color="red">- #year#-#id# #externallocation# <a href="reportcard.cfm?TP=#ExternalLocation#">(View Report Card)</a></font><br>	
	<cfelse>
	- #year#-#id# #externallocation# <a href="reportcard.cfm?TP=#ExternalLocation#">(View Report Card)</a><br>	
	</cfif>
	</cfif>
<cfset Holder = Month>
</cfif>
</cfoutput>
<br><br>

* Clients listed in Red ....
</td></tr></table>