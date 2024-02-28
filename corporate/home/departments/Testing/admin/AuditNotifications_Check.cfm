<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Notifications - Check">
<cfset subTitle2 = "This query will display next month's Audit Notifications - IF the schedule has been approved!">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfif CurMonth is 12>
	<cfset NextMonth = 1>
	<cfset Year = #CurYear# + 1>
<cfelse>
	<cfset NextMonth = #CurMonth# + 1>
	<cfset Year = #CurYear#>
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate"> 
SELECT 
	AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditArea,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.Month, AuditSchedule.AuditArea, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.LeadAuditor, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2

FROM 
	AuditSchedule, IQAtblOffices

WHERE 
	AuditSchedule.Status is null 
AND AuditSchedule.Month = #NextMonth#
AND AuditSchedule.YEAR_ = #Year# 
AND AuditSchedule.AuditType <> 'TPTDP'
AND (AuditSchedule.AuditedBy = 'IQA' OR AuditSchedule.AuditedBy = 'AS')
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
AND AuditSchedule.Approved = 'Yes'

ORDER BY 
	AuditSchedule.ID
</CFQUERY>

<cfoutput query="selectaudits">
#Year#-#ID#<br />
#OfficeName#<br />
#AuditArea#<br />
To: #Email#, #Email2#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#
<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->