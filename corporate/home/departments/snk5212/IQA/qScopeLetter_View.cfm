<br>

<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<CFQUERY blockfactor="100" Datasource="Corporate" Name="Type"> 
SELECT AuditType, ID, YEAR_ as "Year"
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif Type.RecordCount neq 0>

<cfif Type.AuditType is "TPTDP">
    <CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
    SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType,AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.Desk,
    
    ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.ExternalLocation,
    
    Scope.Address1, Scope.Address2, Scope.Address3, Scope.Address4, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.FileNo, Scope.Cost, Scope.AuditorEmail, Scope.CC
    
    FROM AuditSchedule, ExternalLocation, Scope
    WHERE AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND  AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND  Scope.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND  Scope.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
    </CFQUERY>

<cfelseif Type.AuditType is "Quality System">
    <CFQUERY blockfactor="100" Datasource="Corporate" Name="Scope"> 
    SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor as Aud, AuditSchedule.AuditorInTraining, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, Scope.Title, Scope.Name, Scope.ContactEmail, Scope.Auditor, Scope.Phone, Scope.DateSent, Scope.AttachA, Scope.AuditorEmail, Scope.StartTime, Scope.CC, AuditSchedule.Desk
    
    FROM AuditSchedule, Scope
    
    WHERE AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND Scope.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND Scope.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>
</cfif>

<cfoutput query="Scope">
<cfif AuditType is "TPTDP">
	<cfif year lt 2007>
		<cfinclude template="scopetemplateTP4_old.cfm">
	<cfelseif year gte 2007>
		<cfinclude template="scopetemplateTP4.cfm">
	</cfif>
<cfelse>
<!--- New Scope --->
<cfif year gte 2008>
<!--- New Scope 4/17/2009 to include MMS --->
	<cfinclude template="IQAScope4.cfm">
<!--- End of New Scope for 2008+ --->
<cfelse>
	<cfif audittype2 is "Field Services">
        <cfif year lt 2006>
            <cfinclude template="FSTemplate4_old.cfm">
        <cfelseif year is 2006>
            <cfif month lte 8>
                <cfinclude template="FSTemplate4_old.cfm">
            <cfelseif month gte 9>
                <cfinclude template="FSTemplate4.cfm">
            </cfif>
        <cfelseif year gte 2007>
            <cfinclude template="FSTemplate4.cfm">	
        </cfif>
    <cfelse>
<cfif year lt 2006>
	<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4_old.cfm">
	<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4_old.cfm">
	</cfif>
<cfelseif year is 2006>
	<cfif month lte 7>
		<cfif audittype2 is "Program">
			<cfinclude template="QSwProgTemplate4_old.cfm">
		<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
			<cfinclude template="QSTemplate4_old.cfm">	
		</cfif>
	<cfelseif month gte 8>
		<cfif audittype2 is "Program">
			<cfinclude template="QSwProgTemplate4.cfm">
		<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
			<cfinclude template="QSTemplate4.cfm">
		</cfif>
	</cfif>
<cfelseif year gte 2007>
	<cfif audittype2 is "Program">
		<cfinclude template="QSwProgTemplate4.cfm">
	<cfelseif audittype2 is "Corporate" or audittype2 is "Local Function" or audittype2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
		<cfinclude template="QSTemplate4.cfm">
	</cfif>
</cfif>
</cfif>
</cfif>
</cfif>
"Attachment A" File: <a href="#IQARootDir#ScopeLetters/#AttachA#">#AttachA#</a><br>

</cfoutput>

<cfelse>
	<cfoutput>
	There is no Scope Letter for #url.year#-#url.id#.
	</cfoutput>
</cfif>