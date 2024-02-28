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

<cfif URL.Auditor neq "All">
	<cfset Title_Auditor = "for #URL.Auditor#">
<cfelse>
	<cfset Title_Auditor = "for All Auditors">
</cfif>

<cfif url.auditedby is "AllAccred">
	<cfset Title_AuditedBy = "Accreditation">
<cfelseif url.auditedby is "AS">
	<cfset Title_AuditedBy = "Accreditation Services">
<cfelseif url.auditedby is "Medical">
	<cfset Title_AuditedBy = "Medical">
<cfelseif url.auditedby is "LAB">
	<cfset Title_AuditedBy = "Laboratory Technical Audit">
<cfelseif url.auditedby is "Finance">
	<cfset Title_AuditedBy = "Internal Audit / Corporate Finance">
<cfelseif url.auditedby is "IQA">
	<cfset Title_AuditedBy = "Internal Quality Audits">
<cfelseif url.auditedby is "VS">
	<cfset Title_AuditedBy = "Verification Services">
<cfelseif url.auditedby is "ULE" OR url.auditedby is "UL Environment">
	<cfset Title_AuditedBy = "UL Environment">
<cfelseif url.auditedby is "WiSE">
	<cfset Title_AuditedBy = "WiSE">
<cfelseif url.auditedby is "All">
	<cfset Title_AuditedBy = "All Audits">
<cfelse>
	<cfset Title_AuditedBy = "#URL.AuditedBy#">
</cfif>

<!--- Start of Page File --->
<cfset subTitleHeading = "#URL.Year# #variables.Title_AuditedBy# - Audit Schedule #Title_Auditor#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<table border="0" width="100%">
<Tr>
<td align="left" valign="top" colspan="2">
<cfoutput>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>

<cfif URL.Auditedby IS "IQA" OR isDefined("URL.Auditor")>
    <CFQUERY DataSource="Corporate" Name="BaseLine">
    SELECT * FROM Baseline
    WHERE Year_ = #URL.Year#
    </cfquery>

	<cfif BaseLine.BaseLine eq "No">
    <div align="left" class="blog-content">
        <cfoutput>
        <font color="red"><b>#URL.Year# IQA Schedule is Tentative</b></font>
        </cfoutput>
    </div>
    </cfif>
</cfif>

<div align="Left" class="blog-content">
<cfset prevyear = #url.year# - 1>
<cfset nxtyear = #url.year# + 1>
<cfset twoyear = #url.year# + 2>
Select Year:
<cfif url.year is "2004">
<b>#url.year#</b> <a href="schedule.cfm?Year=#nxtyear#&AuditedBy=#URL.AuditedBy#&Auditor=#url.Auditor#">[ #nxtyear# ]</a> <a href="schedule.cfm?Year=#twoyear#&AuditedBy=#URL.AuditedBy#&Auditor=#url.Auditor#">[ #twoYear# ]</a>
<cfelse>
<a href="schedule.cfm?Year=#prevyear#&AuditedBy=#URL.AuditedBy#&Auditor=#url.Auditor#">[ #prevyear# ]</a> <b>#url.year#</b> <a href="schedule.cfm?Year=#nxtyear#&AuditedBy=#URL.AuditedBy#&Auditor=#url.Auditor#">[ #nxtyear# ]</a>
</cfif>
<br>
<a href="schedule.cfm?Year=#CurYear#&AuditedBy=#URL.AuditedBy#&Auditor=#url.Auditor#">View</a> Current Year
<br><br />

<!--- Total number of active audits --->
<CFQUERY BLOCKFACTOR="100" NAME="Total" Datasource="Corporate">
SELECT Count(*) as Count
FROM AuditSchedule
WHERE (Status = '' OR Status IS NULL)
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
<cfif isDefined("url.auditor")>
	<cfif url.auditor is NOT "All">
	AND (Auditor LIKE '%#URL.Auditor#%'
	OR LeadAuditor LIKE '%#URL.Auditor#%'
    OR AuditorInTraining LIKE '%#URL.Auditor#%')
	</cfif>
</cfif>
<cfif url.auditedby is "AllAccred">
AND (AuditedBy = 'AS' OR AuditedBy = 'Accred')
<cfelse>
	<cfif url.AuditedBy neq "All">
	AND AuditedBy = '#trim(URL.AuditedBy)#'
	</cfif>
</cfif>
</cfquery>

<!--- cancelled --->
<CFQUERY BLOCKFACTOR="100" NAME="TotalCancel" Datasource="Corporate">
SELECT Count(*) as Count
FROM AuditSchedule
WHERE (Status = 'Deleted')
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
<cfif isDefined("url.auditor")>
	<cfif url.auditor is NOT "All">
	AND (Auditor LIKE '%#URL.Auditor#%'
	OR LeadAuditor LIKE '%#URL.Auditor#%'
    OR AuditorInTraining LIKE '%#URL.Auditor#%')
	</cfif>
</cfif>
<cfif url.auditedby is "AllAccred">
AND (AuditedBy = 'AS' OR AuditedBy = 'Accred')
<cfelse>
	<cfif url.AuditedBy neq "All">
	AND AuditedBy = '#trim(URL.AuditedBy)#'
	</cfif>
</cfif>
</cfquery>

<!--- count of audits --->

<!---
<cfoutput>
	<cfset AllTotal = #Total.Count# + #TotalCancel.Count#>
	<b>Total Audits</b>: #AllTotal#<br />
	Active Audits:
	#Total.Count#<br />
	Cancelled Audits: #TotalCancel.Count#<br />
</cfoutput>
--->

</div>
</td>
</tr>
<Tr>
<td align="left" class="blog-content" valign="top" width="50%">
<u>View Audit Schedules</u>:<br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=AS&Auditor=All">Accreditation Services</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=AllAccred&Auditor=All">All Accreditation</a><br>
 - <a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Internal Audit / Corporate Finance</a><br>
 - IQA - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&Auditor=All">All Audits</a><br />
<cflock scope="Session" timeout="5">
	<cfif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "Yes">
	<cfif SESSION.Auth.AccessLevel eq "Admin" OR SESSION.Auth.AccessLevel eq "IQAAuditor" OR SESSION.Auth.AccessLevel eq "SU">
     - IQA - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&Auditor=#SESSION.Auth.Name#">#SESSION.Auth.Name# Audits</a><br />
	</cfif>
	</cfif>
</cflock>
 - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=Medical">Medical</a><br>
 - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=LAB">Laboratory Technical Audit</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=VS&Auditor=All">Verification Services (VS)</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=ULE&Auditor=All">UL Environment (ULE)</a><br>
 - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=WiSE&Auditor=All">WiSE</a><br>
<!--- - <a href="schedule.cfm?Year=#CurYear#&AuditedBy=QRS&Auditor=All">QRS</a><br>--->
 - <a href="schedule_view.cfm">Regional Schedules</a><br><br>
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
<td align="left" class="blog-content" valign="top" width="50%">
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
	OR LeadAuditor LIKE '%#URL.Auditor#%'
    OR AuditorInTraining LIKE '%#URL.Auditor#%')
	</cfif>
</cfif>
<cfif url.auditedby is "AllAccred">
AND (AuditedBy = 'AS' OR AuditedBy = 'Accred')
<cfelse>
	<cfif url.AuditedBy neq "All">
	AND AuditedBy = '#trim(URL.AuditedBy)#'
	</cfif>
</cfif>
ORDER BY ID
</cfquery>

<cfif Total.Recordcount eq 0>
<cfoutput>
<table border="1" width="650" valign="Top" style="border-collapse: collapse;">
<tr>
<td class="blog-content" align="center">
There are no audits scheduled by #URL.AuditedBy# for #URL.Year#.
</td>
</tr></table>
</cfoutput>
<cfelse>

<cfloop index="i" From="1" To="12">
<table border="1" width="650" style="border-collapse: collapse;">
<tr>

<CFQUERY BLOCKFACTOR="100" NAME="Details" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE (Status = 'Deleted' OR Status IS NULL)
AND Month = #i#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
<cfif isDefined("url.auditor")>
	<cfif url.auditor is NOT "All">
	AND (Auditor LIKE '%#URL.Auditor#%'
	OR LeadAuditor LIKE '%#URL.Auditor#%'
    OR AuditorInTraining LIKE '%#URL.Auditor#%')
	</cfif>
</cfif>
<cfif url.auditedby is "AllAccred">
AND audittype2 = 'Accred'
<cfelse>
	<cfif url.AuditedBy neq "All">
	AND AuditedBy = '#trim(URL.AuditedBy)#'
	</cfif>
</cfif>
ORDER BY ID
</cfquery>

<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes">
<cfif Details.Recordcount eq 0>
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

<cfif url.auditedby is "AS"
	or url.auditedby is "QRS"
	or Details.audittype2 is "Accred"
	or Details.auditedby is "Finance"
	or Details.auditedby is "LAB"
	or Details.AuditedBy is "WISE" AND Details.AuditType is "Accred">
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

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->