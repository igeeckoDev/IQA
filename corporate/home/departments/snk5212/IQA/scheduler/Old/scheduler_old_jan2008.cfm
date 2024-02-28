<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" NAME="baseline" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM Baseline
 WHERE YEAR_=#curyear#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfif CurMonth is 12>
	<cfset NextMonth = 1>
	<cfset Year = #CurYear# + 1>
<cfelse>
	<cfset NextMonth = #CurMonth# + 1>
	<cfset Year = #CurYear#>
</cfif>

<cfset DayofMonth = #Dateformat(now(), 'dd')#>

<cfif baseline.baseline eq 0>
<cfelse>
<cfif DayofMonth is 01>

<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.AuditArea,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.Month, AuditSchedule.Area, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.LeadAuditor, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2
 FROM AuditSchedule, IQAtblOffices
 WHERE AuditSchedule.Status is null AND  AuditSchedule.Month = #NextMonth#
 AND AuditSchedule.YEAR_='#Year#' AND  AuditSchedule.AuditType <> 'TPTDP'
 AND  AuditSchedule.AuditedBy = 'IQA'
 AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
 AND  AuditSchedule.Approved = 'Yes'
 ORDER BY AuditSchedule.ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfmail 
	query="SelectAudits"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#Email#, William.R.Carney@ul.com, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#, Jola.Wroblewska@ul.com, Ronald.C.Vaickauski@ul.com"
	cc= "global.internalquality@ul.com"
	bcc= "Christopher.j.nicastro@ul.com"
	subject="Audit Notification - #Trim(OfficeName)# (#AuditedBy#)" 
	Mailerid="Reminder">
This is an email reminder to inform you that #Trim(OfficeName)# <cfif Area is ""><cfelse>(#Trim(Area)#)</cfif> is scheduled for a <cfif AuditType is "Quality System">Quality System audit<cfelseif AuditType is "Technical Assessment">Technical Assessment audit<cfelseif AuditType is "Quality System,Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditType is "Quality System, Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditedBy is "AS">audit by #Trim(AuditType)#</cfif> in #MonthAsString(Month)#. The audit number is #year#-#id#.

<cfif AuditedBy is NOT "AS">No action is required on your part at this time unless you foresee a scheduling conflict. The assigned auditor will contact you with specific scope information and to arrange the dates of the audit. The auditor assigned to this audit is #LeadAuditor# should you have any further questions.<cfelse>Please contact Accreditation Services with any questions or concerns.</cfif>
</cfmail>

<cfoutput query="selectaudits">
This is an email reminder to inform you that #Trim(OfficeName)# <cfif AuditArea is ""><cfelse>(#Trim(AuditArea)#)</cfif> is scheduled for a <cfif AuditType is "Quality System">Quality System audit<cfelseif AuditType is "Technical Assessment">Technical Assessment audit<cfelseif AuditType is "Quality System,Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditType is "Quality System, Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditedBy is "AS">audit by #Trim(AuditType)#</cfif> in #MonthAsString(Month)#. The audit number is #year#-#id#.

<cfif AuditedBy is NOT "AS">No action is required on your part at this time unless you foresee a scheduling conflict. The assigned auditor will contact you with specific scope information and to arrange the dates of the audit. The auditor assigned to this audit is #LeadAuditor# should you have any further questions.<cfelse>Please contact Accreditation Services with any questions or concerns.</cfif>
<br><hr><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="SelectAuditsFS" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.AuditArea,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.Month, AuditSchedule.Area, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.LeadAuditor, AuditSchedule.Area, FUSLocations.Location
 FROM AuditSchedule, FUSLocations
 WHERE AuditSchedule.Status is null AND  AuditSchedule.Month = #NextMonth#
 AND AuditSchedule.YEAR_='#Year#' AND  AuditSchedule.AuditType <> 'TPTDP'
 AND  AuditSchedule.AuditedBy = 'IQA'
 AND  AuditSchedule.OfficeName = FUSLocations.Location
 AND  AuditSchedule.Approved = 'Yes'
 ORDER BY AuditSchedule.ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfmail 
	query="SelectAuditsFS"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#Email#, Jola.Wroblewska@ul.com, Ronald.C.Vaickauski@ul.com"
	cc= "global.internalquality@ul.com"
	bcc= "Christopher.j.nicastro@ul.com"
	subject="#auditedby# Field Service Audit Notification - #Trim(OfficeName)#, #Trim(Area)#" 
	Mailerid="Reminder">
This is an email reminder to inform you that #Trim(OfficeName)# - #Area# is scheduled for a #Trim(AuditArea)# audit by #AuditedBy# in #MonthAsString(Month)#. 

No action is required on your part at this time unless you foresee a scheduling conflict. The assigned auditor will contact you with specific scope information and to arrange the dates of the audit. The auditor assigned to this audit is #LeadAuditor# should you have any further questions. The audit number is #year#-#id#.
</cfmail>

<cfoutput query="SelectAuditsFS">
This is an email reminder to inform you that #Trim(OfficeName)# - #Area# is scheduled for a #Trim(AuditArea)# audit by #AuditedBy# in #MonthAsString(Month)#. 

No action is required on your part at this time unless you foresee a scheduling conflict. The assigned auditor will contact you with specific scope information and to arrange the dates of the audit. The auditor assigned to this audit is #LeadAuditor# should you have any further questions. The audit number is #year#-#id#.
<br><hr><br>
</cfoutput>
<cfelse>
</cfif>
</cfif>

<cfset Year = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #Year# + 1>
<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>

<cfif Month is 2 or Month is 5 or Month is 8 or Month is 11>
	<cfif Day is 01>

<cfif month IS 2>
	<cfset n = 4>
	<cfset reportyear = #year# - 1>
<cfelseif month IS 5>
	<cfset n = 1>
	<cfset reportyear = #year#>
<cfelseif month IS 8>
	<cfset n = 2>
	<cfset reportyear = #year#>
<cfelseif month IS 11>
	<cfset n = 3>
	<cfset reportyear = #year#>
</cfif>

<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#reportyear# AND  Quarter = #n#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfmail 
	to="William.R.Carney@ul.com, James.E.Feth@ul.com, Michael.L.Jorgenson@ul.com, Raymond.E.Burg@ul.com, Robert.E.Bernd@ul.com, Jodine.E.Hepner@ul.com" 
	from="Internal.Quality_Audits@ul.com"
	bcc="Christopher.J.Nicastro@ul.com, global.internalquality@ul.com"
	subject="Third Party Report Card - Quarter #Quarter#, #Year#"
	query="RC">Please view the Third Party Report Card for Quarter #quarter# of #year#:

http://#CGI.Server_Name#/departments/snk5212/iqa/report/report.cfm?year=#curyear#

Comments:
<cfset S1 = #ReplaceNoCase(Comments,"<br>",chr(13), "ALL")#>
#S1#
</cfmail>
	</cfif>
<cfelse>
</cfif>
