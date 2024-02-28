<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" name="Car" Datasource="Corporate">
SELECT * FROM AuditSchedule, TPReport
WHERE AuditSchedule.ID = #URL.ID#
AND AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND TPReport.ID = #URL.ID#
AND TPReport.year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
			
<cfif Car.Ontime is "">			  
<CFQUERY BLOCKFACTOR="100" name="AddReport" Datasource="Corporate">
UPDATE TPReport
SET

OnTime='#Form.Response#'
<cfif Form.Response is "Yes">
<cfelse>
, Comments='#Form.Comments#'
</cfif>

WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
</cfif>

<cfQUERY Datasource="Corporate" Name="Check">
SELECT * FROM FollowUp
WHERE ID = #URL.ID# and YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="SelectAudit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.AuditType, AuditSchedule.Report, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.Month, AuditSchedule.Email as Contact, AuditSchedule.Desk, ExternalLocation.ExternalLocation, ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.Address1, ExternalLocation.Address2, ExternalLocation.Address3, ExternalLocation.Address4, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.Certificate, ExternalLocation.Cert, ExternalLocation.FileNumber, AuditorList.Auditor, AuditorList.Phone, AuditorList.Email
 FROM AuditSchedule, ExternalLocation, AuditorList
 WHERE AuditSchedule.ID = #URL.ID#
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
 AND  AuditSchedule.LeadAuditor = AuditorList.Auditor
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="CAPCoord">
SELECT * FROM CAPCoord
ORDER BY Location
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Send Follow Up Letter - Details">
<cfinclude template="SOP.cfm">

<!--- / --->

<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="date.js"></script>
				  
<cfif SelectAudit.RecordCount is 0>
<cfoutput>		
<br>
This is not a valid audit.<br><br>
</cfoutput>
<cfelseif Check.RecordCount is 1>
<cfoutput>
The Follow Up Letter for #URL.Year#-#URL.ID# has already been sent.<br><br>
<a href="followup_view.cfm?year=#url.year#&id=#url.id#">
View</a> Follow Up Letter
</cfoutput>
<cfelseif SelectAudit.LeadAuditor is "" or SelectAudit.LeadAuditor is "- None -">
<cfoutput>
<br>
There is no Lead Auditor selected.<br><br>
Please <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">go back</a> and approve the audit and follow any necessary steps before submitting the Follow Up Letter.
</cfoutput>
<cfelseif SelectAudit.Approved is "No">
<cfoutput>		
<br>
This Audit is not yet approved.<br><br>
Please <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">go back</a> and approve the audit and follow any necessary steps before submitting the Follow Up Letter.
</cfoutput>
<cfelseif SelectAudit.Report is NOT "Completed">
<cfoutput>		
<br>
The Audit Report is not yet Completed.<br><br>
Please <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">go back</a> and complete the audit report and follow any necessary steps before submitting the Follow Up Letter.
</cfoutput>
<cfelseif SelectAudit.ScopeLetter is "">
<cfoutput>		
<br>
The Scope Letter is not yet Completed.<br><br>
Please <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">go back</a> and complete the scope letter and follow any necessary steps before submitting the Follow Up Letter.
</cfoutput>
<cfelse>

<cfoutput query="SelectAudit">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>			  

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="FollowUp_Submit.cfm?ID=#ID#&Year=#Year#">
<br>
<cfinclude template="FollowUp_Template2.cfm">
<br><br>
<hr>
<br>

<b>Contact Name</b><br>
<input name="e_Name" Type="Text" Size="50" Value="#KC#" displayname="Contact Name"><br><br>

<b>Email</b><br>
<input name="e_ContactEmail" Type="Text" Size="50" Value="#KCEmail#" displayname="Contact Email"><br><br>

<b>Third Party Name</b><br>
#ExternalLocation#<br><br>

<b>Client Address</b><br>
<input name="e_Address1" Type="Text" Value="#Address1#" size="50" displayname="Address"><br>
<input name="Address2" Type="Text" Value="#Address2#" size="50"><br>
<input name="Address3" Type="Text" Value="#Address3#" size="50"><br>
<input name="Address4" Type="Text" Value="#Address4#" size="50"><br><br>

<b>File Number</b><br>
#FileNumber#<br><br>

<cfif billable is "Yes">
<b>Project Number</b><br>
<input name="e_ProjectNumber" Type="Text" Value="" size="50" displayname="Project Number"><br><br>
</cfif>

<b>Lead Auditor</b><br>
#LeadAuditor#<br><br>

<cfif Auditor is "" or Auditor is "- None -">
<cfelse>
<b>Auditor(s)</b><br>
#Auditor#<br><br>
</cfif>
</cfoutput>

<cfif SelectAudit.Type is "CAP-EA/CAP-AA" or SelectAudit.Type is "CAP-EA">
<b>CAP Coordinator</b><br>
<SELECT NAME="e_CAPName" displayname="CAP Coordinator">
	<OPTION VALUE="">Select CAP Coordinator
	<OPTION VALUE="">---
	<cfoutput query="CAPCoord">		
	<OPTION VALUE="#Name#,#Location#,#Email#">#Name# (#Location#)
	</cfoutput>
</select>
<br>
*CAP Coordinator will be cc'ed on the follow up letter.	
<br><br>
</cfif>

<cfoutput query="SelectAudit">
<b>Auditor Email</b><br>
<input name="e_AuditorEmail" Type="Text" size="60" Value="#Email#" displayname="Auditor Email"><br><br>

<b>Additional Recipients of Scope Letter (cc)*</b><br>
<input name="cc" Type="Text" size="75" Value=""><br>
* cc includes Jim Feth automatically<br><br>

<b>Phone</b><br>
<input name="e_Phone" Type="Text" Value="#Phone#" displayname="Auditor Phone"><br><br>

<INPUT TYPE="button" value="Submit Follow Up Letter" onClick=" javascript:checkFormValues(document.all('Audit'));">
</form>

</cfoutput>		  
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->