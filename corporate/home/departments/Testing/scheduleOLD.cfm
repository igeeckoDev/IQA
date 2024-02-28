<!--- April 29, 2009
Tested for CF8/Oracle
added cfqueryparam for URL variables
--->

<!--- 4/7/2009 --->
<!--- no schedule view is available more than 2 years ahead of the current year --->
<cfset maxyear = #curyear# + 3>
<!--- if url.year is not included in url --->
<cfif NOT isDefined("URL.Year")>
	<cfset url.year = #curyear#>
<!--- if url.year is not numeric --->
<cfelseif NOT isNumeric(URL.Year)>
	<cfset url.year = #curyear#>
<!--- if year is less than 2004, which is first year of schedule --->
<cfelseif URL.Year lt 2004>
	<cfset url.year = 2004>
<!--- if the year is more than current year plus two years, change the year to maxyear variable --->
<cfelseif URL.year gt maxyear>
	<cfset url.year = #maxyear#>
</cfif>

<!--- if there is no auditedby variable, set it to IQA --->
<cfif NOT isDefined("URL.AuditedBy")>
	<cfset url.auditedby = "IQA">
</cfif>

<!--- if there is no auditor variable, set it to all --->
<cfif NOT isDefined("URL.Auditor")>
	<cfset url.auditor = "All">
</cfif>
<!--- // --->

<!---
removed 4/7/2009 and replaced with comments above
<cfif NOT isDefined("URL.Year") AND URL.AuditedBy is "AS" AND URL.Auditor is "All">
	<cflocation url="schedule.cfm?year=#curyear#&#cgi.query_string#" addtoken="no">
</cfif>
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "">
<cfinclude template="SOP.cfm">

<!--- / --->

<table border="0" width="100%">
<Tr>
<td align="left" valign="top" colspan="2">
<cfoutput>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>

<div align="left" class="blog-date">
#URL.Year# <cfif url.auditedby is "AllAccred">Accreditation<cfelseif url.auditedby is "AS">Accreditation Services<cfelse>#URL.AuditedBy#</cfif> Audit Schedule

<cfif URL.Auditedby IS "IQA">
<CFQUERY DataSource="Corporate" Name="BaseLine">
SELECT * FROM Baseline
WHERE Year_ = #URL.Year#
</cfquery>

<cfif BaseLine.BaseLine eq 0>
	<cfoutput>
	 - <font color="red">Tentative</font>
	</cfoutput>
</cfif>
</cfif>

</div>

<div align="Left" class="blog-content">
<cfset prevyear = #url.year# - 1>
<cfset nxtyear = #url.year# + 1>
<cfset twoyear = #url.year# + 2>
Select Year:
<cfif url.year is "2004">
<b>#url.year#</b> <a href="schedule.cfm?Year=#nxtyear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #nxtyear# ]</a> <a href="schedule.cfm?Year=#twoyear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #twoYear# ]</a>
<cfelse>
<a href="schedule.cfm?Year=#prevyear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #prevyear# ]</a> <b>#url.year#</b> <a href="schedule.cfm?Year=#nxtyear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #nxtyear# ]</a>
</cfif>
<br>
<a href="schedule.cfm?Year=#CurYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">View</a> Current Year
<br>
</div>
</td>
</tr>
<Tr>
<td align="left" class="blog-content" valign="top" width="60%">
<u>View Audit Schedules</u>:<br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&Auditor=All">IQA</a><br>
 - <a href="schedule_view.cfm">Regional</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=Finance&Auditor=All">Corporate Finance</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=AS&Auditor=All">Accreditation Services</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=AllAccred&Auditor=All">All External Accreditation</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=QRS&Auditor=All">QRS</a><br><br>
</cfoutput>

Scroll to a specific month:<br>
<SELECT NAME="e_Month" displayname="Month" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="###i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT><br><br>
</td>
<td align="left" class="blog-content" valign="top" width="40%">
<cfinclude template="color_status.cfm">
</td>
</TR>
</table>
		</td>
                        </tr>

                        <tr>
                          <td></td>
                          <td width="92%" align="left" class="sched-content">

<CFQUERY BLOCKFACTOR="100" NAME="Total" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE (Status = 'Deleted' OR Status = '' OR Status IS NULL)
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
<cfif isDefined("url.auditor")>
	<cfif url.auditor is NOT "All">
	AND (Auditor LIKE '%#URL.Auditor#%'
	OR LeadAuditor LIKE '%#URL.Auditor#%')
	</cfif>
</cfif>
<cfif url.auditedby is "AllAccred">
AND (AuditedBy = 'AS' OR AuditedBy = 'Accred')
<cfelse>
AND AuditedBy = '#trim(URL.AuditedBy)#'
</cfif>
ORDER BY ID
</cfquery>

<cfif Total.Recordcount eq 0>
<cfoutput>
<table border="1" width="650" valign="Top">
<tr>
<td class="blog-content" align="center">
There are no audits scheduled by #URL.AuditedBy# for #URL.Year#.
</td>
</tr></table>
</cfoutput>
<cfelse>

<cfloop index="i" From="1" To="12">
<table border="1" width="650">
<tr>

<CFQUERY BLOCKFACTOR="100" NAME="Blah" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE (Status = 'Deleted' OR Status IS NULL)
AND Month = #i#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
<cfif isDefined("url.auditor")>
	<cfif url.auditor is NOT "All">
	AND (Auditor LIKE '%#URL.Auditor#%'
	OR LeadAuditor LIKE '%#URL.Auditor#%')
	</cfif>
</cfif>
<cfif url.auditedby is "AllAccred">
AND audittype2 = 'Accred'
<cfelse>
AND AuditedBy = '#trim(URL.AuditedBy)#'
</cfif>
ORDER BY ID
</cfquery>

<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes">
<cfif Blah.Recordcount eq 0>
	<CFOUTPUT>
	<td colspan="4" class="sched-title">
	<a name="#i#"></a>
	<div align="center" class="blog-title">#MonthAsString(i)# #Year#</div>
	</td>
	</tr>
	<tr>
	<td colspan="4" class="sched-content" align="center">
	No audits scheduled.
	</td>
	</cfoutput>
<cfelse>

<cfif url.auditedby is "AS" or url.auditedby is "QRS" or blah.audittype2 is "Accred" or blah.auditedby is "Finance" or blah.auditedby is "LAB">
	<cfinclude template="OutputQuery_AS.cfm">
<cfelse>
	<cfinclude template="OutputQuery.cfm">
</cfif>
</cfif>
</CFPROCESSINGDIRECTIVE>

</tr>
<tr>
	<td class="article-end" colspan="4" align="right"><br><p class="blog-content"><a href="#">Top <img src="images/top.gif" alt="" height="7" width="5" border="0"></a></p></td>
</tr>
</table><br><br>
</cfloop>
</cfif>
						</td></tr>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->