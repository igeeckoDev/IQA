<cfquery name="Alerts" datasource="Corporate" blockfactor="100">
SELECT * FROM
CAR_ALERTS "ALERTS" 
WHERE Status = 'Active'
AND Year_ > 2013
ORDER BY Posted DESC
</cfquery>

<cfinclude template="inc_TOP.cfm">

<cfoutput>
<a href="#CARRootDir#viewMetrics.cfm">View</a> Quality Alert Metrics<br /><br />

<a href="#CARRootDir#getEmpNo.cfm?page=AddAlert">Add</a> Quality Alert<Br><br>
</cfoutput>

<b>Quality Alerts</b><br>
<cfif alerts.recordcount eq 0>
Currently there are no quality alerts.<br>
<cfelse>
	<cfoutput query="Alerts">
	 <a href="alertView.cfm?year=#year_#&ID=#ID#">#year_#-#id#</a> - #title# (#dateformat(posted, "mm/dd/yyyy")#)<Br>
</cfoutput>
</cfif><br>


<cflock scope="Session" Timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel is "SU">
<cfquery name="AlertsReview" datasource="Corporate" blockfactor="100">
SELECT * FROM
CAR_ALERTS "ALERTS" 
WHERE Status = 'Awaiting Review' 
OR Status IS NULL
</cfquery>

<b>Awaiting Review</b><br>
<cfif alertsReview.recordcount eq 0>
Currently there are no quality alerts awaiting review.<br>
<cfelse>
<cfoutput query="AlertsReview">
<a href="alertView.cfm?year=#year_#&ID=#ID#">#year_#-#id#</a> - #title# (#dateformat(posted, "mm/dd/yyyy")#)<Br>
</cfoutput>
</cfif><br>

<cfquery name="AlertsRejected" datasource="Corporate" blockfactor="100">
SELECT * FROM  CAR_ALERTS  "ALERTS" WHERE Status = 'Rejected'
</cfquery>

<b>Rejected</b><br>
<cfif alertsRejected.recordcount eq 0>
Currently there are no quality alerts that have been rejected.<br>
<cfelse>
<cfoutput query="AlertsRejected">
<a href="alertView.cfm?year=#year_#&ID=#ID#">#year_#-#id#</a> - #title# (#dateformat(posted, "mm/dd/yyyy")#)<Br>
</cfoutput>
</cfif><br>
	</cfif>
</cflock>