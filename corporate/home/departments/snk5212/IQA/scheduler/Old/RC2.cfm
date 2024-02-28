<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- 1/28/2008
No longer needed because TP is gone in 2008

<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#url.year# AND  Quarter = #url.quarter#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="RC">
Please view the Third Party Report Card for Quarter #quarter# of #year#:<br><br>

http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?year=#year#<br><br>

Comments:<br><br>
#Comments#
</cfoutput>

--->
