<CFQUERY blockfactor="100" Datasource="Corporate" Name="SelectAudit">
SELECT AuditSchedule.ID, AuditSchedule.Year, AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.AuditType, AuditSchedule.Report, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.Month, AuditSchedule.Email as Contact, AuditSchedule.Desk, ExternalLocation.ExternalLocation, ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.Address1, ExternalLocation.Address2, ExternalLocation.Address3, ExternalLocation.Address4, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.Certificate, ExternalLocation.Cert, ExternalLocation.FileNumber, AuditorList.Auditor, AuditorList.Phone, AuditorList.Email
FROM AuditSchedule, ExternalLocation, AuditorList

WHERE AuditSchedule.ID = #URL.ID#
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
AND AuditSchedule.LeadAuditor = AuditorList.Auditor
</CFQUERY>

<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<CFQUERY Datasource="Corporate" Name="EnterFollowUp">
INSERT INTO FollowUp(ID, Year)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">)
</CFQUERY>

<CFQUERY Datasource="Corporate" Name="EnterFollowUp2">
UPDATE FollowUp
SET

Type='#SelectAudit.Type#',
Name='#Form.Name#',
ContactEmail='#Form.ContactEmail#',
Address1='#Form.Address1#',
Address2='#Form.Address2#',
Address3='#Form.Address3#',
Address4='#Form.Address4#',
AuditorEmail='#Form.AuditorEmail#',
Phone='#Form.Phone#',
<cfif selectaudit.billable is "Yes">
ProjectNumber='#Form.ProjectNumber#',
</cfif>
FileNumber='#Form.FileNumber#',
cc='Internal.Quality_Audits@ul.com, James.E.Feth@ul.com<cfif SelectAudit.Type is "CAP-EA" OR SelectAudit.Type is "CAP-EA/CAP-AA">, #Form.CAPEmail#, Sandra.B.Brown@ul.com</cfif><cfif SelectAudit.Cert is "Yes" OR SelectAudit.Billable is "Yes">, Raye.Silva@ul.com</cfif><cfif form.cc is NOT "">, #form.cc#</cfif>',
Auditor='#SelectAudit.LeadAuditor#',
<cfif SelectAudit.Type is "CAP-EA/CAP-AA" or SelectAudit.Type is "CAP-EA">
CAPName='#Form.CAPName#',
CAPEmail='#Form.CAPEmail#',
CAPLocation='#Form.CAPLocation#',
</cfif>
DateSent='#CurDate#'

WHERE ID = #URL.ID# AND YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY Datasource="Corporate" Name="FollowUpEntered">
UPDATE AuditSchedule
SET

Followup = 'Entered',
FollowUpLetterDate = '#CurDate#'

WHERE ID = #URL.ID# AND YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY Datasource="Corporate" Name="KCInfo">
UPDATE ExternalLocation
SET

Address1='#Form.Address1# ',
<cfif IsDefined("Form.Address2")>
Address2='#Form.Address2# ',
<cfelse>
</cfif>
<cfif IsDefined("Form.Address3")>
Address3='#Form.Address3# ',
<cfelse>
</cfif>
<cfif IsDefined("Form.Address4")>
Address4='#Form.Address4# ',
<cfelse>
</cfif>
KC='#Form.Name#',
KCEmail='#Form.ContactEmail#'

WHERE ExternalLocation = '#SelectAudit.ExternalLocation#'
</cfquery>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="SelectAudit">
SELECT AuditSchedule.ID, AuditSchedule.Year, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate,

ExternalLocation.ExternalLocation, ExternalLocation.Cert, ExternalLocation.Billable,

FollowUp.ID, FollowUp.Year, FollowUp.Type, FollowUp.Name, FollowUp.ContactEmail, FollowUp.Address1, FollowUp.Address2, FollowUp.Address3, FollowUp.Address4, FollowUp.AuditorEmail, FollowUp.Phone, FollowUp.FileNumber, FollowUp.cc, FollowUp.DateSent, FollowUp.Auditor, FollowUp.CAPName, FollowUp.CAPEmail, FollowUp.CAPLocation, FollowUp.ProjectNumber

FROM AuditSchedule, FollowUp, ExternalLocation

WHERE AuditSchedule.ID = #URL.ID#
AND AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
AND AuditSchedule.ID = FollowUp.ID 
AND AuditSchedule.Year = FollowUp.Year
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Confirmation - Follow Up Letter">
<cfinclude template="SOP.cfm">

<!--- / --->

<!--- count Findings and Observations from Audit Report --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT * FROM TPREPORT
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> and id=#url.id#
</cfquery>

<cfoutput query="View">
<cfset CARList = CAR1 & ", " & CAR2 & ", " & CAR3 & ", " & CAR4 & ", " & CAR5 & ", " & CAR6 & ", " & CAR7 & ", " & CAR8 & ", " & CAR9 & ", " & CAR10 & ", " & CAR11 & ", " & CAR12 & ", " & CAR13 & ", " & CAR14 & ", " & CAR15 & ", " & CAR16 & ", " & CAR17 & ", " & CAR18 & ", " & CAR19 & ", " & CAR20 & ", " & CAR21 & ", " & CAR22 & ", " & CAR23 & ", " & CAR24 & ", " & CAR25 & ", " & CAROther>

<cfset dump = #replace(CARList, "N/A, ", "", "All")#>
<cfset dump1 = #replace(dump, ", N/A", "", "All")#>
<cfset dump2 = #replace(dump1, "N/A", "", "All")#>
<cfset dump3 = #replace(dump2, "NA, ", "", "All")#>
<cfset dump4 = #replace(dump3, ", NA", "", "All")#>
<cfset dump5 = #replace(dump4, "NA", "", "All")#>
</cfoutput>
<!--- /// --->

<cfoutput query="SelectAudit">
	<cfinclude template="followup_template4.cfm">
</cfoutput>	

<cfmail to="#ContactEmail#" from="Internal.Quality_Audits@ul.com" cc="#AuditorEmail#, #cc#" subject="General Assessment of Laboratory Operations under UL's Data Acceptance Program" query="SelectAudit">
	<cfinclude template="followup_template3.cfm">
</cfmail>
	  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->