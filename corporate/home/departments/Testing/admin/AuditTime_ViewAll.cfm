<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Time - Planning and Reporting - #url.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif url.year LTE 2015>
	<cfoutput>
	This was implemented in 2016; there is no data for 2015 or earlier.<br><br>

	<A href="AuditTime_ViewAll.cfm?Year=#curYear#">View #curyear#</a>
	</cfoutput>
<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year", AuditType2, OfficeName, Area, AuditArea
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
AND AuditedBy = 'IQA'
ORDER BY Month, ID
</cfquery>

<cfoutput>
Select Year -
<cfif URL.Year is LastYear>
	<b>#LastYear#</b> <a href="AuditTime_ViewAll.cfm?Year=#CurYear#">[ #CurYear# ]</a> <a href="AuditTime_ViewAll.cfm?Year=#NextYear#">[ #NextYear# ]</a><br>
<cfelseif URL.Year is CurYear>
	<a href="AuditTime_ViewAll.cfm?Year=#LastYear#">[ #LastYear# ]</a> <b>#CurYear#</b> <a href="AuditTime_ViewAll.cfm?Year=#NextYear#">[ #NextYear# ]</a><br>
<cfelseif URL.Year is NextYear>
	<a href="AuditTime_ViewAll.cfm?Year=#LastYear#">[ #LastYear# ]</a> <a href="AuditTime_ViewAll.cfm?Year=#CurYear#">[ #CurYear# ]</a> <b>#NextYear#</b> <br>
</cfif>
<br>
</cfoutput>

View Month:<br>
<SELECT NAME="Month" displayname="Month" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="###i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<table border="1" width="800">
<cfset M = "">
<cfoutput query="Check">

<cfif Status is "removed">
<!--- /// --->
<cfelse>
	<cfif M IS NOT Month>
	<cfIf M is NOT ""><tr><th colspan="6" align="right" ><a href="##Top">Top <img src="../images/top.gif" alt="" height="7" width="5" border="0"></a>&nbsp;</th></tr></cfif>
	<tr><th colspan="6"><a name="#Month#"></a><b><u>#MonthAsString(Month)#</u></b></th></tr>
	<tr>
		<th>Audit<br>Number</th>
		<th>Lead Auditor</th>
		<th>Audit Details</th>
		<th>Planning Time (Hours)</th>
		<th>Reporting Time (Hours)</th>
	</tr>
	</cfif>
<tr>
<!--- Audit Number --->
<td><a href="auditdetails.cfm?id=#id#&year=#year#">#Year#-#ID#</a>
<cfif reschedulenextyear is "Yes"><font class="warning"><b>(Rescheduled for Next Year)</b></font></cfif>
<cfif status is "deleted"><font class="warning"><b>Cancelled</b></font></cfif>
</td>

<!--- Auditor Name --->
<td>#LeadAuditor#</td>

<!--- Audit Details --->
<td>
	<u>Audit Type</u>: #AuditType2#<br>
	<u>Office</u>: #OfficeName#<br>
	<u>Area</u>: #Area#<br>
	#AuditArea#
</td>

<CFQUERY BLOCKFACTOR="100" name="Time" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT PlanningTime, ReportingTime
FROM IQAAuditTime
WHERE Year_ = #url.Year#
AND ID = #ID#
</cfquery>

<!--- Planning Time --->
<td align="center"><cfif len(Time.PlanningTime)>#Time.PlanningTime#<cfelse>--</cfif></td>

<!--- Reporting Time --->
<td align="center"><cfif len(Time.ReportingTime)>#Time.ReportingTime#<cfelse>--</cfif></td>

</tr>
<cfset M = Month>
</cfif>
</cfoutput>
</table>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->