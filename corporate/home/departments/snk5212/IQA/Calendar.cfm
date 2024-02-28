<cfparam name="nextYear" default="#curYear#+1">

<!--- Determine what date to show, and last viewed Date if applicable.--->
<cfparam name="CurntDate" default="#now()#">
<cfif isdefined("MonthChange")>
	<cfif isdefined("JumpMonth")>
		<cfset curntdate = createodbcdate(dateadd("m", #url.monthchange#, lastdate))>
	<cfelseif isdefined("JumpYear")>
		<cfset curntdate = createodbcdate(dateadd("yyyy", #url.monthchange#, lastdate))>
	<cfelse>
		<cfif monthchange is 'forward'>
			<cfset curntdate = createodbcdate(dateadd("m", 1, lastdate))>
		<cfelse>
			<cfset curntdate = createodbcdate(dateadd("m", -1, lastdate))>
		</cfif>
	</cfif>
</cfif>
<cfparam name="YearSet" default="#year(CurntDate)#">
<cfparam name="MonthSet" default="#month(CurntDate)#">
<cfparam name="url.year" default="#YearSet#">
<cfset prevmonth = createodbcdate(dateadd("m", -1, curntdate))>
<cfparam name="Type" default="All">
<cfparam name="Type2" default="">

<cfset NextYear = #YearSet# + 1>

<!--- Create the date variables to search the Database by. --->
<cfset monthstart = createdatetime(#yearset#, #monthset#, 1, 0, 0, 0)>
<cfset monthend = createdatetime(#yearset#, #monthset#, #daysinmonth(monthstart)#, 23, 59, 59)>

<!--- regional search of audit schedule --->
<cfif url.type is "SubRegion">
	<cfquery Datasource="Corporate" name="SearchResults">
	SELECT IQAtblOffices.SubRegion, AuditSchedule.*, AuditSchedule.Year_ as Year
	FROM AuditSchedule, IQAtblOffices
	WHERE AuditSchedule.OfficeName = IQAtblOffices.OfficeName
	AND AuditSchedule.Month = #MonthSet#
	AND IQAtblOffices.SubRegion = '#URL.Type2#'
	AND AuditSchedule.StartDate IS NOT Null
	AND AuditSchedule.Status IS Null
	AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')
	AND AuditSchedule.Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.Approved = 'Yes'
	ORDER BY AuditSchedule.StartDate
	</cfquery>

	<cfquery Datasource="Corporate" name="SearchResults2">
	SELECT IQAtblOffices.SubRegion, AuditSchedule.*, AuditSchedule.Year_ as Year
	FROM AuditSchedule, IQAtblOffices
	WHERE AuditSchedule.OfficeName = IQAtblOffices.OfficeName
	AND AuditSchedule.Month = #MonthSet#
	AND IQAtblOffices.SubRegion = '#URL.Type2#'
	AND AuditSchedule.StartDate IS Null
	AND AuditSchedule.Status IS Null
	AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')
	AND AuditSchedule.Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.Approved = 'Yes'
	ORDER BY AuditSchedule.ID, AuditSchedule.StartDate
	</cfquery>

	<cfquery Datasource="Corporate" name="SearchResults3">
	SELECT IQAtblOffices.SubRegion, AuditSchedule.*, AuditSchedule.Year_ as Year
	FROM AuditSchedule, IQAtblOffices
	WHERE AuditSchedule.OfficeName = IQAtblOffices.OfficeName
	AND AuditSchedule.Month = #MonthSet#
	AND IQAtblOffices.SubRegion = '#URL.Type2#'
	AND AuditSchedule.Status IS Null
	AND AuditSchedule.RescheduleNextYear = 'Yes'
	AND AuditSchedule.Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.Approved = 'Yes'
	ORDER BY AuditSchedule.ID, AuditSchedule.StartDate
	</cfquery>

	<cfquery Datasource="Corporate" name="SearchResults4">
	SELECT IQAtblOffices.SubRegion, AuditSchedule.*, AuditSchedule.Year_ as Year
	FROM AuditSchedule, IQAtblOffices
	WHERE AuditSchedule.OfficeName = IQAtblOffices.OfficeName
	AND AuditSchedule.Month = #MonthSet#
	AND IQAtblOffices.SubRegion = '#URL.Type2#'
	AND AuditSchedule.Status = 'Deleted'
	AND AuditSchedule.Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.Approved = 'Yes'
	ORDER BY AuditSchedule.ID, AuditSchedule.StartDate
	</cfquery>
<cfelse>

<cfquery Datasource="Corporate" name="SearchResults">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, auditarea, audittype, auditedby, audittype2, area, RescheduleNextYear, reschedulestatus, status, externallocation, leadauditor, auditor, ascontact, sitecontact, EmailName, Desk
 FROM AuditSchedule
 WHERE (Month = #MonthSet# OR (EndDate >= #MonthStart#  AND  EndDate <= #MonthEnd#))
<cfif url.type is "Accred">
	<cfif url.type2 is "AS">
	 AND  AuditedBy = 'AS'
	<cfelseif url.type2 is "Non">
	 AND  AuditType2 = 'Accred'  AND  Auditedby <> 'AS'
	<cfelseif url.type2 is "All">
	 AND  AuditType2 = 'Accred'
	</cfif>
<cfelseif url.type is "LAB">
 AND  Auditedby = 'LAB'
<cfelseif url.type is "Medical">
 AND  Auditedby = 'Medical'
<cfelseif url.type is "VS">
 AND  Auditedby = 'VS'
<cfelseif url.type is "ULE">
 AND  Auditedby = 'ULE'
<cfelseif url.type is "UL Environment">
 AND  Auditedby = 'UL Environment'
<cfelseif url.type is "WiSE">
 AND  AuditedBy = 'WiSE'
<cfelseif url.type is "TP">
 AND  AuditType = 'TPTDP'
<cfelseif url.type is "QRS">
 AND  Auditedby = 'QRS'
<cfelseif url.type is "Finance">
 AND  AuditType = 'Finance'
<cfelseif url.type is "auditor">
 AND  (LeadAuditor = '#url.type2#' or Auditor LIKE '%#url.type2#%' or AuditorInTraining LIKE '%#url.type2#%')
<cfelseif url.type is "TPTDP">
 AND  AuditType = 'TPTDP'
<cfelseif URL.type is "FS"  AND url.type2 is "IQA"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services')
 AND  AuditedBy = 'IQA'
<cfelseif URL.type is "FS"  AND url.type2 is "FS"> AND  AuditedBy = 'Field Services'
<cfelseif URL.type is "FS"  AND url.type2 is "All"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services' or auditedby = 'Field Services' or audittype = 'ANSI Witness')
<cfelseif URL.type is "Program">
 AND  Area = '#URL.type2#'
<cfelseif url.type is "IQA">
 AND  AuditedBY = 'IQA'
<cfelseif url.type is "CBTL">
 AND  (AuditType2 = 'Local Function CBTL' or AuditType = 'CBTL')
<cfelseif URL.Type is "Location">
 AND  OfficeName LIKE '%#URL.type2#%'
<cfelseif url.type is "All">
</cfif>
	 AND  StartDate IS NOT NULL
	 AND  Status IS Null
	 AND  (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
	 AND  Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	 AND  Approved = 'Yes'
 ORDER BY StartDate
</cfquery>

<cfquery Datasource="Corporate" name="SearchResults2">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, auditarea, audittype, auditedby, audittype2, area, RescheduleNextYear, reschedulestatus, status, externallocation, leadauditor, auditor, ascontact, sitecontact, EmailName
 FROM AuditSchedule
 WHERE Month = #MonthSet#
<cfif url.type is "Accred">
	<cfif url.type2 is "AS">
	 AND  AuditedBy = 'AS'
	<cfelseif url.type2 is "Non">
	 AND  AuditType2 = 'Accred'  AND  Auditedby <> 'AS'
	<cfelseif url.type2 is "All">
	 AND  AuditType2 = 'Accred'
	</cfif>
<cfelseif url.type is "LAB">
 AND  Auditedby = 'LAB'
<cfelseif url.type is "Medical">
 AND  Auditedby = 'Medical'
<cfelseif url.type is "VS">
 AND  Auditedby = 'VS'
<cfelseif url.type is "ULE">
 AND  Auditedby = 'ULE'
<cfelseif url.type is "UL Environment">
 AND  Auditedby = 'UL Environment'
<cfelseif url.type is "WiSE">
 AND  AuditedBy = 'WiSE'
<cfelseif url.type is "TP">
 AND  AuditType = 'TPTDP'
<cfelseif url.type is "QRS">
 AND  Auditedby = 'QRS'
<cfelseif url.type is "Finance">
 AND  AuditType = 'Finance'
<cfelseif url.type is "auditor">
 AND  (LeadAuditor = '#url.type2#' or Auditor LIKE '%#url.type2#%' or AuditorInTraining LIKE '%#url.type2#%')
<cfelseif url.type is "TPTDP">
 AND  AuditType = 'TPTDP'
<cfelseif URL.type is "FS"  AND url.type2 is "IQA"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services')
 AND  AuditedBy = 'IQA'
<cfelseif URL.type is "FS"  AND url.type2 is "FS"> AND  AuditedBy = 'Field Services'
<cfelseif URL.type is "FS"  AND url.type2 is "All"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services' or auditedby = 'Field Services' or audittype = 'ANSI Witness')
<cfelseif URL.type is "Program">
 AND  Area = '#URL.type2#'
<cfelseif url.type is "IQA">
 AND  AuditedBY = 'IQA'
<cfelseif url.type is "CBTL">
 AND  (AuditType2 = 'Local Function CBTL' or AuditType = 'CBTL')
<cfelseif URL.Type is "Location">
 AND  OfficeName LIKE '%#URL.type2#%'
<cfelseif url.type is "All">
</cfif>
	 AND StartDate IS Null
	 AND Status IS Null
	 AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
	 AND Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	 AND Approved = 'Yes'
 ORDER BY ID, StartDate
</cfquery>

<cfquery Datasource="Corporate" name="SearchResults3">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, auditarea, audittype, auditedby, audittype2, area, RescheduleNextYear, status, externallocation, leadauditor, auditor, ascontact, sitecontact, EmailName
 FROM AuditSchedule
 WHERE Month = #MonthSet#
<cfif url.type is "Accred">
	<cfif url.type2 is "AS">
	 AND  AuditedBy = 'AS'
	<cfelseif url.type2 is "Non">
	 AND  AuditType2 = 'Accred'  AND  Auditedby <> 'AS'
	<cfelseif url.type2 is "All">
	 AND  AuditType2 = 'Accred'
	</cfif>
<cfelseif url.type is "LAB">
 AND  Auditedby = 'LAB'
<cfelseif url.type is "Medical">
 AND  Auditedby = 'Medical'
<cfelseif url.type is "VS">
 AND  Auditedby = 'VS'
<cfelseif url.type is "ULE">
 AND  Auditedby = 'ULE'
<cfelseif url.type is "UL Environment">
 AND  Auditedby = 'UL Environment'
<cfelseif url.type is "WiSE">
 AND  AuditedBy = 'WiSE'
<cfelseif url.type is "TP">
 AND  AuditType = 'TPTDP'
<cfelseif url.type is "QRS">
 AND  Auditedby = 'QRS'
<cfelseif url.type is "Finance">
 AND  AuditType = 'Finance'
<cfelseif url.type is "auditor">
 AND  (LeadAuditor = '#url.type2#' or Auditor LIKE '%#url.type2#%' or AuditorInTraining LIKE '%#url.type2#%')
<cfelseif url.type is "TPTDP">
 AND  AuditType = 'TPTDP'
<cfelseif URL.type is "FS"  AND url.type2 is "IQA"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services')
 AND  AuditedBy = 'IQA'
<cfelseif URL.type is "FS"  AND url.type2 is "FS"> AND  AuditedBy = 'Field Services'
<cfelseif URL.type is "FS"  AND url.type2 is "All"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services' or auditedby = 'Field Services' or audittype = 'ANSI Witness')
<cfelseif URL.type is "Program">
 AND  Area = '#URL.type2#'
<cfelseif url.type is "IQA">
 AND  AuditedBY = 'IQA'
<cfelseif url.type is "CBTL">
 AND  (AuditType2 = 'Local Function CBTL' or AuditType = 'CBTL')
<cfelseif URL.Type is "Location">
 AND  OfficeName LIKE '%#URL.type2#%'
<cfelseif url.type is "All">
</cfif>
	 AND Status IS Null
	 AND RescheduleNextYEAR='Yes'
	 AND Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	 AND Approved = 'Yes'
 ORDER BY ID, StartDate
</cfquery>

<cfquery Datasource="Corporate" name="SearchResults4">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, auditarea, audittype, auditedby, audittype2, area, RescheduleNextYear, status, externallocation, leadauditor, auditor, ascontact, sitecontact, EmailName
 FROM AuditSchedule
 WHERE Month = #MonthSet#
<cfif url.type is "Accred">
	<cfif url.type2 is "AS">
	 AND  AuditedBy = 'AS'
	<cfelseif url.type2 is "Non">
	 AND  AuditType2 = 'Accred'  AND  Auditedby <> 'AS'
	<cfelseif url.type2 is "All">
	 AND  AuditType2 = 'Accred'
	</cfif>
<cfelseif url.type is "LAB">
 AND  Auditedby = 'LAB'
<cfelseif url.type is "Medical">
 AND  Auditedby = 'Medical'
<cfelseif url.type is "VS">
 AND  Auditedby = 'VS'
<cfelseif url.type is "ULE">
 AND  Auditedby = 'ULE'
<cfelseif url.type is "UL Environment">
 AND  Auditedby = 'UL Environment'
<cfelseif url.type is "WiSE">
 AND  AuditedBy = 'WiSE'
<cfelseif url.type is "TP">
 AND  AuditType = 'TPTDP'
<cfelseif url.type is "QRS">
 AND  Auditedby = 'QRS'
<cfelseif url.type is "Finance">
 AND  AuditType = 'Finance'
<cfelseif url.type is "auditor">
 AND  (LeadAuditor = '#url.type2#' or Auditor LIKE '%#url.type2#%' or AuditorInTraining LIKE '%#url.type2#%')
<cfelseif url.type is "TPTDP">
 AND  AuditType = 'TPTDP'
<cfelseif URL.type is "FS"  AND url.type2 is "IQA"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services')
 AND  AuditedBy = 'IQA'
<cfelseif URL.type is "FS"  AND url.type2 is "FS"> AND  AuditedBy = 'Field Services'
<cfelseif URL.type is "FS"  AND url.type2 is "All"> AND  (AuditType2 = 'Field Services' or OfficeName = 'Field Services' or auditedby = 'Field Services' or audittype = 'ANSI Witness')
<cfelseif URL.type is "Program">
 AND  Area = '#URL.type2#'
<cfelseif url.type is "IQA">
 AND  AuditedBY = 'IQA'
<cfelseif url.type is "CBTL">
 AND  (AuditType2 = 'Local Function CBTL' or AuditType = 'CBTL')
<cfelseif URL.Type is "Location">
 AND  OfficeName LIKE '%#URL.type2#%'
<cfelseif url.type is "All">
</cfif>
	 AND  Status = 'Deleted'
	 AND  Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	 AND  Approved = 'Yes'
 ORDER BY ID, StartDate
</cfquery>
</cfif>

<!---
   Code for calculating the days format to display
--->
<cfset offset = #dayofweek(monthstart)#>
<cfset lastslot = #offset# + #daysinmonth(monthstart)#-1>
<cfset caldays = (#ceiling(lastslot/7)#)*7>
<cfset day = 1>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "Audit Calendar for <cfoutput>#DateFormat(CurntDate,"mmmm, YYYY")#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<CFQUERY DataSource="Corporate" Name="BaseLine">
SELECT * FROM Baseline
WHERE Year_ = #YearSet#
</cfquery>

<cfif BaseLine.BaseLine eq 0>
	<cfoutput>
	<font color="red">#YearSet# <b>IQA</b> Audit Schedule is tentative.</font><br><Br>
	</cfoutput>
</cfif>

<!---<script language="JavaScript" src="webhelp/webhelp.js"></script>

<br>
Audit Calendar Help - <A HREF="javascript:popUp('webhelp/webhelp_calendar.cfm')">[?]</A><br><br>--->

<u>Search Criteria</u>:
<cfoutput>
<b style="text-transform: capitalize;">
<cfif url.type is "IQA">
 - Internal Quality Audits
<cfelseif url.type is "Accred">
	<cfif url.type2 is "AS">
	 	<cfif isDefined("url.web") AND url.web is "Yes">
	  	- Accreditation Services ANSI Web Conferences
	 	</cfif>
	<cfelseif url.type2 is "All">
	- All External Accredtation Audits
	<cfelseif url.type2 is "Non">
	- External Accreditation Audits (Non-AS)
	</cfif>
<cfelseif url.type is "FS" and url.type2 is "IQA">
 - IQA Field Service Audits
<cfelseif url.type is "FS" and url.type2 is "FS">
 - Field Service Regional Audits
<cfelseif url.type is "FS" and url.type2 is "All">
 - All Field Service Audits
<cfelseif url.type is "All" or url.type is "">
 Audits
<cfelseif url.type is "TP">
 - Third Party Test Data Program (TPTDP) Audits
 <cfelseif url.type is "CBTL">
 - CBTL Audits
<cfelseif url.type is "Finance">
 - Corporate Finance Audits
<cfelseif url.type is "LAB">
 - Laboratory Technical Audits
<cfelseif url.type is "VS">
 - Verification Services
<cfelseif url.type is "ULE" OR url.type is "UL Environment">
 - UL Environment
<cfelseif url.type is "WiSE">
 - WiSE
<cfelseif url.type is "QRS">
 - QRS Audits
<cfelseif url.type is "All" or NOT len(url.type)>
 Audits
</cfif>
</b>

<cfif isdefined("URL.Type2") AND url.Type is NOT "Accred">
<b style="text-transform: capitalize;"> - #URL.Type2#</b>
</cfif><br>
<cfset count = #searchresults.recordcount# + #searchresults2.recordcount# + #searchresults3.recordcount#>
Search Returned #count# Audits
<br><br>

<a href="calendar_search.cfm">Select New Search Criteria</a><br>
<a href="Audit_List.cfm?Month=#DateFormat(CurntDate, "m")#&Year=#DateFormat(CurntDate, "yyyy")#&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">Month View - Audit List</a><br>
<a href="Audit_List2.cfm?Month=#DateFormat(CurntDate, "m")#&Year=#DateFormat(CurntDate, "yyyy")#&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">Year View - Audit List</a>
</cfoutput>
<br><br>

Jump to Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="#nextYear#" from="2004">
<cfset j = #i# - #year(CurntDate)#>
		<cfoutput><OPTION VALUE="calendar.cfm?JumpYear=Yes&MonthChange=#j#&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Jump to Month:<br>
<SELECT NAME="MonthJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Month Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="12" from="1">
<cfset j = #i# - #month(CurntDate)#>
		<cfoutput><OPTION VALUE="calendar.cfm?JumpMonth=Yes&MonthChange=#j#&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

	<table border="1" width="800" align="left" style="border-collapse: collapse;">
	<tr align="center">
		<cfoutput>
			<td colspan="1" align="center" class="blog-title">
				<a href="calendar.cfm?MonthChange=Backward&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">&lt;&lt;</a>
			</td>
			<td colspan="5" align="center" class="sched-content"><b>#DateFormat(CurntDate,"MMMM yyyy")#</b><br></td>
			<td class="blog-title">
				<a href="calendar.cfm?MonthChange=Forward&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">&gt;&gt;</a>
			</td>
		</cfoutput>
	</tr>

	<tr>
<td align="center" width="100" class="calendar">Sunday</font></td>
<td align="center" width="100" class="calendar">Monday</font></td>
<td align="center" width="100" class="calendar">Tuesday</font></td>
<td align="center" width="100" class="calendar">Wednesday</font></td>
<td align="center" width="100" class="calendar">Thursday</font></td>
<td align="center" width="100" class="calendar">Friday</font></td>
<td align="center" width="100" class="calendar">Saturday</font></td>
	</tr>

	<tr>
		<cfloop index="ii" from="1" to="#CalDays#">
			<cfif #ii# gte #offset# and #ii# lte #lastslot# >
				<td class="blog-content" valign=top width="100" height="100">
					<cfoutput>
					<cfif day is #datepart("d", now())# and #month(curntdate)# is #month(now())#>
						<b>#Day#</b>
					<cfelse>
						#Day#
					</cfif><br>
					</cfoutput>

<cfif (#ii# mod 7 is 1) or (#ii# mod 7 is 0)>
&nbsp;
<cfelse>
	<cfinclude template="calendar_search_results.cfm">
</cfif>

				</td>
				<cfset day = #day# + 1>
			<cfelse>
				<td width="100">&nbsp;</td>
			</cfif>

			<cfif (#ii# mod 7 is 0)>
			</tr>
			<tr>
			</cfif>
		</cfloop>

	<!--- The last TR is created in the loop above --->
	<td colspan="7"></td>
	</tr>

	<tr>
	<td colspan="7" align="left" class="blog-content">

	<cfif SearchResults2.recordcount gt 0>
	<u>No Dates Scheduled for the Following Audits:</u><br>
	<cfoutput query="SearchResults2">
	<cfif RescheduleNextYear is "" or RescheduleNextYear is "No">
	<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">
	<cfif auditedby is "AS">#auditedby#-#year#-#id#<cfelse>#year#-#id#-#auditedby#</cfif>
	</a>
	<cfif auditedby is "AS">
	    #officename# (#audittype#)
    <cfelseif audittype is "TPTDP">
    	#externallocation#
    <cfelseif audittype2 is "Field Services">
    	#officename#
    <cfelseif audittype2 is "Global Function/Process" or audittype2 is "Corporate" or audittype2 is "MMS - Medical Management Systems" or audittype2 is "Local Function" OR audittype2 is "Local Function FS">
    	#officename# - <cfif Area is "Acquired Facility">#AuditArea#<cfelse>#Area#<cfif Area is "Processes" OR Area is "Laboratories"> - #AuditArea#</cfif></cfif>
    <cfelseif audittype2 is "Program">
    	#officename# - #Area#<cfif Area is "UL Mark - Listing / Classification / Recognition"> - #AuditArea#</cfif>
    <cfelseif audittype2 is "Technical Assessment">
    	#OfficeName# - #auditArea# (Technical Assessment)
    <cfelseif auditedby is "LAB" OR auditedby is "VS" OR auditedby is "WiSE" OR auditedby is "ULE">
    	#OfficeName# - #AuditArea# (#AuditType#)
	<cfelse>
	    #officename#
    </cfif><br>
	</cfif>
	</cfoutput><br>
	</cfif>

	<cfif SearchResults3.recordcount gt 0>
	<u>Audits Rescheduled for <cfoutput>#NextYear#</cfoutput>:</u><br>
	<cfoutput query="SearchResults3">
	<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">
	<cfif auditedby is "AS">#auditedby#-#year#-#id#<cfelse>#year#-#id#-#auditedby#</cfif>
	</a>
	<cfif auditedby is "AS">
	    #officename# (#audittype#)
    <cfelseif audittype is "TPTDP">
    	#externallocation#
    <cfelseif audittype2 is "Field Services">
    	#officename#
    <cfelseif audittype2 is "Global Function/Process" or audittype2 is "Corporate" or audittype2 is "MMS - Medical Management Systems" or audittype2 is "Local Function" OR audittype2 is "Local Function FS">
    	#officename# - <cfif Area is "Acquired Facility">#AuditArea#<cfelse>#Area#<cfif Area is "Processes" OR Area is "Laboratories"> - #AuditArea#</cfif></cfif>
    <cfelseif audittype2 is "Program">
    	#officename# - #Area#<cfif Area is "UL Mark - Listing / Classification / Recognition"> - #AuditArea#</cfif>
	<cfelseif audittype2 is "Technical Assessment">
    	#OfficeName# - #auditArea# (Technical Assessment)
    <cfelseif auditedby is "LAB" OR auditedby is "VS" OR auditedby is "WiSE" OR auditedby is "ULE">
    	#OfficeName# - #AuditArea# (#AuditType#)
	<cfelse>
	    #officename#
    </cfif><br>
	</cfoutput>
	</cfif>

	<cfif SearchResults4.recordcount gt 0>
	<u>Cancelled audits:</u><br>
	<cfoutput query="SearchResults4">
	<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">
	<cfif auditedby is "AS">#auditedby#-#year#-#id#<cfelse>#year#-#id#-#auditedby#</cfif>
	</a>
	<cfif auditedby is "AS">
	   #replace(officename, "!", ", ", "All")#  (#audittype#)
    <cfelseif audittype is "TPTDP">
    	#externallocation#
    <cfelseif audittype2 is "Field Services">
    	#replace(officename, "!", ", ", "All")#
    <cfelseif audittype2 is "Global Function/Process" or audittype2 is "Corporate" or audittype2 is "MMS - Medical Management Systems" or audittype2 is "Local Function" OR audittype2 is "Local Function FS">
    	#replace(officename, "!", ", ", "All")#  - <cfif Area is "Acquired Facility">#AuditArea#<cfelse>#Area#<cfif Area is "Processes" OR Area is "Laboratories"> - #AuditArea#</cfif></cfif>
    <cfelseif audittype2 is "Program">
    	#replace(officename, "!", ", ", "All")#  - #Area#<cfif Area is "UL Mark - Listing / Classification / Recognition"> - #AuditArea#</cfif>
    <cfelseif audittype2 is "Technical Assessment">
    	#replace(officename, "!", ", ", "All")#  - #auditArea# (Technical Assessment)
    <cfelseif auditedby is "LAB" OR auditedby is "VS" OR auditedby is "WiSE" OR auditedby is "ULE">
    	#replace(officename, "!", ", ", "All")#  - #AuditArea# (#AuditType#)
    <cfelse>
    	#replace(officename, "!", ", ", "All")#
    </cfif><br>
	</cfoutput>
	</cfif>

	</font>
	</td>
	</tr>

	</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->