<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audits - Add to Schedule">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfset nextyr = #url.year# + 1>
<cfoutput>
#nextyr#
</cfoutput>

<CFQUERY Name="maxID" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT MAX(ID)+1 as maxID
 FROM AuditSchedule
 WHERE YEAR_='#nextyr#'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="maxID">
#maxID#
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->