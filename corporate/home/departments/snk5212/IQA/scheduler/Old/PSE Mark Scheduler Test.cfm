<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditArea,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.AuditType2, AuditSchedule.Month, AuditSchedule.Area, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.LeadAuditor, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2

 FROM AuditSchedule, IQAtblOffices

 WHERE AuditSchedule.YEAR_= 2011 AND AuditSchedule.ID = 57
 AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
</CFQUERY>

<cfoutput query="SelectAudits">
	<cfif AuditType2 eq "Program">
    	<cfset incSubject = "#Trim(Area)#">
        	<!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
			<cfif Area eq "&lt;PS&gt;E Mark (JP) (JP CO)">
            	<cfset incSubjectTitle = "<PS>E Mark (JP) (JP CO)">
            <cfelseif Area eq "&lt;PS&gt;E Mark (JP) (US CO)">
            	<cfset incSubjectTitle = "<PS>E Mark (JP) (US CO)">
            <cfelse>
            	<cfset incSubjectTitle = "#incSubject#">
            </cfif>
            <!--- /// --->
    </cfif>

    <cfmail 
        from="Internal.Quality_Audits@ul.com" 
        to= "Christopher.J.Nicastro@ul.com"
        subject="Audit Notification - Quality System Audit of #incSubjectTitle#" 
        type="html" 
        Mailerid="Reminder">
    This is an email reminder to inform you that a Quality System Audit of <b>#incSubJect#</b> is scheduled for #MonthAsString(Month)#.<br><br>
    
    For more information about this audit, please view the Audit Details page on the IQA website:<br>
    http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>
    
    No action is required on your part at this time unless you foresee a scheduling conflict. The assigned lead auditor will contact you with specific scope information and to arrange the dates of the audit. The lead auditor assigned to this audit is <b>#LeadAuditor#</b> should you have any further questions.<br><br>
    </cfmail>
</cfoutput>