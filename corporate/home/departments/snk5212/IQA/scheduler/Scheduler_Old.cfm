<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>
<cfset Year = #Dateformat(now(), 'yyyy')#>

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfif CurMonth is 12>
	<cfset NextMonth = 1>
	<cfset Year = #CurYear# + 1>
<cfelse>
	<cfset NextMonth = #CurMonth# + 1>
	<cfset Year = #CurYear#>
</cfif>

<cfset AllAuditContactsTo = "Jola.Wroblewska@ul.com, William.R.Carney@ul.com">
<cfset AllAuditContactsBCC = "Global.InternalQuality@ul.com, Internal.Quality_Audits@ul.com">

<CFQUERY BLOCKFACTOR="100" NAME="baseline" Datasource="Corporate"> 
SELECT *  FROM Baseline
WHERE YEAR_ = #year#
</cfquery>

<!--- only if schedule for the year is baselined --->
<cfif baseline.baseline eq 1>
	<!--- first day of month only --->
    <cfif Day is 01>

<!--- get audit information for appropriate month/year --->
<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate"> 
SELECT 
	AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditArea, AuditSchedule.Year_ as Year, AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.AuditType2, AuditSchedule.Month, AuditSchedule.Area, AuditSchedule.Status, AuditSchedule.Approved, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, 
    
    IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2

FROM 
	AuditSchedule, IQAtblOffices

WHERE 
	AuditSchedule.Status IS NULL
	AND AuditSchedule.Month = #NextMonth#
	AND AuditSchedule.YEAR_ = #Year# 
    AND AuditSchedule.AuditType <> 'TPTDP'
	AND AuditSchedule.AuditedBy = 'IQA'
	AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
	AND AuditSchedule.Approved = 'Yes'
    AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')

ORDER BY 
	AuditSchedule.ID
</CFQUERY>

<cfoutput query="SelectAudits">
<!--- create list of auditor emails for cc (lead, auditor, and auditors in training --->
<Cfset AuditorCCEmails = "">

<!--- add lead auditor field email --->
<CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
SELECT Email 
FROM AuditorList
WHERE Auditor = '#LeadAuditor#'
</CFQUERY>

<cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>

<!--- select Lead Auditor Email for replyTo cfmail field --->
<cfset LeadAuditorEmail = "#AuditorEmail.Email#">

<!--- add auditor field emails --->
<cfif len(SelectAudits.Auditor)>
    <cfloop index = "ListElement" list = "#Auditor#"> 
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
<cfif len(SelectAudits.AuditorInTraining)>
    <cfloop index = "ListElement" list = "#AuditorInTraining#"> 
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

<!--- add site contacts for the location of the audit --->
<cfset SiteContacts = "">

<!--- site contacts --->
<cfif len(RQM)><cfset SiteContacts = listAppend(SiteContacts, "#RQM#")></cfif>
<cfif len(QM)><cfset SiteContacts = listAppend(SiteContacts, "#QM#")></cfif>
<cfif len(GM)><cfset SiteContacts = listAppend(SiteContacts, "#GM#")></cfif>
<cfif len(LES)><cfset SiteContacts = listAppend(SiteContacts, "#LES#")></cfif>
<cfif len(Other)><cfset SiteContacts = listAppend(SiteContacts, "#Other#")></cfif>
<cfif len(Other2)><cfset SiteContacts = listAppend(SiteContacts, "#Other2#")></cfif>

<!--- add other Contacts (program/process owners) --->
<cfset otherContacts = "">

<!--- add subject information for email and contact information --->
<!--- program audits --->
<cfif AuditType2 eq "Program">
	<!--- contacts --->
	<CFQUERY BLOCKFACTOR="100" NAME="ProgramContacts" Datasource="Corporate">
	Select POEMail, PMEmail, SEMail
    FROM ProgDev
    WHERE Program = '#Trim(Area)#'
	</CFQUERY>

	<!--- add contacts to other contacts list --->
	<cfif len(ProgramContacts.POEmail)><cfset OtherContacts = listAppend(otherContacts, "#ProgramContacts.POEmail#")></cfif>
    <cfif len(ProgramContacts.PMEmail)><cfset OtherContacts = listAppend(otherContacts, "#ProgramContacts.PMEmail#")></cfif>
    <cfif len(ProgramContacts.SEmail)><cfset OtherContacts = listAppend(otherContacts, "#ProgramContacts.SEmail#")></cfif>
    
	<!--- subject --->
    <cfset incSubject = "#Trim(Area)#">
        <!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
        <cfif Area eq "&lt;PS&gt;E Mark (JP) (JP CO)">
            <cfset incSubjectTitle = "<PS>E Mark (JP) (JP CO)">
        <!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
        <cfelseif Area eq "&lt;PS&gt;E Mark (JP) (US CO)">
            <cfset incSubjectTitle = "<PS>E Mark (JP) (US CO)">
        <!--- all other programs --->
        <cfelse>
            <cfset incSubjectTitle = "#incSubject#">
        </cfif>
        <!--- /// --->
<!--- Field Services audits --->
<cfelseif AuditType2 eq "Field Services">
	<!--- other contacts - NONE --->
    <cfset otherContacts = "">

	<!--- subject --->
    <cfset incSubject = "Field Services - #trim(Area)#">
    <cfset incSubjectTitle = "#incSubject#">
<!--- Local Function --->
<cfelseif AuditType2 is "Local Function" 
    or AuditType2 is "Local Function FS" 
    or audittype2 is "Local Function CBTL">
    	<!--- other contacts - NONE --->
    	<cfset otherContacts = "">
    
    	<!---subject --->
        <cfif isDefined("Area")>
            <cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
            <cfset incSubjectTitle = "#incSubject#">
        <cfelse>
            <cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
            <cfset incSubjectTitle = "#incSubject#">
        </cfif>
<!--- Corporate --->
<cfelseif AuditType2 is "Corporate">
	<!--- contacts --->
	<CFQUERY BLOCKFACTOR="100" NAME="CorporateContacts" Datasource="Corporate">
	Select Owner
    FROM CorporateFunctions
    WHERE Function = '#Trim(Area)#'
	</CFQUERY>

	<!--- add contacts to other contacts list --->
	<cfif len(CorporateContacts.Owner)><cfset OtherContacts = listAppend(otherContacts, "#CorporateContacts.Owner#")></cfif>

	<!--- subject --->
	<cfif isDefined("Area")>
        <cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
        <cfset incSubjectTitle = "#incSubject#">
    <cfelse>
        <cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
        <cfset incSubjectTitle = "#incSubject#">
    </cfif>
<!--- Global --->
<cfelseif AuditType2 is "Global Function/Process">
	<!--- contacts --->
	<CFQUERY BLOCKFACTOR="100" NAME="GlobalContacts" Datasource="Corporate">
	Select Owner
    FROM GlobalFunctions
    WHERE Function = '#Trim(Area)#'
	</CFQUERY>

	<!--- add contacts to other contacts list --->
	<cfif len(GlobalContacts.Owner)><cfset OtherContacts = listAppend(otherContacts, "#GlobalContacts.Owner#")></cfif>

	<!--- subject --->
	<cfif isDefined("Area")>
        <cfset incSubject = "#Trim(OfficeName)# - #Trim(Area)#">
        <cfset incSubjectTitle = "#incSubject#">
    <cfelse>
        <cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
        <cfset incSubjectTitle = "#incSubject#">
    </cfif>
<!--- MMS --->
<cfelseif AuditType2 is "MMS - Medical Management Systems">
	<!--- other contacts - NONE --->
    <cfset otherContacts = "">

	<!--- subject --->
    <cfset incSubject = "#Trim(Area)#">
    <cfset incSubjectTitle = "#incSubject#">
</cfif>

<!--- create ToEmails list --->
<cfset ToEmails = "">
<cfif len(Email)><cfset ToEmails = listAppend(ToEmails, "#Email#")></cfif>
<cfif len(SiteContacts)><cfset ToEmails = listAppend(ToEmails, "#SiteContacts#")></cfif>
<cfif len(otherContacts)><cfset ToEmails = listAppend(ToEmails, "#otherContacts#")></cfif>
<cfif len(AllAuditContactsTo)><cfset ToEmails = listAppend(ToEmails, "#AllAuditContactsTo#")></cfif>
<cfif len(Email2)><cfset ToEmails = listAppend(ToEmails, "#Email2#")></cfif>

<!--- add a space after each comma to ToEmails list --->
<cfset ToEmails = replace(ToEmails, ",", ", ", "All")>

<!--- add a space after each comma to AuditorCCEmails list --->
<cfset AuditorCCEmails = replace(AuditorCCEmails, ",", ", ", "All")>

<cfmail 
	from="Internal.Quality_Audits@ul.com" 
	to=	"#ToEmails#"
	cc="#AuditorCCEmails#"
    bcc= "#AllAuditContactsBCC#"
	subject="IQA Audit Notification - Quality System Audit of #incSubjectTitle#"
    type="html" 
    Mailerid="Reminder">
This is an email reminder to inform you that a Quality System Audit of <b>#incSubject#</b> is scheduled for #MonthAsString(Month)#.<br><br>

For more information about this audit, please view the Audit Details page on the Internal Quality Audit website:<br>
http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

No action is required on your part at this time unless you foresee a scheduling conflict. The assigned lead auditor will contact you with specific scope information and to arrange the dates of the audit. The lead auditor assigned to this audit is <b>#LeadAuditor#</b> should you have any further questions.<br><br>
</cfmail>
</cfoutput>

	</cfif>
</cfif>