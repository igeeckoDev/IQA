<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Third Party Report Card">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#URL.Year# AND  Quarter = #URL.Quarter#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
					  
<cfoutput query="RC">
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset LastYear = #CurYear# - 1>

<br><b>To</b>: Bill Carney, Jim Feth, Mike Jorgensen, Bob Bernd, Ray Burg, Jodi Hepner<br>
<b>From</b>: Internal Quality Audits<br>
<b>Subject</b>: Third Party Report Card - Quarter #url.quarter#, #url.Year#<br><br>

Please view the Third Party Report Card for Quarter #url.quarter# of #url.year# at the following link:<br><br>

http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?year=#url.year#<br><br>

<b>Comments</b><br>
#Comments#<br><br>
</cfoutput><hr><br>

<b>This Notification will be sent on 
<cfoutput>
<cfif quarter is 1>May 1, #CurYear#
<cfelseif quarter is 2>August 1, #CurYear#
<cfelseif quarter is 3>November 1, #CurYear#
<cfelseif quarter is 4>February 1, #CurYear#
</cfif>
</cfoutput></b>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
