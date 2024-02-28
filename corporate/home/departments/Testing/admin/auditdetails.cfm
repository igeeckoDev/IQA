<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("URL.ID") AND isDefined("URL.Year")>

<CFQUERY BLOCKFACTOR="100" name="Check" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif Check.AuditType NEQ "TPTDP">
	<CFQUERY BLOCKFACTOR="100" name="Plan" Datasource="Corporate">
	SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
    FROM AuditSchedule
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	</CFQUERY>
<cfelse>
    <CFQUERY BLOCKFACTOR="100" name="Plan" Datasource="Corporate">
	SELECT AuditSchedule.ID, AuditSchedule.Evalu, AuditSchedule.EvalAuditor, AuditSchedule.Desk, AUDITSCHEDULE.YEAR_, AuditSchedule.Year_ as Year,
AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor,
AuditSchedule.Auditor, AuditSchedule.Area, AuditSchedule.AuditType2, AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope,
AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter, AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus,
AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD, AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.ICForm, AuditSchedule.Month,
AuditSchedule.Email, AuditSchedule.RescheduleNextYear, AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.AuditorInTraining, AuditSchedule.SiteContact,
AuditSchedule.ScopeLetterDate, AuditSchedule.Report2, ExternalLocation.ExternalLocation, ExternalLocation.Type, ExternalLocation.Billable,
ExternalLocation.Address1, ExternalLocation.Address2, ExternalLocation.Address3, ExternalLocation.Address4, ExternalLocation.KC, ExternalLocation.KCEmail

	FROM AuditSchedule, ExternalLocation

	WHERE AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	AND AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
	</CFQUERY>
</cfif>

<cfif Check.RecordCount neq 0>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/sitePopUp.js"></script>
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput>
	Go To <b><a href="#IQADir#auditdetails.cfm?#CGI.QUERY_STRING#">Public View</a></b><br /><br />
</cfoutput>

Audit Details Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditdetails.cfm')">[?]</A><br><br>

<CFOUTPUT query="Plan">

<cfif AuditedBy is "AS"
	or AuditedBy is "QRS"
	or AuditType2 is "Accred"
	or AuditedBy is "Finance"
	OR AuditedBy is "ULE" AND AuditType is "Accred"
	OR AuditedBy is "VS" AND AuditType is "Accred"
	OR AuditedBy is "WiSE" AND AuditType is "Accred">

<cfif auditedby is "AS">
<b>#AuditedBy#-#Year#-#ID#</b>
<cfelse>
<b>#Year#-#ID#-#AuditedBy#</b>
</cfif>
<br><br>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU"
	OR SESSION.Auth.accesslevel is "Admin"
	OR SESSION.Auth.AccessLevel is "#AuditedBy#"
	OR SESSION.Auth.SubRegion is '#AuditedBy#'
	OR SESSION.Auth.AccessLevel is "UL Environment" AND AuditedBy is "ULE"
	OR SESSION.Auth.AccessLevel is "Verification Services" AND AuditedBy is "VS"
	OR SESSION.Auth.AccessLevel is "WiSE" AND AuditedBy is "WiSE">

<u>Available Actions</u><br>
<cfif Approved is "No">
 - <a href="audit_ok.cfm?#CGI.Query_String#"><b>Approve</b></a> Audit for Audit Schedule.<br>
</cfif>

<cfif trim(auditedby) is "AS">
 - <A href="AS_edit.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">edit</a>
<cfelseif trim(auditedby) is "Finance">
 - <A href="F_edit.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">edit</a>
<cfelseif trim(auditedby) is "QRS">
 - <A href="QRS_edit.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">edit</a>
<cfelseif trim(audittype2) is "Accred">
 - <A href="Accred_audit_edit.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">edit</a>
</cfif><br>

<CFIF Trim(Status) is "deleted">
 - <A href="uncancel.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">reinstate</a><br>
 - <A href="remove.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">remove</a>
<cfelse>
 - <a href="cancel_old.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">cancel</a><br>
 - <a href="reschedule.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">reschedule</a><br>
 - <A href="remove.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">remove</a>
</CFIF>

</cfif><br><br>
</cflock>

<b>Location</b><br>
#OfficeName#<br><br>

<cfif auditedby is "AS">
<b>AS Contact Person</b><br>
#ASContact#<br><br>

<b>Site Contact</b><br>
#SiteContact#<br><br>

<cfelseif auditedby is "Finance">
<b>Finance Auditor</b><br>
<cfset Dump = #replace(ASContact, ",", "<br>", "All")#>
#Dump#<br><br>

<cfelseif AuditType2 is "Accred">
<b>Site Contact</b><br>
#SiteContact#<br><br>

<cfelseif auditedby is "QRS">
<b>Primary Contacts</b><br>
#Email#<br><br>

<b>Auditor</b><br>
#Auditor#<br><br>
</cfif>

<b>Audit Type</b><br>
#AuditType#<br><br>

<b>Month Scheduled</b><br>
<cfif not len(trim(month)) OR Month eq 0>
	No month scheduled
<cfelse>
	#MonthAsString(Month)#
</cfif><br><br>

<b>Audit Dates</b><br>
<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">

	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>

	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>

    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#<Br />

<!--- add/edit/clear dates for those with access --->
<cflock scope="SESSION" timeout="60">
    <cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<CFIF
		SESSION.Auth.accesslevel is "SU" or
		SESSION.Auth.accesslevel is "Admin" or
		SESSION.Auth.Region is "#AuditedBy#" OR
		SESSION.Auth.AccessLevel is "#AuditedBy#" OR
		SESSION.Auth.AccessLevel is "UL Environment" AND AuditedBy is "ULE" OR
		SESSION.Auth.AccessLevel is "Verification Services" AND AuditedBy is "VS" OR
		SESSION.Auth.AccessLevel is "WiSE" AND AuditedBy is "WiSE">
            <a href="add_dates.cfm?#CGI.Query_String#">Add/Change Dates</a><br />
            <a href="clear_dates.cfm?#CGI.Query_String#">Change Month/Clear Dates</a>
        </cfif>
    <cfelseif LeadAuditor is "#SESSION.AUTH.NAME#"
		AND NOT len(StartDate)
		AND NOT len(EndDate)>

		<a href="add_dates.cfm?#CGI.Query_String#">Add/Change Dates</a>
	</cfif>
</cflock>
<!--- // --->
<br /><br />

<cfinclude template="#IQARootDir#status_colors_AS.cfm">

<cfif Trim(RescheduleStatus) is "Rescheduled">
	<cfif RescheduleNextYear is NOT "Yes">
        <br><br>
	</cfif>

	<b>Reschedule Status</b><br>
	<img src="images/red.jpg" border="0"><br><br>

    <b>Reschedule Notes</b><br>
    #RescheduleNotes#
    <br /><br />
<cfelse>
	<br /><br />
</cfif>

<cfif RescheduleNextYear NEQ "Yes">
	<cfif auditedby is "AS">
	<b>Report</b><br>
		<cfif NOT len(Trim(Report))>
			No Report Submitted<br>
			<A href="add_files_AS.cfm?#CGI.Query_String#&type=report">Add Report</a><br><br>
		<cfelse>
		<A href="../Reports/#Report#?">View Report</a><br><br>
		</cfif>

		<b>Agenda</b><br>
		<cfif NOT Len(Trim(Agenda))>
			No Agenda Submitted<br>
			<A href="add_files_AS.cfm?#CGI.Query_String#&type=agenda">Add Agenda</a><br><br>
		<cfelse>
			<A href="../scopeletters/#Agenda#">View Agenda</a><br><br>
		</cfif>
    <cfelseif auditedby NEQ "AS"
		AND auditedby NEQ "Finance"
		AND auditedby NEQ "QRS"
		AND auditedby NEQ "WiSE"
		AND auditedby NEQ "VS">

        <b>Report</b><br>
		<cfif NOT len(Trim(Report))>
            No Report Submitted<br>
            <A href="addReport_Regional.cfm?#CGI.Query_String#&type=report">Add Report</a><br><br>
        <cfelse>
        <A href="../Reports/#Report#?">View Report</a><br><br>
        </cfif>
	</cfif>

	<cfif auditedby is "Finance">
	<b>Scope Letter</b><br>
		<cfif NOT len(Trim(ScopeLetter))>
			No Scope Letter Submitted<br>
			<A href="addscopeletter.cfm?#CGI.Query_String#">Add Scope Letter</a><br><br>
		<cfelse>
			<A href="../scopeletters/#ScopeLetter#">View Scope Letter</a><br><br>
		</cfif>
	</cfif>

	<cfif auditedby is "AS" or AuditType2 is "Accred" or AuditedBy is "Finance">
		<b>Scope<cfif AuditedBy is "Finance">/Notes</cfif></b><br>
		#Scope#<br><br>
	<cfelseif Auditedby is "QRS">
		<b>Scope/Report</b><br>
		<b>DMS File Number:</b><br>
		#Scope#<br><br>
	</cfif>
</cfif>

<cfif Status is "Deleted">
<b>Cancellation Notes</b><br>
#Notes#<br><br>
</cfif>

<cfif isdefined("Scheduler")>
	<cfif len(Scheduler)>
		<b>Audit Scheduled By:</b><br>
		#Scheduler#<br><br>
	</cfif>
</cfif>

<cfelseif AuditedBy is "LAB"
	OR AuditedBy is "VS" AND AuditType NEQ "Accred"
	OR AuditedBy is "ULE" AND AuditType NEQ "Accred"
	OR AuditedBY is "WiSE" AND AuditType NEQ "Accred">
	<!--- Laboratory Technical Audit and Wise/VS/ULE Internal Audits --->
	<cfinclude template="incAuditDetails_LTA.cfm">
<cfelseif AuditedBy is "TechnicalAudit">
	<!--- Technical Audit --->
	<!---
		<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.QUERY_STRING#" addtoken="no">
	--->
<cfelse>
<!--- IQA and Regional (Quality) Audits --->

<!---
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=350,left = 200,top = 200');");
}
//
</script>
--->

<cfif isDefined("URL.Var") AND isDefined("URL.Msg")>
	<cfif url.var is "Scope" OR url.var is "Report">
         <b><font color="red">Error Processing Request to
		 	<cfif url.var is "Scope">
				Send Scope Letter
			<cfelseif url.var is "Report">
				Add Audit Report
			</cfif><br>
			</font></b>
    	<cfif url.msg is "NOPC">
        	 :: There is no Primary Contact listed - please add the Primary Contact's Email Address.
        <cfelseif url.msg is "MultiplePC">
        	 :: There is more than one Primary Contact listed - only one is allowed. All other contacts should be added to the 'Other Contact(s)' field.
        <cfelseif url.msg is "MultipleMatchPC">
        	 :: The Primary Contact Email Address was found more than once in the Oracle Employee Directory. Please fix the email address if possible. If this problem persists - please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Chris Nicastro</a> to resolve.
        <cfelseif url.msg is "NoMatchPC">
        	 :: The Primary Contact Email Address was not found in the Oracle Employee Directory. Please fix the Primary Contact's Email Address.
		<cfelseif url.msg is "CCError">
			 :: The Other Contact(s) field has an invalid email address - Please fix the Other Contact(s) field.
		<cfelseif url.msg is "No Scope Letter">
			:: The Scope Letter has not been sent. Please complete and the send the Scope Letter before entering the Audit Report.
        <cfelseif url.msg is "InvalidEmail">
        	:: One of the Primary/Other Contacts has an invalid email address - missing @ symbole. Please Correct.
		</cfif><br><br>
	<cfelseif url.var is "AttachA">
		<b><font color="red">Message: #url.Msg#</font></b>
	</cfif><br><br>
</cfif>

<cflock scope="SESSION" timeout="60">
<cfif SESSION.Auth.AccessLevel NEQ "Auditor">
	<CFIF SESSION.Auth.accesslevel is "SU"
		OR SESSION.Auth.accesslevel is "Admin"
		OR SESSION.Auth.Region is "#AuditedBy#"
		OR SESSION.Auth.AccessLevel is "#AuditedBy#"
		OR LeadAuditor is "#SESSION.AUTH.NAME#"
		OR Auditor CONTAINS "#SESSION.AUTH.NAME#"
		OR AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
        <b>Available Actions</b><Br />
        <cfif Approved is 'No'>
    		 - <a href="audit_ok.cfm?#CGI.Query_String#">Approve</a> Audit for Audit Schedule.<br>
			 <CFIF SESSION.Auth.AccessLevel is "SU">
             - <a href="remove.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Remove (Delete) Audit</a><br>
             </CFIF>
    		 - <a href="edit_initial.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Edit</a> Audit.<br />
        <cfelse>
        	<CFIF SESSION.Auth.accesslevel is "SU" AND SESSION.Auth.Username eq "Chris">
            	<cfset nextYear = url.year + 1>
            	 - <a href="_AuditScheduleCopy_ToNextYear.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Copy Audit</a> to #nextYear#<br />
            </CFIF>
    		 - <a href="edit.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Edit</a> Audit<br />
            <cfif auditedby NEQ "Field Services">
                 - <A href="add_files.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Add Files</a> (old format)<br />
            </cfif>
        </cfif>
		 - <a href="javascript:popUp('Status_CompletionNotes.cfm?year=#url.year#&id=#url.id#')">Add/Edit</a> Audit Scope / Audit Report Completion Notes<br>
		<cfif NOT len(Status)>
        	<cfif AuditedBy eq "IQA">
				 - <a href="cancel.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Cancel Audit</a><br>
    		<cfelse>
            	- <a href="cancel_old.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Cancel Audit</a><br>
            </cfif>
             <CFIF SESSION.Auth.AccessLevel is "SU">
             	- <a href="remove.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Remove Audit</a><br>
             </CFIF>
             	<cfif AuditedBy eq "IQA">
				 - <a href="reschedule_new.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Reschedule Audit</a><br>
				<cfelse>
                 - <a href="reschedule.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Reschedule Audit</a><br>
                </cfif>
		<cfelseif status eq "deleted">
			 - <font color="red"><b>Audit Cancelled</b></font> - <a href="uncancel.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Reinstate Audit</a><br>
			 <CFIF SESSION.Auth.AccessLevel is "SU">
             - <a href="remove.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Remove (Delete) Audit</a><br>
             </CFIF>
		</cfif>
    </cfif>
</cfif>
</cflock>

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT baseline.*, baseline.year_ AS "Year"
FROM baseline
WHERE Year_ = <cfqueryparam value="#url.year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<br />

<cfif plan.auditedby is "IQA">
	<cfif baseline.baseline is 0>
		<font color="red"><b>#URL.Year# IQA Audit Schedule is tentative</b></font><br><br>
	</cfif>
</cfif>

<b>#Year#-#ID#-#AuditedBy#</b><br><br>

<b>Location</b><br>
<cfif Trim(ExternalLocation) is "- None -" or NOT len(Trim(ExternalLocation))>
	<!--- NOTE - 2012 and prior had super locations --->
	<cfif Year LTE 2012>
        #OfficeName#<cfif len(Trim(AuditArea))> - #AuditArea#<br /><br /></cfif>

        <!--- Check if this is a Super-Location --->
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
        SELECT SNAPSite, SuperLocation, ID
        FROM IQAtblOffices
        WHERE OfficeName = '#OfficeName#'
        </cfquery>

        <cfif Super.SuperLocation eq "Yes">
            <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SuperLocs">
            SELECT OfficeName
            FROM IQAtblOffices
            WHERE SuperLocationID = #Super.ID#
            ORDER BY OfficeName
            </cfquery>

            <u>Note</u>: The above Super-Location includes the following Locations:<Br />
            <cfloop query="SuperLocs">
            :: #OfficeName#<br />
            </cfloop><br />
        </cfif>
        <!--- /// --->

        <!-- check UL Office for NRTL / SNAP Qualifications --->
        <cfif len(Check.OfficeName)>
            <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
            SELECT SNAPSite, SuperLocation, ID
            FROM IQAtblOffices
            WHERE OfficeName = '#Check.OfficeName#'
            </cfquery>

            <CFIF Super.SuperLocation eq "Yes">
                <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SuperLocs">
                SELECT SNAPSite, SuperLocationID, ID, OfficeName
                FROM IQAtblOffices
                WHERE SuperLocationID = #Super.ID#
                ORDER BY OfficeName
                </cfquery>

                <cfif SuperLocs.recordcount GTE 1>
                    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SuperLocsExist">
                    SELECT SNAPSite, SuperLocationID, ID, OfficeName
                    FROM IQAtblOffices
                    WHERE SuperLocationID = #Super.ID#
                    AND SNAPSite = 'Yes'
                    ORDER BY OfficeName
                    </cfquery>

                    <cfif SuperLocsExist.RecordCount GTE 1>
                        <b>Location Information</b><br>
                        The following location(s) associated with <u>#Check.OfficeName#</u> are SNAP Sites:<br>
                        <cfloop query="SuperLocs">
                            <cfif SNAPSite is "Yes">
                             :: #OfficeName#<br>
                            </cfif>
                        </cfloop><br>
                   </cfif>
                </cfif>
            <cfelse>
                <cfif Super.SNAPSite is "Yes">
                    <b>Location Information</b><br>
                    :: SNAP Site<Br><br>
                </cfif>
            </CFIF>
        </cfif>
        <!--- /// --->
	<!--- 2013 and forward - NO super locations any longer, now multiple offices possible stored in OfficeName column, separated by ! --->
	<cfelse>
		<!--- count the number of offices in the string, we're counting the delimeter (!) and adding 1, since one office would have no delimeters --->
		<cfset numOffices = 1 + (len(OfficeName) - len(replace(OfficeName, "!", "", "All")))>

        <!--- if there is more than one office listed --->
        <cfif numOffices GT 1>
        	<!--- replace the delimeter with a break --->
        	#replace(OfficeName, "!", "<br />", "All")#
    	<!--- if there is one office --->
        <cfelseif numOffices EQ 1>
        	#OfficeName#<br />
        </cfif><br />

      	<!--- add the audit area to the end of the last office name --->
        <cfif len(Trim(AuditArea))
			AND Trim(AuditArea) NEQ Trim(Area)>
                <b>Audit Label</b><br />
                #AuditArea#<br /><br />
        </cfif>

		<!--- CB Audits - list programs --->
		<cfif auditArea is "Certification Body (CB) Audit">
			<CFQUERY BLOCKFACTOR="100" NAME="CBSchemes" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Corporate.ProgDev.Program
			FROM Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
			WHERE CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
			AND CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
			AND CBAudits.Name = '#OfficeName#'
			AND
				(CBAudits_SchemeAssignment.status IS NULL
				OR CBAudits_SchemeAssignment.Status = 'removed' and CBAudits_SchemeAssignment.RemoveYear > #Year#
				OR CBAudits_SchemeAssignment.Status IS NULL AND CBAudits_SchemeAssignment.AddYear <= #year#)
			ORDER BY Corporate.ProgDev.Program
			</cfquery>

			<b>Schemes</b><Br>
			<cfloop query="CBSchemes">
			 :: #Program#<br>
			</cfloop><br>
		</cfif>

		<!--- All QS Audits have a Specific Audit Area, except Field Services --->
        <cfif AuditType is "Quality System" AND AuditType2 is NOT "Field Services">
            <cfif len(Area)>
                <b>Specific Audit Area</b><br />
                #Area#<br /><br />
            </cfif>
        </cfif>

		<cfif AuditedBy eq "IQA">
			<!--- set the listSnapSite list to empty. This list will be populated if any offices are SNAP Sites --->
			<cfset listSNAPSite = "">

			<!-- check UL Office for NRTL / SNAP Qualifications --->
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
			SELECT SNAPSite, ID, OfficeName
			FROM IQAtblOffices
			WHERE OfficeName = '#OfficeName#'
			</cfquery>

			<!-- check UL Office for NRTL / SNAP Qualifications --->
			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SCC">
			SELECT SCCSite, ID, OfficeName
			FROM IQAtblOffices
			WHERE OfficeName = '#OfficeName#'
			</cfquery>
			
			<!---
			<!--- if the listElement/office is a SNAP Site, Append it to the list --->
			<cfif SNAP.SNAPSite eq "Yes">
				<cfset listSNAPSite = ListAppend(listSNAPSite, "#ListElement#", "!")>
			<Cfelse>
			<!--- if the listElement/office is NOT a SNAP site - list stays the same --->
				<cfset listSNAPSite = listSNAPSite>
			</cfif>
			--->

			<!--- check length of the list, if greater than zero, than show the SNAP Sites --->
			<cfif SNAP.SNAPSite EQ 1 AND SCC.SCCSite EQ 1>
			
				<b>Location Information</b><br>
				 :: <u>OSHA SNAP Site</u><br>
				 :: <u>Active SCC Accreditation Status</u><br><br>
			
			<cfelseif SNAP.SNAPSite EQ 1 AND NOT len(SCC.SCCSite)
				OR SNAP.SNAPSite EQ 1 AND SCC.SCCSite EQ 0>
			
				<b>Location Information</b><br>
				 :: <u>OSHA SNAP Site</u><br><br>
			
			<cfelseif SNAP.SNAPSite EQ 0 AND SCC.SCCSite EQ 1
				OR NOT len(SNAP.SNAPSite) AND SCC.SCCSite EQ 1>
			
				<b>Location Information</b><br>
				 :: <u>Active SCC Accreditation Status</u><br><br>

			</cfif>
			<!--- /// --->
		</cfif>
    </cfif>

	<!--- Desk audit --->
    <cfif Desk is "Yes">
    * This Process/Document will be reviewed via <u><font color="800080">Desk Audit</font></u><br><br>
    </cfif>

    <!--- Initial Audit --->
    <cfif InitialSiteAudit eq 1>
        	<cfif AuditType2 eq "Program">
	            <font class="warning">
	            	<u>Note</u>: Initial Audit of this Program
	            </font>
	        <cfelse>
	            <font class="warning">
		            <strong><u>Note</u>: Initial Audit of this Site<br></strong>
	 	        </font>
	 	           If a Laboratory that conducts UL LLC Certification Body activity is included in the scope of this audit, 00-CE-P0851 must be included.
			</cfif>
	    <br /><Br />
    </cfif>
    <!--- /// ---->

    <!--- Business Unit --->
    <cfif Plan.Year GTE 2013>
    	<cfif Plan.AuditedBy eq "IQA">
        	<cfif len(BusinessUnit)>
				<cfif Plan.AuditType2 eq "Local Function" OR Plan.AuditType2 eq "Program" OR Plan.AuditType2 eq "MMS - Medical Management Systems">
                <b>Business Unit(s) Audited</b><br />
                :: #replace(BusinessUnit, ",", "<br /> :: ", "All")#<br /><br />
                </cfif>
			</cfif>
		</cfif>
	</cfif>

    <!--- Accreditor Select / View --->
    <!--- incAccreditations.cfm UPDATED for 2013 - multi-office capability --->
    <cflock scope="SESSION" timeout="60">
    <cfif SESSION.Auth.AccessLevel NEQ "Auditor">
        <CFIF SESSION.Auth.accesslevel is "SU"
            OR SESSION.Auth.accesslevel is "Admin"
            OR SESSION.Auth.Region is "#AuditedBy#"
            OR SESSION.Auth.AccessLevel is "#AuditedBy#"
            OR LeadAuditor is "#SESSION.AUTH.NAME#"
            OR Auditor CONTAINS "#SESSION.AUTH.NAME#">
            <!--- Check for 2011+ IQA Local Function Audits --->
            <cfif AuditedBy EQ "IQA"
                AND Plan.Year EQ 2011
                AND Plan.AuditType2 EQ "Local Function">
                <!--- Of those audits, ONLY Processes, Processes and Labs, and Laboratories need to input Accreditations --->
                <cfif Plan.Area EQ "Processes and Labs"
                    OR Plan.Area EQ "Processes"
                    OR Plan.Area EQ "Laboratories">
                    <!--- include Accreditations add/edit/output --->
                    <cfinclude template="incAccreditations.cfm">
                    <!--- /// --->
                <!--- /// --->
                </cfif>
            <cfelseif AuditedBy EQ "IQA"
                AND Plan.Year GTE 2012
				AND Plan.Year LTE 2013
                AND Plan.AuditType2 EQ "Local Function">
                    <!--- include ALL local function --->
                    <!--- include Accreditations add/edit/output --->
                    <cfinclude template="incAccreditations.cfm">
                    <!--- /// --->
            </cfif>
        </CFIF>
    </cfif>
    </cflock>
    <!--- /// --->

    <cfif len(email) AND email NEQ " ">
    <b>Primary Contact</b> ('To' field of Scope Letter)<br>
    <cfset Dump = #replace(Email, ",", "<br>", "All")#>
    <cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
    #Dump1#
    <br><br>
    <!---
	:: <a href="javascript:popUp('EmailVerify.cfm?ID=#URL.ID#&Year=#URL.Year#&Field=Email')">Verify</a> Primary Contact Email Address (Page will load slowly)<br />
	:: <a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a> - Use UL External Email addresses Only<br><br>
    :: <a href="javascript:sitePopUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br />
	:: <a href="javascript:popUp('EmailEdit.cfm?ID=#URL.ID#&Year=#URL.Year#')">Edit</a> Contacts<br />
	--->
    </cfif>

    <cfif len(email2) AND email2 NEQ " ">
    <b>Other Contacts</b> ('CC' field of Scope Letter)<br>
    <cfset Dump = #replace(Email2, ",", "<br>", "All")#>
    <cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
    #Dump1#
    <br><br>
    <!---
	:: <a href="javascript:popUp('EmailVerify.cfm?ID=#URL.ID#&Year=#URL.Year#&Field=Email2')">Verify</a> Other Contacts Email Addresses (Page will load slowly)<br />
	:: <a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a> - Use UL External Email addresses Only<br><br>
    :: <a href="javascript:sitePopUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br />
	:: <a href="javascript:popUp('EmailEdit.cfm?ID=#URL.ID#&Year=#URL.Year#')">Edit</a> Contacts<br />
	--->
    </cfif>

<cfelse>
#ExternalLocation# <cfif Billable is "Yes">(Billable)<cfelse>(Non-Billable)</cfif><br>
<!---<a href="TPTDP.cfm">View Third Party Certificate List</a><br>---><br>

	<cfif Desk is "Yes">
	* This Client's Quality System will be reviewed via <u><font color="800080">Desk Audit</font></u><br><br>
	</cfif>
</cfif>

<b>Auditor(s)</b><br>
<cfif NOT len(Trim(LeadAuditor)) OR Trim(LeadAuditor) is "- None -">
	<cfif NOT len(Trim(Auditor)) OR Trim(Auditor) is "- None -">
		No Auditors Listed<br /><br />
	<cfelse>
		#replace(Auditor, ",", ", ", "All")#<br /><br />
	</cfif>
<cfelseif NOT len(Trim(Auditor)) OR Trim(Auditor) is "- None -">
    #LeadAuditor#, Lead<br /><br />
<CFELSE>
    #LeadAuditor#, Lead<br />
    <cfset AuditorDump = replace(Auditor, ",", ", ", "All")>
    #replace(AuditorDump, ", ", "<br />", "All")#<br /><br />
</cfif>

<cfif isDefined("AuditorInTraining")>
	<cfif Trim(AuditorInTraining) NEQ "- None -" AND len(AuditorInTraining)>
		<b>Auditor(s) In Training</b><br />
        <cfset AuditorInTrainingFix = replace(AuditorInTraining, "- None -,", "", "All")>
		<cfset AuditorInTrainingDump = replace(AuditorInTrainingFix, ",", ", ", "All")>
		#replace(AuditorInTrainingDump, ", ", "<br />", "All")#<br /><Br />
	</cfif>
</cfif>

<cfif isDefined("SME")>
	<cfif Trim(SME) NEQ "- None -" AND len(SME)>
	<b>Subject Matter Expert (SME)</b><br>
	#SME#<br><br>
	</cfif>
</cfif>

<!--- never used?
<cfif evalu is "Yes">
<b>Observation/Evaluation</b><br>
Evaluator: #EvalAuditor#<br>
<u>Note</u>: See IQA Manager for Evaluation Records<br><br>
</cfif>
--->

<b>Type of Audit</b><br>
<cfif audittype is "TPTDP" or audittype is "Technical Assessment">
	#AuditType#
<cfelse>
	#AuditType#<cfif len(AuditType2)>,
					<cfif AuditArea eq "Scheme Documentation Audit">
						Scheme
					<cfelseif AuditArea eq "Certification Body Operations">
						Certification Body (CB) Audit
					<cfelse>
						#AuditType2#
					</cfif>
				</cfif>
</cfif>
<br><br>

<b>Month Scheduled</b><br />
<cfif not len(trim(month)) OR Month eq 0>
	No month scheduled
<cfelse>
	#MonthAsString(Month)#
</cfif><br><br>

<b>Audit Dates</b><br>
<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">

	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>

	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>

    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#<Br />

<!--- add/edit/clear dates for those with access --->
<cflock scope="SESSION" timeout="60">
    <cfif IsDefined("SESSION.Auth.IsLoggedIn")>
        <CFIF
        SESSION.Auth.accesslevel is "SU" or
        SESSION.Auth.accesslevel is "Admin" or
        SESSION.Auth.Region is "#AuditedBy#" OR
        SESSION.Auth.AccessLevel is "#AuditedBy#" or
        LeadAuditor is "#SESSION.AUTH.NAME#" or
        Auditor CONTAINS "#SESSION.AUTH.NAME#">
        	<cfif AuditType NEQ "TPTDP">
            	<cfif AuditedBy eq "IQA">
					<cfif SESSION.Auth.AccessLevel eq "SU">
                        <a href="add_dates.cfm?#CGI.Query_String#">Add/Change Dates</a><br />
                        <a href="clear_dates.cfm?#CGI.Query_String#">Change Month/Clear Dates</a><br />
                    <cfelse>
                    	<cfif NOT len(StartDate) AND NOT len(EndDate)>
                        	<a href="add_dates.cfm?#CGI.Query_String#">Add Dates</a><br />
                        <cfelse>
                        	<br />
                        </cfif>
					</cfif>
                <cfelse>
                	<a href="add_dates.cfm?#CGI.Query_String#">Add/Change Dates</a><br />
                    <a href="clear_dates.cfm?#CGI.Query_String#">Change Month/Clear Dates</a><br />
				</cfif>
        	</cfif>
		</cfif>
    </cfif>
</cflock>
<!--- // --->
<br />

<cfif AuditedBy eq "IQA" AND Year_ GTE 2015 AND Trim(AuditType) is NOT "TPTDP">
	<B>Audit Days</b>:
	<cfif len(AuditDays)>
		#AuditDays#
	<cfelse>
		None Listed
	</cfif><br><br>
</cfif>

<!--- 8/29/2007 changes made to template file below, see file --->
<cfinclude template="#IQADir#status_colors.cfm">
<!--- /// --->

<!--- Cancel and Reschedule File Upload --->
<cfif Trim(status) is "deleted" AND AuditedBy eq "IQA">
	<br /><br />
    <b>Audit Cancelled Approval File</b><br>
	<cfif isDefined("FileCancel") AND len(FileCancel)>
        <a href="#IQARootDir#CancelFiles/#FileCancel#" target="_blank">View</a> Approval File<br><br />
        <!---
		<Cfif isDefined("CancelRequestFile") AND len(CancelRequestFile)>
			<a href="#IQARootDir#CancelRequestFiles/#CancelRequestFile#">View</a> Cancel Request File<br><br />
		</Cfif>
		--->
        <!---
		<a href="AuditCancel_FileUpload.cfm?ID=#ID#&Year=#Year#">Replace</a> Audit Cancel Attachment<br>
        <a href="AuditCancel_FileUpload.cfm?ID=#ID#&Year=#Year#">Replace</a> Approval Attachment<br><br>
		--->
    <cfelse>
        <a href="AuditCancel_FileUpload.cfm?ID=#ID#&Year=#Year#">Upload</a> Attachment<br><br>
    </cfif>

    <cfif isDefined("CancelNotes") AND len(CancelNotes)>
    <b>Cancel Notes</b><br />
    #CancelNotes#
	</cfif>
<cfelseif Trim(Status) is "deleted" AND AuditedBy NEQ "IQA">
    <br /><br />
    <b>Audit Cancelled</b><br />
    Notes: #CancelNotes#
</cfif>
<!--- /// --->

<!--- Cancel and Reschedule File Upload --->
<cfif Trim(status) is "removed" AND AuditedBy eq "IQA">
<br /><Br /><font color="red">The Audit has been removed from the audit views.</font><br /><br />

    <cflock scope="SESSION" timeout="60">
		<CFIF SESSION.Auth.accesslevel is "SU">
	        <A href="uncancel.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Reinstate Audit</a>
        </CFIF>
    </cflock>

</cfif>
<!--- /// --->

<cfif Trim(Status) neq "deleted" OR NOT len(Status)>
	<cfif Trim(RescheduleStatus) is "Rescheduled" AND Auditedby eq "IQA">
        <br /><Br />
        <b>Audit Rescheduled Approval File</b><br>
        <cfif isDefined("FileReschedule") AND len(FileReschedule)>
            <a href="#IQARootDir#RescheduleFiles/#FileReschedule#" target="_blank">View</a> Approval File<br><br />
            <!---
            <Cfif isDefined("RescheduleRequestFile") AND len(RescheduleRequestFile)>
                <a href="#IQARootDir#RescheduleRequestFiles/#RescheduleRequestFile#">View</a> Reschedule Request File<br><br />
            </Cfif>
            --->
            <!---<a href="AuditReschedule_FileUpload.cfm?ID=#ID#&Year=#Year#">Replace</a> Current Attachment<br><br>--->
        <cfelse>
            <a href="AuditReschedule_FileUpload.cfm?ID=#ID#&Year=#Year#">Upload</a> Attachment<br><br>
        </cfif>

        <b>Reschedule Status</b><br>
        <img src="#IQADir#images/red.jpg" border="0"><br><br>

        <b>Reschedule Notes</b><br>
        #RescheduleNotes#
        <br><br>
	<cfelseif Trim(RescheduleStatus) is "Rescheduled" AND Auditedby NEQ "IQA">
	<b>Audit Rescheduled</b><br /><br />

    <b>Reschedule Status</b><br>
    <img src="#IQADir#images/red.jpg" border="0"><br><br>

    <b>Reschedule Notes</b><br>
    #RescheduleNotes#
	</cfif>
</cfif>

<br /><br />
<b>Scope Letter</b><br>
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU"
	OR SESSION.Auth.accesslevel is "Admin"
	OR SESSION.Auth.Region is "#AuditedBy#"
	OR LeadAuditor is "#SESSION.AUTH.NAME#"
	OR Auditor CONTAINS "#SESSION.AUTH.NAME#"
	OR AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
    <cfif NOT len(Trim(ScopeLetter))>
        No Scope Letter Submitted<br>
		<cfif AuditType2 is "Technical Assessment" OR auditedby is "Field Services">
			<a href="addscopeletter.cfm?#CGI.Query_String#">Add Scope Letter</a><br><br>
		<cfelse>
			<cfif Session.Auth.AccessLevel is "Auditor">
	        	<a href="addscopeletter.cfm?#CGI.Query_String#">Upload Scope Letter</a><br><br>
        	<cfelse>
	        	<cfif Year_ GTE 2010>
					<!---
					<a href="EmailVerify_Scope.cfm?#CGI.Query_String#">Add Scope Letter</a> (Verify Contacts - Enabled)<br>
					--->
					<a href="ScopeLetter_Send.cfm?#CGI.Query_String#&AuditType=#AuditType#&AuditType2=#AuditType2#">Add Scope Letter</a><br>

					<!---
					<u>Note</u> - Use the 'Verify Contacts Disabled' link above if you are certain your contact emails are accurate, but the 'Verify Contacts' link is returning an error.<br>
					--->
					
					<cfif AuditedBy NEQ "IQA">
                        <a href="addscopeletter.cfm?#CGI.Query_String#">Upload Scope Letter</a> (file upload method)<br />
                    </cfif><br>
   				<cfelse>
					<a href="ScopeLetter_Send.cfm?#CGI.Query_String#&AuditType=#AuditType#&AuditType2=#AuditType2#">Add Scope Letter</a><br>
					<a href="addscopeletter.cfm?#CGI.Query_String#">Upload Scope Letter</a> (old method)<br /><br />
				</cfif>
			</cfif>
		</cfif>
	<cfelseif len(Trim(ScopeLetter)) AND Trim(ScopeLetter) is "Entered">
        <A href="ScopeLetter_View.cfm?#CGI.Query_String#">View</a> Scope<br>
        <cfif AuditType NEQ "TPTDP">
        	<a href="ScopeAttachEmail.cfm?#CGI.Query_String#">Upload</a> New Scope Attachment A<br><br>
		<cfelse>
        	<br />
		</cfif>
	<cfelseif len(Trim(ScopeLetter)) AND Trim(ScopeLetter) NEQ "Entered">
        <A href="../scopeletters/#ScopeLetter#?">#ScopeLetter#</a><br>
        <cfif AuditType NEQ "TPTDP">
        	<a href="addscopeletter.cfm?#CGI.Query_String#">Upload New Scope Letter</a> (replaces current file)<br>
    	</cfif><br>
	</cfif>
<cfelse>
<!--- Those who don't have access to change/add scope letter for this audit --->
	<cfif NOT len(Trim(ScopeLetter))>
        No Scope Letter Submitted<br><br />
    <cfelseif len(Trim(ScopeLetter)) AND Trim(ScopeLetter) is "Entered">
        <A href="ScopeLetter_View.cfm?#CGI.Query_String#">View</a> Scope<br><br />
    <cfelseif len(Trim(ScopeLetter)) AND Trim(ScopeLetter) NEQ "Entered">
        <A href="../scopeletters/#ScopeLetter#">#ScopeLetter#</a><br><br>
    </cfif>
</cfif>
</cflock>

<b>Audit Report</b><br>
<cflock scope="SESSION" timeout="5">
<CFIF SESSION.Auth.accesslevel is "SU"
	OR SESSION.Auth.accesslevel is "Admin"
	OR SESSION.Auth.Region is "#AuditedBy#"
	OR LeadAuditor is "#SESSION.AUTH.NAME#"
	OR Auditor CONTAINS "#SESSION.AUTH.NAME#"
	OR AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">

<!--- This section handles adding new style reports and uploading 'old' report formats--->
<cfif len(Trim(Report)) AND Report NEQ "1" AND Report NEQ "2" AND Report NEQ "3" AND Report NEQ "4" AND Report NEQ "5" AND Report NEQ "Entered" AND Report NEQ "Completed">
    <A href="../Reports/#Report#">#Report#</a><br>
        	<cfif AuditType NEQ "TPTDP">
				<cfif len(ReportDate) AND AuditedBy eq "IQA">
    	        	Published - #dateformat(Reportdate, "mm/dd/yyyy")#<br />
        	    </cfif>
			</cfif>
    <cfif AuditType is "TPTDP">
        <!---<a href="TPReport.cfm?#CGI.Query_String#">Add Report</a> (with New Reporting Format)<br>---><br>
    <cfelseif auditedby is "Field Services" OR AuditType2 is "Technical Assessment">
        <a href="addreport.cfm?#CGI.Query_String#">Upload Report</a> (in place of existing report)
        <br><br>
    <cfelse>
        <a href="Report1.cfm?#CGI.Query_String#">Add Report</a> (with New Reporting Format)<br><br>
    </cfif>
<!--- This section handles NEW reporting format --->
 <CFELSE>
	<cfif NOT len(Trim(Report))>
		No Report Submitted<br>
		<cfif AuditType is "TPTDP">
			<!---<a href="TPReport.cfm?#CGI.Query_String#">Add Report</a>--->
		<cfelseif AuditedBy is "Field Services" OR audittype2 is "Technical Assessment">
			<a href="addreport.cfm?#CGI.Query_String#">Add Report</a>
		<cfelse>
			<a href="Report1.cfm?#CGI.Query_String#">Add Report</a>
			<cfif auditedby is NOT "IQA" and auditedby is NOT "Field Services">
				<br><a href="addreport.cfm?#CGI.Query_String#">Upload New Report</a> (file upload method)
			</cfif>
		</cfif><br><br>
	<cfelseif len(Trim(Report))>
		<cfif Report NEQ "Entered" AND Report NEQ "Completed">
        <!--- if the report has been started, but not all pages have been entered --->
            <cfif AuditType is "TPTDP">
                Report Not Completed -
                <!---<A href="TPReport_Edit1.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Resume</a>---><br><br>
            <cfelse>
                Report Not Completed -
                <A href="Report_output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Resume</a><br><br>
            </cfif>
        <cfelseif Report is "Entered">
        <!--- if the all report pages have been entered but the report is not complete (published) --->
            <cfif AuditType is "TPTDP">
                Report Complete, Not Published -
                <!---<A href="TPReport_output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">View</a>--->
                <br><br>
            <cfelse>
                Report Complete, Not Published -
                <A href="Report_output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">View</a>
                <br><br>
            </cfif>
        <cfelseif Report is "Completed">
        <!--- if the report is completed (published) --->
            <cfif AuditType is "TPTDP">
                <A href="TPReport_Output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">
                View</a> Report<br>
                <!---<A href="TPReport_Edit1.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">
                Edit</a> Report<br>---><br>
            <cfelse>
                <A href="Report_Output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">
                View</a> Report<br>
                <A href="Report_Edit1.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">
                Edit</a> Report<br><br>
            </cfif>
        </cfif>
	</cfif>
</cfif>
<!---///--->
<cfelse>
<!--- FOR THOSE NOT ABLE TO EDIT REPORT --->
	<cfif len(Trim(Report))>
		<cfif Report NEQ "1"
			AND Report NEQ "2"
			AND Report NEQ "3"
			AND Report NEQ "4"
			AND Report NEQ "5"
			AND Report NEQ "Entered"
			AND Report NEQ "Completed">
        		<A href="../Reports/#Report#">#Report#</a><br />
	        <cfif len(ReportDate) AND AuditedBy eq "IQA">
	           	Published - #dateformat(Reportdate, "mm/dd/yyyy")#<br />
	        </cfif><br />
		<cfelseif Trim(Report) is "Completed">
	    	<cfif AuditType EQ "TPTDP">
	        	<A href="TPReport_Output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">View</a> Report<br><br>
	        <cfelse>
	            <A href="Report_Output_all.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">View</a> Report<br><br>
	        </cfif>
		<cfelse>
			No Report Published<br><br>
		</cfif>
	<cfelseif NOT len(Trim(Report))>
		No Report Published<br><br>
	</CFIF>
</cfif>
</cflock>

<cfif AuditType2 is "Local Function CBTL">
<b>CBTL Report</b><br>
<cfif Report2 is "Completed">
	<a href="../CBTL/#year#-#id#.pdf">View</a> CBTL Report
<cfelse>
	<a href="addreport.cfm?#CGI.Query_String#">Upload</a> CBTL Report
</cfif>
	<br><br>
</cfif>

<!--- Pathnotes --->
<cfif Year_ GTE 2010>
<b>Audit Pathnotes</b><Br>
	<cfif NOT len(PathNotesFile)>
	No File Uploaded<br>
		<cflock scope="SESSION" timeout="60">
			<CFIF SESSION.Auth.accesslevel is "SU"
				OR SESSION.Auth.accesslevel is "Admin"
				OR SESSION.Auth.Region is "#AuditedBy#"
				OR LeadAuditor is "#SESSION.AUTH.NAME#"
				OR Auditor CONTAINS "#SESSION.AUTH.NAME#"
				OR AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
			<a href="PathNotes_Upload.cfm?#CGI.Query_String#">Upload</a> Pathnotes<br><Br>
			<cfelse>
			<br>
			</cfif>
		</cflock>
	<cfelse>
	<a href="#IQARootDir#Pathnotes/#PathNotesFile#?" target="_blank">View</a> Pathnotes<br>
		<cflock scope="SESSION" timeout="60">
			<CFIF SESSION.Auth.accesslevel is "SU"
				OR SESSION.Auth.accesslevel is "Admin"
				OR SESSION.Auth.Region is "#AuditedBy#"
				OR LeadAuditor is "#SESSION.AUTH.NAME#"
				OR Auditor CONTAINS "#SESSION.AUTH.NAME#"
				OR AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
			<a href="PathNotes_Upload.cfm?#CGI.Query_String#">Replace</a> Current Pathnotes<br><Br>
			<cfelse>
			<br>
			</cfif>
		</cflock>
	</cfif>
</cfif>
<!--- /// --->

<!--- IC Form --->
<cfif Year_ GTE 2010 AND AuditedBy EQ "IQA"><!--- 1 --->
    <cfif AuditType2 eq "Local Function" AND Area EQ "Processes"
    OR AuditType2 eq "Local Function" AND Area EQ "Processes and Labs"
    OR AuditType2 eq "Program" AND OfficeName eq "UL International Demko A/S" AND AuditArea NEQ "Scheme Documentation Audit"
	OR Year_ eq 2014 AND ID eq 78
	OR Year_ eq 2014 AND ID eq 295
	OR Year_ eq 2014 AND ID eq 14
	OR Year_ eq 2014 AND ID eq 109
	OR Year_ eq 2014 AND ID eq 74
	OR Year_ eq 2014 AND ID eq 94
	OR Year_ eq 2014 AND ID eq 83
	OR Year_ eq 2014 AND ID eq 89><!--- 1a --->

	<b>International Certification (IC) Form</b> <A HREF="javascript:popUp('../webhelp/webhelp_ICForm.cfm')">[?]</A><br>
        <!---<cfloop index = "ListElement" list = "#Plan.OfficeName#" delimiters="!">--->
            <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ICForm">
            SELECT ID, IC FROM IQAtblOffices
            WHERE OfficeName = '#OfficeName#'
            </cfquery>

            #OfficeName# -
            <cfif ICForm.IC EQ "Yes" AND AuditArea DOES NOT CONTAIN "Desk Audit of Bangalore"
			 OR AuditType2 eq "Program" AND OfficeName eq "UL International Demko A/S" AND Year_ LTE 2014
			 OR AuditArea eq "Certification Body (CB) Audit" AND OfficeName eq "UL Japan, Inc."
			 OR AuditArea eq "Certification Body (CB) Audit" AND OfficeName eq "UL International Demko A/S"
			 OR AuditArea eq "Certification Body (CB) Audit" AND OfficeName eq "Underwriters Laboratories of Canada Inc."
			 OR AuditArea eq "Certification Body (CB) Audit" AND OfficeName eq "UL LLC (PSE)"
			 OR AuditArea eq "Certification Body (CB) Audit" AND OfficeName eq "UL LLC (IECEx System: UL-US)"
			 OR AuditArea eq "Certification Body (CB) Audit" AND OfficeName eq "UL LLC (IECEE CB Scheme: UL-US)"
			 OR Year_ eq 2014 AND ID eq 78
			 OR Year_ eq 2014 AND ID eq 295
			 OR Year_ eq 2014 AND ID eq 14
			 OR Year_ eq 2014 AND ID eq 109
			 OR Year_ eq 2014 AND ID eq 74
			 OR Year_ eq 2014 AND ID eq 94
			 OR Year_ eq 2014 AND ID eq 83
			 OR Year_ eq 2014 AND ID eq 89><!--- 2 --->
            	<cfif NOT len(ICForm)><!--- 3 --->
                    <cflock scope="SESSION" timeout="60">
                        <CFIF SESSION.Auth.accesslevel is "SU"
                            OR SESSION.Auth.accesslevel is "Admin"
                            OR SESSION.Auth.Region is "#AuditedBy#"
                            OR LeadAuditor is "#SESSION.AUTH.NAME#"
                            OR Auditor CONTAINS "#SESSION.AUTH.NAME#"><!--- 4 --->
                        [<a href="ICForm_Upload.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#ICForm.ID#">Upload</a> IC Form]<br />
                        </cfif><!--- /4 --->
                    </cflock>
                <cfelse><!--- 3 --->
					<cfif Year_ LTE 2012>
                    <a href="#IQARootDir#ICForm/#ICForm#" target="_blank">View IC Form</a> ::
                        <cflock scope="SESSION" timeout="60">
                            <CFIF SESSION.Auth.accesslevel is "SU"
                                OR SESSION.Auth.accesslevel is "Admin"
                                OR SESSION.Auth.Region is "#AuditedBy#"
                                OR LeadAuditor is "#SESSION.AUTH.NAME#"
                                OR Auditor CONTAINS "#SESSION.AUTH.NAME#"><!--- 5 --->
                           [<a href="ICForm_Upload.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#ICForm.ID#">Replace</a> Current IC Form]<br />
                            </cfif><!--- /5 --->
                        </cflock>
                	<cfelseif Year_ GTE 2013>
                    	<cfif ICForm CONTAINS "#URL.Year#-#URL.ID#-#ICForm.ID#-ICForm">
                        <a href="#IQARootDir#ICForm/#ICForm#" target="_blank">View IC Form</a> ::
                            <cflock scope="SESSION" timeout="60">
                                <CFIF SESSION.Auth.accesslevel is "SU"
                                    OR SESSION.Auth.accesslevel is "Admin"
                                    OR SESSION.Auth.Region is "#AuditedBy#"
                                    OR LeadAuditor is "#SESSION.AUTH.NAME#"
                                    OR Auditor CONTAINS "#SESSION.AUTH.NAME#"><!--- 5 --->
                               [<a href="ICForm_Upload.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#ICForm.ID#">Replace</a> Current IC Form]<br />
                                </cfif>
                            </cflock>
                    	<cfelse>
                            <cflock scope="SESSION" timeout="60">
                                <CFIF SESSION.Auth.accesslevel is "SU"
                                    OR SESSION.Auth.accesslevel is "Admin"
                                    OR SESSION.Auth.Region is "#AuditedBy#"
                                    OR LeadAuditor is "#SESSION.AUTH.NAME#"
                                    OR Auditor CONTAINS "#SESSION.AUTH.NAME#"><!--- 4 --->
                                [<a href="ICForm_Upload.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#ICForm.ID#">Upload</a> IC Form]<br />
                                </cfif><!--- /4 --->
	                        </cflock>
                        </cfif>
                    </cfif>
            	</cfif><!--- /3 --->
			<cfelse>
            	Not Required<br>
            </cfif><!--- /2 --->
		<!---</cfloop><br />--->
    </cfif><!--- /1a --->
</cfif><!--- 1 --->
<!--- /// --->
<br>

<cfif Trim(Year) is "2004" and Trim(ID) is 55>
<b>Audit Plan</b>
<br><A href="../Plans/#Plan#">#Plan#</a><br><br>
<cfelse>
</cfif>

<cfif Trim(AuditType) is NOT "TPTDP">
<CFELSE>
<cfif NOT len(Trim(FollowUp))>
<b>Audit Follow-Up</b><br>
No Follow-Up Submitted<br>
<!---
<cflock scope="SESSION" timeout="60">
<cfif session.auth.accesslevel is NOT "SU" AND session.auth.accesslevel is NOT "admin" AND Session.Auth.accesslevel is NOT "IQAAuditor" AND Session.Auth.AccessLevel is NOT "Auditor" AND LeadAuditor is NOT Session.Auth.Name>
<a href="addfollowup.cfm?#CGI.Query_String#&auditedby=#AuditedBy#">Upload Follow-Up and Close Out Letter File</a><br><br>
<cfelse>
<a href="car_response.cfm?#CGI.Query_String#&auditedby=#AuditedBy#">Add Follow-Up/Close Out Letter</a><br><br>
</cfif>
</cflock>
--->
<cfelseif FollowUp is "Notes">
<b>Follow Up</b><br>
No FollowUp - <a href="#IQARootDir#TPTDP_Notes.cfm?externallocation=#externallocation#">View</a> Client Notes<br>
<!---
<cflock scope="SESSION" timeout="60">
<cfif session.auth.accesslevel is NOT "SU" AND session.auth.accesslevel is NOT "admin" AND Session.Auth.accesslevel is NOT "IQAAuditor" AND Session.Auth.AccessLevel is NOT "Auditor" AND LeadAuditor is NOT Session.Auth.Name>
<a href="addfollowup.cfm?#CGI.Query_String#&auditedby=#AuditedBy#">Upload Follow-Up and Close Out Letter File</a><br><br>
<cfelse>
<a href="car_response.cfm?#CGI.Query_String#&auditedby=#AuditedBy#">Add Follow-Up/Close Out Letter</a><br><br>
</cfif>
</cflock>
--->
<cfelse>
<b>Follow Up</b>
<cfif followup is "Entered">
<br><a href="followup_view.cfm?#CGI.Query_String#">View</a> Follow Up Letter<br><br>
<cfelse>
<br><A href="../FollowUps/#FollowUp#">#FollowUp#</a><br><br>
</cfif>
</cfif>
</cfif>

<cfif Trim(AuditType) is NOT "TPTDP">
    <!--- URL.Year LTE 2012 --->
    <cfif URL.Year LTE 2012>
        <b>Key Processes</b><br />
        <cfif Trim(KP) is "- None -">
            None Specified<br><br>
        <cfelse>
            <cfset Dump0 = #replace(KP, "NoChanges", "", "All")#>
            <cfset Dump1 = #replace(Dump0, ",", "<br>", "All")#>
            #Dump1#
            <br><br>
        </cfif>
	</cfif>

    <!--- Reference Documents --->
    <cfinclude template="../incRD.cfm">
</cfif>

<b>Scope</b><br>
<cfif Year GTE 2016>
	<cfif AuditType2 eq "MMS - Medical Management Systems">
	#Request.MMSScope#
	<cfelse>
	#Request.IQAScope2016#
	</cfif>
<cfelseif Year EQ 2015>
	#Request.IQAScope2015#
<cfelse>
	<cfset dump = #replace(Scope, "<p>", "", "All")#>
	<cfset dump1 = #replace(dump, "</p>", "", "All")#>
	#dump1#
</cfif>
<br><br>

<a name="Notes"></a>
<b>Notes</b><br>
<cfif len(Notes)>
#notes#
<cfelse>
No Notes Added
</cfif><br><br>

<cfif Trim(AuditType) is NOT "TPTDP">
	<b>Notes to the Lead Auditor</b><br>
	<cfif len(NotesToLeadAuditor)>
		#NotesToLeadAuditor#
	<cfelse>
		No Notes Added
	</cfif><br><br>
</cfif>

<cfif Trim(AuditType) is NOT "TPTDP">
	<cflock scope="SESSION" timeout="60">
		<cfif SESSION.Auth.Username eq "Chris">
	    	<b>Auditor Edit Log</b><br />
	        #Auditor_ChangeLog#<Br /><br />
	    </cfif>
	</cflock>
</cfif>

<cfif isDefined("CompletionNotes")>
	<cfif len(CompletionNotes)>
	<b>Audit Scope / Audit Report Completion Notes:</b> [<a href="javascript:popUp('Status_CompletionNotes.cfm?year=#url.year#&id=#url.id#')">Edit</a>]
	<br>
	#CompletionNotes#<br><br>
	</cfif>
</cfif>

<cfif isdefined("Scheduler")>
	<cfif Scheduler is NOT "">
        <b>Audit Scheduled By:</b><br>
        #Scheduler#<br><br>
    </cfif>
</cfif>

</cfif>

<!--- Survey --->
<cfif Year EQ 2014 AND Month GTE 4
	OR Year GT 2014>

    <CFQUERY BLOCKFACTOR="100" name="Survey" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT *
    FROM AuditSurvey_Users
    WHERE AuditYear = #URL.Year#
    AND AuditID = #URL.ID#
    ORDER BY SentDate, SentTo
    </CFQUERY>

	<cfif Survey.RecordCount GT 0>
		<b>Audit Survey</b><br />
		<table border="1">
            <tr>
                <th>Sent To</th>
                <th>Sent Date</th>
                <th>Response</th>
                <th>View Survey</th>
            </tr>
            <cfloop query="Survey">
            <tr>
                <td><cfif SentTo eq "Referred">Referral<cfelse>#SentTo#</cfif></td>
                <td align="center"><cfif len(SentDate)>#dateformat(SentDate, "mm/dd/yyyy")#<cfelse>--</cfif></td>
                <td align="center"><Cfif Responded eq "Yes">#dateformat(Posted, "mm/dd/yyyy")#<cfelse>No</Cfif></td>
                <td align="center"><cfif Responded eq "yes"><a href="#IQADir#AuditSurvey_Details.cfm?UserID=#ID#">View</a><cfelse>--</cfif></td>
            </tr>
            </cfloop>
        </table>
	</cfif>
</cfif><br />
<!--- /// Survey /// --->

</CFOUTPUT>

<cfif plan.AuditedBy EQ "IQA">
    <cflock scope="SESSION" timeout="60">
		<CFIF SESSION.Auth.accesslevel is "SU"
            OR SESSION.Auth.accesslevel is "Admin"
            OR SESSION.Auth.SubRegion is "#Plan.AuditedBy#"
            OR SESSION.Auth.AccessLevel is "IQAAuditor"
			OR Plan.Auditor CONTAINS "#SESSION.AUTH.NAME#"
			OR Plan.LeadAuditor is "#SESSION.Auth.Name#">

            <!--- changed on 11/20/2012 to give all auditors access to view
			OR Plan.LeadAuditor is "#SESSION.AUTH.NAME#"
            OR Plan.Auditor CONTAINS "#SESSION.AUTH.NAME#"
			--->

			<!--- SNAP Data --->
            <cfif  Plan.Year GTE 2010
                AND Plan.AuditType2 EQ "Local Function"
                AND Plan.Area EQ "Processes and Labs"
                OR
                Plan.Year GTE 2010
                AND Plan.AuditType2 EQ "Local Function"
                AND Plan.Area EQ "Processes"
				AND Plan.AuditArea NEQ "Certification Body (CB) Audit"
                OR
                Plan.Year GTE 2010
                AND Plan.Area EQ "Data Acceptance Programs (DAP)"
                AND Plan.AuditArea NEQ "Data Acceptance Program">

<cfif Plan.Year LTE 2012>
<b>OSHA SNAP Data</b><br>

    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM xSNAPData
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    ORDER BY ID, AuditYear, AuditID, AuditOfficeNameID
    </cfquery>

    <cfif SNAPData.recordcount eq 0>
    No Records Exist<br>
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
        SELECT SuperLocation, ID FROM IQAtblOffices
        WHERE OfficeName = '#Plan.OfficeName#'
        </cfquery>

        <cfif Super.SuperLocation eq "Yes">
            <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="selOffice">
            SELECT OfficeName, ID
            FROM IQAtblOffices
            WHERE SuperLocationID = #Super.ID#
            ORDER BY OfficeName
            </cfquery>

            <cfoutput query="selOffice">
                :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#&OfficeID=#ID#"><b>Add</b></a> SNAP Data for #OfficeName#<br>
            </cfoutput><br>
        <cfelse>
            <!--- for the SNAP DAP 1 and 2 audits --->
            <cfif Plan.OfficeName eq "Global">
                <Cfoutput>
                    :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#"><b>Add</b></a> SNAP Data<br><br>
                </CFOUTPUT>
            <cfelse>
                <cfoutput>
                    :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#&OfficeID=#Super.ID#"><b>Add</b></a> SNAP Data for #Plan.OfficeName#<br><br>
                </cfoutput>
            </cfif>
        </cfif><br>
    <cfelse>
    <!--- some or all records exist --->
            <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
            SELECT SuperLocation, OfficeName, ID FROM IQAtblOffices
            WHERE OfficeName = '#Plan.OfficeName#'
            </cfquery>

            <cfif Super.SuperLocation eq "Yes">
                <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="selOffice">
                SELECT OfficeName, ID
                FROM IQAtblOffices
                WHERE SuperLocationID = #Super.ID#
                ORDER BY OfficeName
                </cfquery>

                <cfoutput query="selOffice">
                    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
                    SELECT * FROM xSNAPData
                    WHERE AuditID = #URL.ID#
                    AND AuditYear = #URL.Year#
                    AND AuditOfficeNameID = #ID#
                    </cfquery>

                    <cfif SNAPData.recordcount gt 0>
                    	:: <a href="DAP_SNAP_Review.cfm?ID=#SNAPData.AuditID#&Year=#SNAPData.AuditYear#&OfficeID=#ID#">View</a> #SNAPData.AuditYear#-#SNAPData.AuditID#-IQA - #selOffice.OfficeName#<br>
                    <cfelse>
                    	:: <a href="DAP_SNAP_Add.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#ID#"><b>Add</b></a> OSHA SNAP Data for #selOffice.OfficeName#<br>
                    </cfif>
                </cfoutput><br>
            <cfelseif Plan.OfficeName EQ "Global">
				<!--- SNAP DAP for DAP1 and DAP2 audits --->
                <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT *
                FROM xSNAPData
                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                ORDER BY AuditOfficeNameID
                </cfquery>

                <cfif SNAPData.recordcount gt 0>
					<cfoutput>
                        :: <a href="DAP_SNAP_Add.cfm?ID=#URL.ID#&Year=#URL.Year#"><b>Add</b></a> OSHA SNAP Data<br>
                    </cfoutput>

					<cfoutput query="SNAPData" group="AuditOfficeNameID">
                        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="vOffice">
                        SELECT OfficeName FROM IQAtblOffices
                        WHERE ID = #AuditOfficeNameID#
                        </cfquery>
                            :: <a href="DAP_SNAP_Review.cfm?ID=#AuditID#&Year=#AuditYear#&OfficeID=#AuditOfficeNameID#">View</a> #AuditYear#-#AuditID#-IQA - #vOffice.OfficeName#<br>
                    </cfoutput><br>
                <cfelse>
					<Cfoutput>
                        :: <a href="DAP_SNAP_Add.cfm?ID=#URL.ID#&Year=#URL.Year#"><b>Add</b></a> OSHA SNAP Data<br>
                    </CFOUTPUT>
                </cfif>
            <cfelse>
				<!--- regular office --->
                <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT * FROM xSNAPData
                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                AND AuditOfficeNameID = #Super.ID#
                </cfquery>

                <Cfoutput>
                    <cfif SNAPData.recordcount gt 0>
                    :: <a href="DAP_SNAP_Review.cfm?ID=#SNAPData.AuditID#&Year=#SNAPData.AuditYear#&OfficeID=#Super.ID#">View</a> #SNAPData.AuditYear#-#SNAPData.AuditID#-IQA - #Super.OfficeName#<br>
                    <cfelse>
                    :: <a href="DAP_SNAP_Add.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#Super.ID#"><b>Add</b></a> OSHA SNAP Data for #Super.OfficeName#<br>
                    </cfif>
                </CFOUTPUT><br>
            </cfif>
	</cfif>
<!--- 2013 + --->
<Cfelse>
<b>OSHA SNAP Data</b><br>
	<cfloop index="ListElement" delimiters="!" list="#Plan.Officename#">
        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="getOffice">
        SELECT ID, OfficeName, SNAPAudit
        FROM IQAtblOffices
        WHERE OfficeName = '#trim(listElement)#'
        </cfquery>

        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM xSNAPData
        WHERE AuditID = #URL.ID#
        AND AuditYear = #URL.Year#
        </cfquery>

		<cfif getOffice.SNAPAudit eq "Yes">
			<cfif SNAPData.recordcount eq 0>
                <!--- for the SNAP DAP 1 and 2 audits --->
                <cfif Plan.OfficeName eq "Global">
                    <Cfoutput>
                        :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#&OfficeID=#getOffice.ID#"><b>Add</b></a> SNAP Data<br>
                    </CFOUTPUT>
                <cfelse>
                    <cfoutput>
                        :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#&OfficeID=#getOffice.ID#"><b>Add</b></a> SNAP Data for #trim(listElement)#<br>
                    </cfoutput>
                </cfif>
            <cfelse>

        	<!--- some or all records exist --->
            <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Super">
            SELECT SuperLocation, OfficeName, ID FROM IQAtblOffices
            WHERE OfficeName = '#trim(ListElement)#'
            </cfquery>

            <cfif Plan.OfficeName EQ "Global">
                <!--- SNAP DAP for DAP1 and DAP2 audits --->
                <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT *
                FROM xSNAPData
                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                ORDER BY AuditOfficeNameID
                </cfquery>

                <cfif SNAPData.recordcount gt 0>
                    <cfoutput>
                        :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#"><b>Add</b></a> OSHA SNAP Data<br>
                    </cfoutput>

                    <cfoutput query="SNAPData" group="AuditOfficeNameID">
                        <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="vOffice">
                        SELECT OfficeName FROM IQAtblOffices
                        WHERE ID = #AuditOfficeNameID#
                        </cfquery>
                            :: <a href="DAP_SNAP_Review.cfm?ID=#AuditID#&Year=#AuditYear#&OfficeID=#AuditOfficeNameID#">View</a> #AuditYear#-#AuditID#-IQA - #vOffice.OfficeName#<br>
                    </cfoutput>
                <cfelse>
                    <Cfoutput>
                        :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#"><b>Add</b></a> OSHA SNAP Data<br>
                    </CFOUTPUT>
                </cfif>
            <cfelse>
                <!--- regular office --->
                <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPData" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT * FROM xSNAPData
                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                AND AuditOfficeNameID = #getOffice.ID#
                </cfquery>

                <Cfoutput>
                    <cfif SNAPData.recordcount gt 0>
                    :: <a href="DAP_SNAP_Review.cfm?ID=#Plan.ID#&Year=#Plan.Year#&OfficeID=#getOffice.ID#">View</a> #URL.Year#-#URL.ID#-IQA - #trim(listElement)#<br>
                    <cfelse>
                    :: <a href="DAP_SNAP_Add.cfm?ID=#Plan.ID#&Year=#Plan.Year#&OfficeID=#getOffice.ID#"><b>Add</b></a> OSHA SNAP Data for #trim(listElement)#<br>
                    </cfif>
                </CFOUTPUT>
            </cfif>
        </cfif>
		<cfelse>
        	<cfoutput>
            	#trim(listElement)# - Not Required<br />
            </cfoutput>
		</cfif>
	</cfloop><br />
</cfif>
</cfif>
</cfif>
</cflock>
</cfif>

	<cfif plan.AuditedBy EQ "IQA">
		<cfoutput query="baseline">
            <cfif baseline is 0>
                <font color="red"><b>#url.year# IQA Audit Schedule is tentative.</b></font><br><br />
            </cfif>
        </cfoutput>
	</cfif>

<!--- check for past and future audits --->
<cfif plan.AuditedBy EQ "IQA" AND Plan.Year_ GTE 2008>
	<cfoutput query="Plan">
		<cfinclude template="#IQARootDir#incPastAudits.cfm">
	</cfoutput>
</cfif>
<!--- /// --->

<cfelse>
	<cfoutput>
	<br>
	Audit #URL.Year#-#URL.ID# does not exist.
	</cfoutput>
</cfif>

<!--- if no url items --->
<cfelse>
	No Audit Number was specified.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->