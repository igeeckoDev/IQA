<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Approve the Audit Reschedule - File Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.File")>
    <cfparam name="link" default="">
    <cfset link="#HTTP_Referer#">

    <CFIF Form.File is "">
        <cflocation url="#link#" addtoken="no">
    </CFIF>

    <CFQUERY BLOCKFACTOR="100" name="Orig" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
    FROM AuditSchedule
    WHERE ID=#URL.ID# and Year_=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <cfoutput query="Orig">
        <cfset OrigMonth = MonthAsString(Month)>
    </cfoutput>

    <CFQUERY BLOCKFACTOR="100" NAME="Notes" Datasource="Corporate">
    SELECT RescheduleNotes
    FROM AuditSchedule
    WHERE ID = #URL.ID#
    and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Reschedule">
    UPDATE AuditSchedule
    SET

    RescheduleStatus='Rescheduled',
    RescheduleNextYear=
    <cfif Orig.RescheduleRequestNextYear is "Yes">
    'Yes',
    <cfelse>
    'No',
    </cfif>

    <cfif Orig.RescheduleRequestNextYear is "No">
		<cfif orig.RescheduleRequestStartDate is "" AND orig.RescheduleRequestEndDate is "">
            startdate=null,
            enddate=null,
        <cfelse>
            startdate=#CreateODBCDate(orig.RescheduleRequestStartDate)#,
            enddate=#CreateODBCDate(orig.RescheduleRequestEndDate)#,
        </cfif>
    month=#orig.RescheduleRequestMonth#,
    </cfif>

    RescheduleNotes='#form.e_notes#<br>Approved By:<cflock scope="session" timeout="5">#SESSION.Auth.Username#</cflock><br>Date: #dateformat(curdate, "mm/dd/yyyy")#<br /><Br />#Notes.RescheduleNotes#'

    WHERE ID=#URL.ID# and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <CFFILE ACTION="UPLOAD"
        FILEFIELD="Form.File"
        DESTINATION="#IQAPath#RescheduleFiles\"
        NAMECONFLICT="OVERWRITE"
        accept="application/pdf, application/msword">

	<cfset FileName="#Form.File#">

	<cfset NewFileName="#URL.Year#-#URL.ID#-RescheduleApprovalFile.#cffile.ClientFileExt#">

    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQAPath#RescheduleFiles\#NewFileName#">

        <CFQUERY BLOCKFACTOR="100" NAME="AddFile" Datasource="Corporate">
		Update AuditSchedule
		SET
		FileReschedule = '#NewFileName#'

		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>

    <!--- reschedule next year processing --->
    <cfif orig.RescheduleRequestNextYear is "Yes">
	    <cfset NextYear = #URL.Year# + 1>

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

    	AuditArea='#orig.AuditArea#',
    	<cfif len(orig.area)>Area='#orig.Area#',</cfif>
    	<cfif len(orig.sitecontact)>sitecontact='#orig.sitecontact#',</cfif>
		OfficeName='#orig.OfficeName#',
    	<cfif len(orig.Email)>Email='#orig.Email#',</cfif>
    	<cfif len(orig.EmailName)>EmailName='#orig.EmailName#',</cfif>
    	<cfif len(orig.Email2)>Email2='#orig.Email2#',</cfif>
		<cfif len(orig.RD) AND orig.RD neq "- None -">RD='#orig.RD#',</cfif>
		<cfif len(orig.KP) AND orig.KP neq "- None -">KP='#orig.KP#',</cfif>

	    Notes='This audit has been rescheduled in place of audit <a href="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#">#URL.Year#-#URL.ID#</a>',
    	LeadAuditor='#orig.LeadAuditor#',
    	Auditor='#orig.Auditor#',
        AuditorInTraining='#orig.AuditorInTraining#',
        BusinessUnit='#orig.BusinessUnit#',
    	Scope='#orig.Scope#',
	    Approved='Yes',
    	<cfif orig.RescheduleRequestStartDate is "" AND orig.RescheduleRequestEndDate is "">
    		startdate=null,
    		enddate=null,
    	<cfelse>
    		startdate=#CreateODBCDate(orig.RescheduleRequestStartDate)#,
    		enddate=#CreateODBCDate(orig.RescheduleRequestEndDate)#,
    	</cfif>
	    month=#orig.RescheduleRequestMonth#,
		AuditType2=<cfif orig.audittype2 is "">null<cfelse>'#orig.AuditType2#',</cfif>
		AuditType='#orig.AuditType#'

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
        SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
        FROM AuditSchedule
        WHERE ID=#URL.ID# and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
        </CFQUERY>

        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Note">
        UPDATE AuditSchedule
        SET

        RescheduleNotes='This audit has been rescheduled as <a href="auditdetails.cfm?Year=#NextYear#&ID=#NextYr.ID#">#NextYear#-#NextYr.ID#</a><br><br>#Schedule.RescheduleNotes#'

        WHERE ID = #URL.ID# AND YEAR_ = #URL.Year#
        </cfquery>
    </cfif>

    <CFQUERY BLOCKFACTOR="100" name="Schedule" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
    FROM AuditSchedule
    WHERE ID=#URL.ID# and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </CFQUERY>

    <!--- check if schedule is baselined for the year --->
    <CFQUERY BLOCKFACTOR="100" NAME="baselineCheck" Datasource="Corporate">
    SELECT *
    FROM Baseline
    WHERE Year_ = #url.Year#
    </CFQUERY>

	<cfif baselineCheck.baseline eq 1>
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

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="LeadAuditor">
        SELECT Email FROM AuditorList
        WHERE Auditor = '#Schedule.LeadAuditor#'
        </CFQUERY>

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

        <!--- email only for IQA --->
        <cfif Schedule.auditedby is "IQA">
            <cfif Schedule.RescheduleNextYear is "Yes">
                <cfmail
                	to="Global.InternalQuality@ul.com, Internal.Quality_Audits@ul.com, Bruce.A.Mahrenholz@ul.com, #AuditorCCEmails#, #LeadAuditor.Email#, #email#, #email2#"
                    from="Internal.Quality_Audits@ul.com"
                    subject="Audit Rescheduled for #NextYear# - Quality System Audit of #incSubject#"
                    query="Schedule"
                    type="html">
                The Quality System audit of #incSubject# scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #NewMonth#, #NextYear#.<br><br>

                The new audit number is #NextYear#-#NextYr.ID#. The original Audit (#Year_#-#ID#) will remain in the schedule to maintain documentation of the reschedule.<br /><br />

                <u>Original Audit Number</u>: #Year_#-#ID#-#AuditedBy#<br>
                <u>New Audit Number</u>: #NextYear#-#NextYr.ID#-#AuditedBy#<br>
                <u>Audit Type</u>: #AuditType2#<br />
                <u>Audit Area</u>: #Trim(Area)#<br>
                <u>Location</u>: #Trim(Officename)#<br>
                <u>Lead Auditor</u>: #LeadAuditor#<br>
                <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                <!---
                <cfset N = #ReplaceNoCase(RescheduleNotes,chr(13),"<br>", "ALL")#>

                Reschedule Notes: #N#<br /><br />
                --->

                Please contact #Request.contacts_CancelRescheduleAudits# for any questions or issues.
                </cfmail>
            <!--- reschedule is no --->
			<cfelse>
            	<cfif Schedule.OfficeName neq "test location">
                    <cfmail
                        to="Global.InternalQuality@ul.com, Internal.Quality_Audits@ul.com, Bruce.A.Mahrenholz@ul.com, , #AuditorCCEmails#, #LeadAuditor.Email#, #email#, #email2#"
                        from="Internal.Quality_Audits@ul.com"
                        subject="Audit Rescheduled - Quality System Audit of #incSubject#"
                        query="Schedule"
                        type="html">
                        The Quality System audit of #incSubject# has been rescheduled.<br /><br />

                    <u>Audit</u>: #Year_#-#ID#-#AuditedBy#<br>
                    <u>Audit Type</u>: #AuditType2#<br />
                    <u>Audit Area</u>: #Trim(Area)#<br>
                    <u>Location</u>: #Trim(Officename)#<br>
                    <u>Lead Auditor</u>: #LeadAuditor#<br><br />

                    <u>New Audit Date(s)</u>:<Br />
                    <cfif StartDate eq EndDate>
                        Start/End Date: #Dateformat(StartDate, "mm/dd/yyyy")#<Br /><br />
					<cfelse>
                    	Start Date: #Dateformat(StartDate, "mm/dd/yyyy")#<Br />
                        End Date: #Dateformat(EndDate, "mm/dd/yyyy")#<Br /><br />
                    </cfif>

                    <u>Original Audit Dates</u><br />
                    <cfif NOT len(orig.startDate) AND NOT len(orig.endDate)>
                    	No original dates were selected<br /><br />
                    <cfelse>
                    	Start Date: #Dateformat(orig.StartDate, "mm/dd/yyyy")#<Br />

						<cfif len(orig.EndDate)>
                        End Date: #Dateformat(orig.EndDate, "mm/dd/yyyy")#<Br />
                        </cfif><br />
					</cfif>

                    <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                    <!---
                    <cfset N = #ReplaceNoCase(RescheduleNotes,chr(13),"<br>", "ALL")#>

                    Reschedule Notes: #N#<br /><br />
                    --->

                    Please contact #Request.contacts_CancelRescheduleAudits# for any questions or issues.
                    </cfmail>
            	<cfelse>
                    <cfmail
                        to="global.internalquality@ul.com, #AuditorCCEmails#, #LeadAuditor.Email#, #email#, #email2#"
                        from="Internal.Quality_Audits@ul.com"
                        bcc="Christopher.J.Nicastro@ul.com"
                        subject="Audit Rescheduled (testing) - Quality System Audit of #incSubject#"
                        query="Schedule"
                        type="html">
                        The Quality System audit of #incSubject# has been rescheduled.<br /><br />

                        <u>Audit</u>: #Year_#-#ID#-#AuditedBy#<br>
                        <u>Audit Type</u>: #AuditType2#<br />
                        <u>Audit Area</u>: #Trim(Area)#<br>
                        <u>Location</u>: #Trim(Officename)#<br>
                        <u>Lead Auditor</u>: #LeadAuditor#<br><br />

                        <u>New Audit Dates</u>:<Br />
                        Start Date: #Dateformat(StartDate, "mm/dd/yyyy")#<Br />
                        End Date: #Dateformat(EndDate, "mm/dd/yyyy")#<Br /><br />

                        <u>Original Audit Dates</u><br />
                        Start Date: #Dateformat(orig.StartDate, "mm/dd/yyyy")#<Br />
                        End Date: #Dateformat(orig.EndDate, "mm/dd/yyyy")#<Br /><br />

                        <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                        Please contact #Request.contacts_CancelRescheduleAudits# for any questions or issues.
                    </cfmail>
                </cfif>
            </cfif>
        </cfif>

		<cfset message = "Reschedule Request Approval File #NewFileName# was uploaded">
	</cfif>

	<cfset message = "Reschedule Request Approval File #NewFileName# was uploaded">

   <cflocation url="Reschedule_approval_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" addtoken="no">
<cfelseif isDefined("url.msg")>
    <cfoutput>
    <br />
    <font color="red"><b>#url.msg#</b></font><br /><br />

    <a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><Br /><Br />
    </cfoutput>
<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
	SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
    FROM AuditSchedule
	WHERE ID = #URL.ID#
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>
	<script language="JavaScript">
    function check() {
      var ext = document.Audit.File.value;
      ext = ext.substring(ext.length-3,ext.length);
      ext = ext.toLowerCase();
        if ((document.Audit.File.value.length!=0) || (document.Audit.File.value!=null)) {
         if(ext != 'pdf') {
        alert('You selected a .'+ext+' file; Only PDF files are accepted.');
        return false;
         }
        }
    else
    return true;
    document.Audit.submit();
    }
    </script>

<form name="Audit" action="Reschedule_approval_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">
<u>Reschedule Approval Notes</u>:<br>
#form.e_Notes#<br><br>
<input type="hidden" value="#form.e_notes#" name="e_notes">

<u>Current Dates</u>:<Br />
Start Date: #Dateformat(AuditSched.StartDate, "mm/dd/yyyy")#<Br />
End Date: #Dateformat(AuditSched.EndDate, "mm/dd/yyyy")#<Br /><br />

<u>Proposed Date</u><br />
Start Date: #Dateformat(AuditSched.RescheduleRequestStartDate, "mm/dd/yyyy")#<Br />
End Date: #Dateformat(AuditSched.RescheduleRequestEndDate, "mm/dd/yyyy")#<Br /><br />

Audit Reschedule Approval File to Upload:<br />
<input type="File" size="50" name="File"><br><br />

<INPUT TYPE="button" value="Confirm Request" name="Cancel" onClick=" javascript:check(document.Audit.File);">
</form>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->