<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitleHeading = "VS Audits">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="SearchResults"> 
SELECT 
	AuditSchedule.YEAR_ as "Year", AuditSchedule.ID, AuditSchedule.Month, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.OfficeName, AuditSchedule.auditarea, AuditSchedule.audittype, AuditSchedule.auditedby, AuditSchedule.audittype2, AuditSchedule.area, AuditSchedule.RescheduleNextYear, AuditSchedule.status
FROM 
	AuditSchedule, IQAtblOffices
WHERE 
	AuditSchedule.Approved = 'Yes'
    AND IQAtblOffices.OfficeName = AuditSchedule.OfficeName
	AND IQAtblOffices.VS = 'Yes'
	AND AuditSchedule.Status IS Null
<!---AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')--->
	AND AuditSchedule.Year_ <= #curYear#
ORDER BY 
	AuditSchedule.Year_, AuditSchedule.Month, AuditSchedule.ID
</cfquery>

<u>Search Criteria</u>:
<b style="text-transform: capitalize;">Verification Services Audits</b><br>

<cfoutput>
Search Returned #searchresults.recordcount# Audits<br><br>
</cfoutput>

<cfset YearHolder = "">
<cfset MonthHolder = ""> 

<cfoutput query="SearchResults">
<cfif YearHolder IS NOT Year>
    <cfIf len(YearHolder)><br></cfif>
    <b>#Year#</b><br><br>
    <cfset MonthHolder = "">
</cfif>

<cfif MonthHolder IS NOT Month>
<cfIf len(MonthHolder)><br></cfif>
<u>#MonthAsString(Month)#</u><br> 
</cfif>

<cfset CompareDate = Compare(StartDate, EndDate)>
<cfset Start = #StartDate#>
<cfif audittype2 is NOT "Global Function/Process">
	<cfset End = #EndDate#>
<cfelse>
	<cfset End = #StartDate#>
</cfif>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>

<cfif EndDate is NOT "">
<cfif audittype2 is NOT "Global Function/Process">
	<cfset Compare = DateCompare(StartDate, EndDate)>
<cfelse>
	<cfset Compare = DateCompare(StartDate, StartDate)>
</cfif>
</cfif>

<a href="auditdetails.cfm?id=#id#&year=#year#">
<cfif auditedby is "AS">
#auditedby#-#year#-#id#
<cfelse>
#year#-#id#-#auditedby#
</cfif></a>

<!---<a href="auditdetails.cfm?year=#year#&id=#id#">
<cfif auditedby is "AS">#auditedby#-#year#-#id#<cfelse>#year#-#id#-#auditedby#</cfif></a>--->
 - 
	<cfif audittype is "TPTDP">
		#externallocation# 
	<cfelse>
		#officename# 
		<cfif auditedby is "AS" or auditedby is "QRS" or audittype2 is "Accred">
			(#trim(AuditType)#)
		<cfelseif auditedby is NOT "Finance" AND auditedby is NOT "Field Services">
			<cfif AuditType2 is "Field Services">
				[Inspection Center]
			<cfelse>
				<cfif len(area)>
					[#trim(Area)#<cfif Area is "UL Mark - Listing / Classification / Recognition"> - #AuditArea#</cfif>]
				<cfelse>
					[#trim(AuditArea)#]
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<br>
<cfset MonthHolder = Month>
<cfset YearHolder = Year>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->