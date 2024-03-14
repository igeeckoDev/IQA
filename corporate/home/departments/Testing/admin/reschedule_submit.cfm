<cfif Form.Resched is "Cancel Request">
	<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#" addtoken="no">
<cfelseif form.resched is "Confirm Request">

	<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>

    <CFQUERY BLOCKFACTOR="100" name="Orig" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
    FROM AuditSchedule
    WHERE ID=#URL.ID# and Year_=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <cfoutput query="Orig">
        <cfset OrigMonth = MonthAsString(Month)>
    </cfoutput>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Reschedule">
    UPDATE AuditSchedule
    SET

    RescheduleStatus='Rescheduled',
    RescheduleNextYear=
    <cfif Form.RescheduleNextYear is "Yes">
    'Yes',
    <cfelse>
    'No',
    </cfif>

    <cfif form.RescheduleNextYear is "No">
		<cfif Form.StartDate is "" AND Form.EndDate is "">
            startdate=null,
            enddate=null,
        <cfelse>
            startdate=#CreateODBCDate(form.StartDate)#,
            enddate=#CreateODBCDate(form.EndDate)#,
        </cfif>
    month=#form.month#,
    </cfif>

    RescheduleNotes='#FORM.RescheduleNotes#'

    WHERE ID=#URL.ID# and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" name="Schedule" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
    FROM AuditSchedule
    WHERE ID=#URL.ID# and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <cfif reschedulenextyear is "Yes">

    <cfset NextYear = #schedule.Year# + 1>

    <cfif schedule.audittype is "TPTDP">
    <CFQUERY Datasource="Corporate" Name="CheckBillable">
    SELECT * FROM ExternalLocation
    WHERE ExternalLocation = '#Schedule.ExternalLocation#'
    </CFQUERY>
    <cfelse>
    </cfif>

    <CFQUERY Datasource="Corporate" Name="CheckYear">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
    WHERE YEAR_ = #NextYear#
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addguid">
    SELECT MAX(xGUID) + 1 AS xy FROM AuditSchedule
    </CFQUERY>

    <cfif CheckYear.recordcount is 0>
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
        INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
        VALUES (1, #NextYear#, '#orig.AuditedBy#', #addGUID.xy#)
        </cfquery>
    <cfelse>
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
        SELECT MAX(ID) + 1 AS newid FROM AuditSchedule
        WHERE Year_ = #NextYear#
        </CFQUERY>

        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
        INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
        VALUES (#Query.newid#, #NextYear#, '#orig.AuditedBy#', #addGUID.xy#)
        </CFQUERY>
    </cfif>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
    UPDATE AuditSchedule
    SET

    <cfif orig.audittype is "Finance">
    officename='#orig.officename#',
    ascontact='#orig.ascontact#',
    scope='<cfif orig.scope is NOT "">#orig.scope#<br><br></cfif>Note - This audit has been rescheduled in place of audit #URL.Year#-#URL.ID#',
    area=null,
    externallocation=null,
    auditarea=null,
    status=null,
    leadauditor=null,
    auditor=null,
    reschedulestatus=null,
    reschedulenotes=null,
    reschedulenextyear=null,
    report=null,
    report2=null,
    plan=null,
    scopeletter=null,
    scopeletterdate=null,
    followup=null,
    notes=null,
    kp=null,
    rd=null,
    email=null,
    agenda=null,
    sitecontact=null,
    desk=null,

    <cfelseif orig.auditedby is "QRS">
    officename='#orig.officename#',
    auditor='#orig.auditor#',
    scope='<cfif orig.scope is NOT "">#orig.scope#<br><br></cfif>Note - This audit has been rescheduled in place of audit #URL.Year#-#URL.ID#',
    area=null,
    externallocation=null,
    auditarea=null,
    status=null,
    leadauditor=null,
    reschedulestatus=null,
    reschedulenotes=null,
    reschedulenextyear=null,
    report=null,
    report2=null,
    plan=null,
    scopeletter=null,
    scopeletterdate=null,
    followup=null,
    notes=null,
    kp=null,
    rd=null,
    email='#orig.email#',
    agenda=null,
    sitecontact=null,
    desk=null,
    <cfelse>

    <cfif orig.AuditType is "TPTDP">
    ExternalLocation='#orig.ExternalLocation#',
        <cfif CheckBillable.Billable is "1">
        Billable='Yes',
        <cfelse>
        Billable='No',
        </cfif>
    <cfelse>
    AuditArea='#orig.AuditArea#',
    <cfif orig.area is "">
    <cfelse>
    Area='#orig.Area#',
    </cfif>
    <cfif orig.sitecontact is "">
    <cfelse>
    sitecontact='#orig.sitecontact#',
    </cfif>
    OfficeName='#orig.OfficeName#',
    Email=<cfif orig.Email is "">null,<cfelse>'#orig.Email#',</cfif>
    EmailName=<cfif orig.EmailName is "">null,<cfelse>'#orig.EmailName#',</cfif>
    Email2=<cfif orig.Email2 is "">null,<cfelse>'#orig.Email2#',</cfif>
    <cfif orig.RD is "- None -" or orig.RD is "">
    <cfelse>
    RD='#orig.RD#',
    </cfif>

    <cfif orig.KP is "- None -" or orig.KP is "">
    <cfelse>
    KP='#orig.KP#',
    </cfif>
    </cfif>

    Notes='This audit has been rescheduled in place of audit #URL.Year#-#URL.ID#',
    LeadAuditor='#orig.LeadAuditor#',
    Auditor='#orig.Auditor#',
    Scope='#orig.Scope#',
    </cfif>

    Approved='Yes',
    <cfif Form.StartDate is "" AND Form.EndDate is "">
    startdate=null,
    enddate=null,
    <cfelse>
    startdate=#CreateODBCDate(form.StartDate)#,
    enddate=#CreateODBCDate(form.EndDate)#,
    </cfif>
    month=#form.month#,

    AuditType='#orig.AuditType#',
    AuditType2=<cfif orig.audittype2 is "">null<cfelse>'#orig.AuditType2#'</cfif>

    WHERE
    <cfif CheckYear.recordcount is 0>
    ID=1
    <cfelse>
    ID=#Query.newid#
    </cfif>
    AND Year_ = #NextYear#
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" name="NextYr" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
    WHERE
    <cfif CheckYear.recordcount is 0>
    ID=1
    <cfelse>
    ID=#Query.newid#
    </cfif>
    and Year_ = #NextYear#
    </CFQUERY>

    <cfoutput query="NextYr">
        <cfset NewMonth = MonthAsString(Month)>
    </cfoutput>

    <CFQUERY BLOCKFACTOR="100" name="Schedule" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
    WHERE ID=#URL.ID# and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Note">
    UPDATE AuditSchedule
    SET

    RescheduleNotes='#Schedule.RescheduleNotes#<br><br>This audit has been rescheduled as #NextYear#-#NextYr.ID#'

    WHERE ID = #URL.ID# AND YEAR_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cfif>

    <!--- check if schedule is baselined for the year --->
    <CFQUERY BLOCKFACTOR="100" NAME="baselineCheck" Datasource="Corporate">
    SELECT *
    FROM Baseline
    WHERE Year_ = #url.Year#
    </CFQUERY>

    <!--- only send cancel notification if the schedule is baselined --->
    <cfif baselineCheck.baseline EQ 1>

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
        </cfoutput>

        <!--- email only for IQA --->
        <cfif schedule.auditedby is "IQA">
            <cfif RescheduleNextYear is "Yes">
                <cfmail to="kai.huang@ul.com, Internal.Quality_Audits@ul.com, Bruce.A.Mahrenholz@ul.com"
                        from="Internal.Quality_Audits@ul.com"
                        subject="Audit Rescheduled - Quality System Audit of #incSubject#"
                        query="Schedule"
                        type="html">
                The Quality System audit of #incSubject# scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #NewMonth#, #NextYear#. The new audit number is #NextYear#-#NextYr.ID#. The original Audit (#Year_#-#ID#) will remain in the schedule to maintain documentation of the reschedule.<br /><br />

                <u>Audit</u>: #Year_#-#ID#-#AuditedBy#<br>
                <u>Audit Type</u>: #AuditType2#<br />
                <u>Audit Area</u>: #Trim(Area)#<br>
                <u>Location</u>: #Trim(Officename)#<br>
                <u>Lead Auditor</u>: #LeadAuditor#<br>
                <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                <cfset N = #ReplaceNoCase(Form.RescheduleNotes,chr(13),"<br>", "ALL")#>

                Reschedule Notes: #N#<br /><br />

                Please contact #Request.contacts_CancelRescheduleAudits# for any questions or issues.
                </cfmail>
            <cfelse>
                <cfmail to="kai.huang@ul.com, Internal.Quality_Audits@ul.com, Bruce.A.Mahrenholz@ul.com"
                        from="Internal.Quality_Audits@ul.com"
                        subject="Audit Rescheduled - Quality System Audit of #incSubject#"
                        query="Schedule"
                        type="html">
                The Quality System audit of #incSubject# scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #MonthAsString(Schedule.Month)#, #URL.Year#.<br /><br />

                <u>Audit</u>: #Year_#-#ID#-#AuditedBy#<br>
                <u>Audit Type</u>: #AuditType2#<br />
                <u>Audit Area</u>: #Trim(Area)#<br>
                <u>Location</u>: #Trim(Officename)#<br>
                <u>Lead Auditor</u>: #LeadAuditor#<br>
                <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                <cfset N = #ReplaceNoCase(Form.RescheduleNotes,chr(13),"<br>", "ALL")#>

                Reschedule Notes: #N#<br /><br />

                Please contact #Request.contacts_CancelRescheduleAudits# for any questions or issues.
                </cfmail>
            </cfif>
        </cfif>
    </cfif>

<cflocation url="AuditReschedule_FileUpload.cfm?Year=#url.Year#&ID=#url.id#" addtoken="no">
</cfif>