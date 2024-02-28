<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "View Regional Audit Schedules">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="Region"> 
SELECT 
	* 
FROM 
	IQARegion, IQASubRegion
WHERE 
	IQASubRegion.SubRegion <> 'None'
    AND IQARegion.Region <> 'Verification Services'
	AND IQARegion.Region = IQASubRegion.Region
	AND (IQARegion.Region <> 'Global' AND IQARegion.Region <> 'Corporate')
ORDER BY 
	IQARegion.Region, IQASubRegion.SubRegion
</CFQUERY>

<b>Non-Regional Schedules</b><br>
<cfoutput>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=AS&Auditor=All">Accreditation Services Audit Schedule</a> (ANSI / OSHA / SCC, Cerfication Related)<br>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=AllAccred&Auditor=All">Accreditation Audit Schedule</a> (All Accreditation Audits)<br>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=IQA&Auditor=All">Corporate IQA Audit Schedule</a><br>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=LAB&Auditor=All">Laboratory Technical Audit Schedule</a><br>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=WiSE&Auditor=All">WiSE Audit Schedule</a><br>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=VS&Auditor=All">Verification Services (VS) Audit Schedule</a><br>
&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=ULE&Auditor=All">UL Environment (ULE) Audit Schedule</a><br>
&nbsp;&nbsp; - <a href="http://intranet.ul.com/en/Tools/DeptsServs/GlobalFinance/Lists/Internal Audit Schedule/calendar.aspx">Internal Audit / Corporate Finance</a><br><br>
</cfoutput>

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset RegHolder=""> 

<CFOUTPUT Query="Region"> 
	<cfif RegHolder IS NOT Region> 
		<cfIf RegHolder is NOT ""><br></cfif>
	<b>#Region#</b><br> 
	</cfif>

<cfif SubRegion is "VS Labs">
	<cfset varSubRegion = "VS">
<cfelse>
	<cfset varSubRegion = #SubRegion#>
</cfif>

&nbsp;&nbsp; - <a href="Schedule.cfm?Year=#CurYear#&AuditedBy=#varSubRegion#&Auditor=All">#varSubRegion#</a><br>
<cfset RegHolder = Region> 
</CFOUTPUT>
<br><br>
					
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->