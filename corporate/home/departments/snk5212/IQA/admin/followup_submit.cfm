<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
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

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Confirm Follow Up Letter Before Sending">
<cfinclude template="SOP.cfm">

<!--- / --->
	
<br>						  
<b>Need to Edit?</b> Click 'back' on your browser's navigation bar.<br><br>
If you wish to submit, press 'Submit Follow Up Letter' below.<br><br>

<hr>
						  
<cfoutput query="SelectAudit">
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>								  

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="FollowUp_Confirm.cfm?ID=#ID#&Year=#Year#">

<input type="hidden" name="Name" Value="#Form.e_Name#">
<cfif SelectAudit.billable is "Yes">
<input type="hidden" name="ProjectNumber" Value="#Form.e_ProjectNumber#">
</cfif>
<input type="hidden" name="ContactEmail" Value="#Form.e_ContactEmail#">
<input type="hidden" name="Address1" Value="#Form.e_Address1#">
<input type="hidden" name="Address2" Value="#trim(Form.Address2)#">
<input type="hidden" name="Address3" Value="#trim(Form.Address3)#">
<input type="hidden" name="Address4" Value="#trim(Form.Address4)#">
<input type="hidden" name="FileNumber" Value="#FileNumber#">
<cfif SelectAudit.Type is "CAP-EA/CAP-AA" or SelectAudit.Type is "CAP-EA">
<cfset myArrayList = ListToArray(form.e_CAPName)>
<input type="hidden" name="CAPName" Value="#myarraylist[1]#">
<input type="hidden" name="CAPLocation" Value="#myarraylist[2]#">
<input type="hidden" name="CAPEmail" Value="#myarraylist[3]#">
</cfif>
<input type="hidden" name="Phone" Value="#Form.e_Phone#">
<input type="hidden" name="AuditorEmail" Value="#Form.e_AuditorEmail#">
<input type="hidden" name="cc" Value="#Form.cc#">

<cfinclude template="followup_template1.cfm">

<br><br>

<input type="submit" value="Send Follow Up Letter">
</form>

</cfoutput>
		  
 <br>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->