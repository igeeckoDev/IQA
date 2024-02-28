<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Approve the Audit Cancellation - File Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.File")>

    <cfparam name="link" default="">
    <cfset link="#HTTP_Referer#">

    <CFIF Form.File is "">
        <cflocation url="#link#" addtoken="no">
    </CFIF>

    <CFFILE ACTION="UPLOAD"
        FILEFIELD="Form.File"
        DESTINATION="#IQAPath#CancelFiles\"
        NAMECONFLICT="OVERWRITE"
        accept="application/pdf">

	<cfset FileName="#Form.File#">

	<cfset NewFileName="#URL.Year#-#URL.ID#-CancelApprovalFile.#cffile.ClientFileExt#">

    <cffile
        action="rename"
        source="#FileName#"
        destination="#IQAPath#CancelFiles\#NewFileName#">

        <CFQUERY BLOCKFACTOR="100" NAME="Notes" Datasource="Corporate">
        SELECT CancelNotes
        FROM AuditSchedule
        WHERE ID = #URL.ID#
        and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
        </cfquery>

        <CFQUERY BLOCKFACTOR="100" NAME="AddID" Datasource="Corporate">
		Update AuditSchedule
		SET
		FileCancel = '#NewFileName#',
        Status = 'Deleted',
        CancelNotes = '#Form.Notes#<br>Approved By:<cflock scope="session" timeout="5">#SESSION.Auth.Username#</cflock><br>Date: #dateformat(curdate, "mm/dd/yyyy")#<br /><Br />#Notes.CancelNotes#'

		WHERE ID = #URL.ID# AND Year_ = #URL.Year#
        </CFQUERY>

		<!--- check if schedule is baselined for the year --->
        <CFQUERY BLOCKFACTOR="100" NAME="baselineCheck" Datasource="Corporate">
        SELECT *
        FROM Baseline
        WHERE Year_ = #url.Year#
        </CFQUERY>

        <!--- only send cancel notification if the schedule is baselined --->
        <cfif baselineCheck.baseline EQ 1>
            <CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
            SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
            FROM AuditSchedule
            WHERE ID = #URL.ID#
            and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfset N = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>

            <cfoutput query="AuditSched">
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
        WHERE Auditor = '#AuditSched.LeadAuditor#'
        </CFQUERY>

        <Cfset AuditorCCEmails = "">

        <!--- add auditor field emails --->
        <cfif len(AuditSched.Auditor)>
            <cfloop index = "ListElement" list = "#AuditSched.Auditor#">
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
        <cfif len(AuditSched.AuditorInTraining)>
            <cfloop index = "ListElement" list = "#AuditSched.AuditorInTraining#">
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

            <cflock scope="SESSION" timeout="5">
                <cfif AuditSched.auditedby is "IQA">
                    <cfmail
                        to="Bruce.A.Mahrenholz@ul.com, #LeadAuditor.Email#, #AuditorCCEmails#, #email#, #email2#"
                        cc="#SESSION.Auth.Email#"
                        bcc="Global.InternalQuality@ul.com"
                        from="Internal.Quality_Audits@ul.com"
                        subject="Audit Cancelled - Quality System Audit of #incSubject#"
                        query="AuditSched"
                        type="HTML">
                        The following audit has been cancelled:<br><br>

                        <u>Audit</u>: #Year#-#ID#-#AuditedBy#<br>
                        <u>Audit Type</u>: #AuditType2#<br />
                        <u>Audit Area</u>: #Trim(Area)#<br>
                        <u>Location</u>: #Trim(Officename)#<br>
                        <u>Lead Auditor</u>: #LeadAuditor#<br>
                        <u>Audit Details</u>: http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#<br><br>

                        Cancellation details can be found in an attached file on the Audit Details page.<br /><br />

                        Please contact #Request.contacts_CancelRescheduleAudits# with any questions or issues.
                    </cfmail>
                </cfif>
            </cflock>
        </cfif>

      <cfset message = "Cancellation Request Approval File has been uploaded. Audit Cancelled.">

<cflocation url="cancel_approval_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=#variables.message#" addtoken="no">

<cfelseif isDefined("url.msg")>
<cfoutput>
<br />
<font color="red"><b>#url.msg#</b></font><br /><br />

<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><Br /><Br />
</cfoutput>
<cfelse>

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

<b>Audit Number</b><br />
#URL.Year#-#URL.ID#-IQA<br /><br />

<form name="Audit" action="cancel_approval_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">
<u>Cancellation Approval Notes</u>:<br>
#form.e_Notes#<br><br>
<input type="hidden" value="#form.e_notes#" name="notes">

Audit Cancellation Approval File to Upload:<br />
<input type="File" size="50" name="File"><br><br />

<INPUT TYPE="button" value="Confirm Request" name="Cancel" onClick=" javascript:check(document.Audit.File);">
</form>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->