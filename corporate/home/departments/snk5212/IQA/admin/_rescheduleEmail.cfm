<CFQUERY BLOCKFACTOR="100" name="Schedule" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
FROM AuditSchedule
WHERE ID=57 and Year_=2013
</CFQUERY>

<cfoutput query="Schedule">
    <cfif AuditType2 eq "Program">
        <cfset incSubject = "#Trim(Area)#">
    <cfelseif AuditType2 eq "Field Services">
        <cfset incSubject = "Field Services - #trim(Area)#">
    <cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
        <cfif isDefined("Area")>
            <cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
        <cfelse>
            <cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
        </cfif>
    <cfelseif AuditType2 is "MMS - Medical Management Systems">
        <cfset incSubject = "#Trim(Area)#">
    </cfif>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="LeadAuditor">
    SELECT Email FROM AuditorList
    WHERE Auditor = '#LeadAuditor#'
    </CFQUERY>
</cfoutput>

<Cfset AuditorCCEmails = "">

<!--- add auditor field emails --->
<cfif len(Schedule.Auditor)>
    <cfloop index = "ListElement" list = "#Schedule.Auditor#">
        <Cfoutput>
            <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
            SELECT Email
            FROM AuditorList
            WHERE Auditor = '#trim(ListElement)#'
            </CFQUERY>

            <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
        </cfoutput>
    </cfloop>
</cfif>

<!--- add auditor in training field emails --->
<cfif len(Schedule.AuditorInTraining)>
    <cfloop index = "ListElement" list = "#Schedule.AuditorInTraining#">
        <Cfoutput>
            <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
            SELECT Email
            FROM AuditorList
            WHERE Auditor = '#trim(ListElement)#'
            </CFQUERY>

            <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
        </cfoutput>
    </cfloop>
</cfif>
<!--- /// --->

<cfmail
    to="Global.InternalQuality@ul.com, Internal.Quality_Audits@ul.com, Bruce.A.Mahrenholz@ul.com, Alan.Purvey@ul.com, #AuditorCCEmails#, #LeadAuditor.Email#, #email#, #email2#"
    from="Internal.Quality_Audits@ul.com"
    subject="Audit Rescheduled for 2014 - Quality System Audit of #incSubject#"
    query="Schedule"
    type="html">
The Quality System audit of #incSubject# scheduled for September, 2013 has been rescheduled to March, 2014.<br><br>

The new audit number is 2014-4. The original Audit (2013-57) will remain in the schedule to maintain documentation of the reschedule.<br /><br />

<u>Original Audit Number</u>: 2013-57-IQA<br>
<u>New Audit Number</u>: 2014-4-IQA<br>
<u>Audit Type</u>: #AuditType2#<br />
<u>Audit Area</u>: #Trim(Area)#<br>
<u>Location</u>: #Trim(Officename)#<br>
<u>Lead Auditor</u>: #LeadAuditor#<br>
<u>Original Audit Details</u>: http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=57&Year=2013<br>
<u>New Audit Details</u>: http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=4&Year=2014<br><br>

Please contact #Request.contacts_CancelRescheduleAudits# for any questions or issues.
</cfmail>