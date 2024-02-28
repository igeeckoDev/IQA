<cfoutput>
<a href="Audit_List.cfm?MonthChange=Backward&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">[<< Previous Month]</a>
::
<a href="Audit_List.cfm?MonthChange=Forward&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">[Next Month >>]</a>
</cfoutput>
<br><br>

Jump to Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="2015" from="2004">
<cfset j = #i# - #year(CurntDate)#>
		<cfoutput><OPTION VALUE="audit_list.cfm?JumpYear=Yes&MonthChange=#j#&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Jump to Month:<br>
<SELECT NAME="MonthJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Month Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="12" from="1">
<cfset j = #i# - #month(CurntDate)#>
		<cfoutput><OPTION VALUE="audit_list.cfm?JumpMonth=Yes&MonthChange=#j#&LastDate=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<cfif url.type is "SubRegion">
<!---
<cfquery Datasource="Corporate" name="SearchResults">
SELECT a.*,a.year_ as year FROM SubRegion a
WHERE Month = #MonthSet#
AND SubRegion = '#URL.Type2#'
AND Status IS Null
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
ORDER BY Month, ID
</cfquery>
--->

<cfquery Datasource="Corporate" name="SearchResults">
SELECT IQAtblOffices.SubRegion, AuditSchedule.*, AuditSchedule.Year_ as Year
FROM AuditSchedule, IQAtblOffices
WHERE AuditSchedule.OfficeName = IQAtblOffices.OfficeName
AND AuditSchedule.Month = #MonthSet#
AND IQAtblOffices.SubRegion = '#URL.Type2#'
AND (AuditSchedule.Status IS Null OR AuditSchedule.Status = 'Deleted')
<!---AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')--->
AND AuditSchedule.Year_ = <cfqueryparam value="#url.year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.Approved = 'Yes'
ORDER BY AuditSchedule.Month, AuditSchedule.ID
</cfquery>

<cfelse>

<cfquery Datasource="Corporate" name="SearchResults">
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, auditarea, audittype, auditedby, audittype2, area, RescheduleNextYear, reschedulestatus, status, externallocation, leadauditor, auditor, ascontact, sitecontact, EmailName
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
<cfelseif url.type is "VS">
 AND  AuditedBy = 'VS'
<cfelseif url.type is "ULE">
 AND  Auditedby = 'ULE'
<cfelseif url.type is "WiSE">
 AND  AuditedBy = 'WiSE'
<cfelseif url.type is "TP">
 AND  AuditType = 'TPTDP'
<cfelseif url.type is "QRS">
 AND  Auditedby = 'QRS'
<cfelseif url.type is "Finance">
 AND  AuditType = 'Finance'
<cfelseif url.type is "auditor">
 AND  (LeadAuditor = '#url.type2#' or Auditor = '#url.type2#' or AuditorInTraining LIKE '%#url.type2#%')
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
	AND (AuditSchedule.Status IS Null OR AuditSchedule.Status = 'Deleted')
	 AND  (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
	 AND  Year_ = <cfqueryparam value="#YearSet#" cfsqltype="cf_sql_integer">
	 AND  Approved = 'Yes'
 ORDER BY AuditType, ID
</cfquery>
</cfif>

<u>Search Criteria</u>:
<cfoutput>
<b style="text-transform: capitalize;">
#URL.Type#
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
 - Verification Services Audits
<cfelseif url.type is "ULE">
 - UL Environment
<cfelseif url.type is "WiSE">
 - WiSE Audits
<cfelseif url.type is "QRS">
 - QRS Audits
<cfelseif url.type is "All" or NOT len(url.type)>
 Audits
</cfif>
</b>

<cfif isdefined("URL.Type2")>
<b style="text-transform: capitalize;"> - #URL.Type2#</b>
</cfif><br>
Search Returned #searchresults.recordcount# Audits<br><br>

<a href="calendar.cfm?View=#DateFormat(CurntDate, "mm/dd/yyyy")#&Action=ShowCalendar&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>">Calendar View</a>
<br>
<a href="audit_list2.cfm?&type=#URL.TYPE#<cfif isdefined("URL.Type2")>&type2=#URL.TYPE2#</cfif>&year=#yearset#">Year View - Audit List</a>
<br><br>
</cfoutput>

<cfif url.type is "FS" and url.type2 is "FS">
    <CFQUERY BLOCKFACTOR="100" name="FS" Datasource="Corporate">
    SELECT ID, Year_ AS "Year", File_ AS "File" FROM FSPlan
    WHERE Year_ = <cfqueryparam value="#curyear#" cfsqltype="cf_sql_integer">
    </CFQUERY>

	<cfif FS.File is NOT "">
        <cfoutput query="FS">
        :: <a href="../FSPlan/#File#">View</a> Field Service #curyear# Plan<br><br>
        </cfoutput>
    </cfif>
</cfif>

<cfset TypeHolder="">

<cfoutput query="SearchResults">
<cfif TypeHolder IS NOT AuditType>
<cfIf len(TypeHolder)><br></cfif>
<b><u><cfif AuditedBy is "AS">AS - </cfif>#AuditType#</u></b><br>
</cfif>

<cfset EndDateMonth = dateformat(EndDate, "m")>
<cfif EndDateMonth gt Month>
 *
</cfif>

<!---
<style type="text/css">
  div.transparent {
    filter:alpha(opacity=100);
    background-color: f2f2f2;
    display:none;
    width:250;
    height:200;
    position:absolute;
    color: black;
    border: 1 black solid;
}
</style>
<script>
    /* this function shows the pop-up when
     user moves the mouse over the link */
    function Show(id)
    {
        /* get the mouse left position */
        x = event.clientX + document.body.scrollLeft;
        /* get the mouse top position  */
        y = event.clientY + document.body.scrollTop + 35;
        /* display the pop-up */
        document.getElementById(id).style.display="block";
        /* set the pop-up's left */
        document.getElementById(id).style.left = x;
        /* set the pop-up's top */
        document.getElementById(id).style.top = y;
    }
    /* this function hides the pop-up when
     user moves the mouse out of the link */
    function Hide(id)
    {
        /* hide the pop-up */
        document.getElementById(id).style.display="none";
    }
</script>
--->

<a href="auditdetails.cfm?id=#id#&year=#year#">
<cfif auditedby is "AS">
#auditedby#-#year#-#id#
<cfelse>
#year#-#id#-#auditedby#
</cfif></a>

 -
	<cfif audittype is "TPTDP">
		#externallocation#
	<cfelse>
		#replace(officename, "!", ", ", "All")#
		<cfif auditedby is "AS" or auditedby is "QRS" or audittype2 is "Accred">
			(#trim(AuditType)#)
		<cfelseif auditedby is NOT "Finance" AND auditedby is NOT "Field Services">
			<cfif AuditType2 is "Field Services">
				[Inspection Center]
			<cfelse>
				<cfif len(area)>
					<cfif Area is "Acquired Facility">
                    	[#trim(AuditArea)#]
					<cfelse>
                    	[#trim(Area)#<cfif Area is "UL Mark - Listing / Classification / Recognition"
							OR Area is "Processes"
							OR Area is "Laboratories">
								 - #AuditArea#
					</cfif>]
					</cfif>
				<cfelseif auditedby eq "WiSE">
                	[#trim(AuditArea)#] - #AuditType2#
				<cfelse>
					[#trim(AuditArea)#]
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<br>
<cfset TypeHolder = AuditType>
</cfoutput>