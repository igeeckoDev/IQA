<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<cfoutput>#URL.Year#</cfoutput> Report Attachments - IQA Audits">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<u>Year</u>: <a href="ReportAttachments_View.cfm?year=2014">2014</a> :: <a href="ReportAttachments_View.cfm?year=2015">2015</a><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Output" Datasource="Corporate">
SELECT ReportAttach.ID, ReportAttach.Year_, ReportAttach.FileName, ReportAttach.FileLabel, ReportAttach.rID, AuditSchedule.AuditType2, AuditSchedule.Area, AuditSchedule.OfficeName,
AuditSchedule.Month
FROM ReportAttach, AuditSchedule
WHERE ReportAttach.Year_ = #URL.Year#
AND ReportAttach.Year_ = AuditSchedule.Year_
AND ReportAttach.ID = AuditSchedule.ID
AND AuditSchedule.AuditedBy = 'IQA'
ORDER BY AuditSchedule.Month, ReportAttach.ID, ReportAttach.FileName
</cfquery>

<cfset IDHolder = "">
<cfset MonthHolder = "">

<cfoutput query="Output">
<cfif MonthHolder IS NOT Month>
<cfIf MonthHolder is NOT ""><br></cfif>
<b><u>#MonthAsString(Month)#</u></b><br>
</cfif>

<cfif IDHolder IS NOT ID>
<cfIf IDHolder is NOT ""><br></cfif>
<b><u>#Year_#-#ID#-IQA</u></b><br>
#AuditType2#<br>
#Area#<br>
#OfficeName#<br><br>
</cfif>

<a href="../Reports/#FileName#">#FileName#</a> [rowID = #rID#]<br>

<cfset IDHolder = ID>
<cfset MonthHolder = Month>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->