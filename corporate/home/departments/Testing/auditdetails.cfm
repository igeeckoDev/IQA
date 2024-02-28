<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="webhelp/webhelp.js"></script>

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
    SELECT AuditSchedule.ID, "AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditedBy, AuditSchedule.OfficeName, AuditSchedule.ExternalLocation,
	AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.Area, AuditSchedule.AuditType2,
	AuditSchedule.AuditType, AuditSchedule.AuditArea, AuditSchedule.Scope, AuditSchedule.Report, AuditSchedule.Plan, AuditSchedule.ScopeLetter,
	AuditSchedule.FollowUp, AuditSchedule.Status, AuditSchedule.RescheduleStatus, AuditSchedule.Approved, AuditSchedule.KP, AuditSchedule.RD,
	AuditSchedule.Notes, AuditSchedule.RescheduleNotes, AuditSchedule.Month, AuditSchedule.Email, AuditSchedule.RescheduleNextYear,
	AuditSchedule.Agenda, AuditSchedule.ASContact, AuditSchedule.SiteContact, AuditSchedule.ScopeLetterDate, AuditSchedule.Desk,
	AuditSchedule.Report2, ExternalLocation.ExternalLocation, ExternalLocation.Type, ExternalLocation.Billable, ExternalLocation.Address1,
	ExternalLocation.Address2, ExternalLocation.Address3, ExternalLocation.Address4, ExternalLocation.KC, ExternalLocation.KCEmail

    FROM AuditSchedule, ExternalLocation

    WHERE AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
    AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    AND AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
    </CFQUERY>
</cfif>

<cfif Check.RecordCount neq 0>
	<cfif Check.Approved eq "Yes">
        <cflock scope="session" timeout="6">
            <cfif isDefined("SESSION.Auth.isLoggedIn")>
                <cfif SESSION.Auth.AccessLevel eq "SU"
                    OR SESSION.Auth.AccessLevel eq "Admin"
                    OR SESSION.Auth.AccessLevel eq "IQAAuditor"
                    OR SESSION.Auth.AccessLevel eq "Laboratory Technical Audit" AND Plan.AuditedBy eq "LAB"
                    OR SESSION.Auth.AccessLevel eq "Verification Services" AND Plan.AuditedBy eq "VS"
					OR SESSION.Auth.AccessLevel eq "UL Environment" AND Plan.AuditedBy eq "ULE"
					OR SESSION.Auth.AccessLevel eq "RQM" AND Plan.AuditedBy eq "Medical"
					OR Plan.Auditor CONTAINS "#SESSION.AUTH.NAME#"
					OR Plan.LeadAuditor is "#SESSION.Auth.Name#">
                    <cfoutput>
                        You are currently logged in:<br />
                        Go To <b><a href="#IQADir_Admin#auditdetails.cfm?#CGI.QUERY_STRING#">Admin View</a></b><br /><br />
                    </cfoutput>
                </cfif>
            </cfif>
        </cflock>

Audit Details / Audit Status Legend Help - <A HREF="javascript:popUp('webhelp/webhelp_auditdetails.cfm')">[?]</A><br><br />

<CFOUTPUT query="Plan">
<cfif AuditedBy is "AS"
	OR AuditedBy is "QRS"
	OR AuditType2 is "Accred"
	OR AuditedBy is "Finance"
	OR AuditedBy is "ULE" AND AuditType is "Accred"
	OR AuditedBy is "VS" AND AuditType is "Accred"
	OR AuditedBy is "WiSE" AND AuditType is "Accred">

<cfif auditedby is "AS">
	<b>#AuditedBy#-#Year#-#ID#</b>
<cfelse>
	<b>#Year#-#ID#-#AuditedBy#</b>
</cfif><br><br>

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
#DateOutput#<Br /><br />

<cfinclude template="status_colors_AS.cfm">

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

<cfif auditedby is "AS">
<b>Report</b><br>
	<cfif NOT len(Trim(Report))>
		No Report Submitted
	<cfelse>
		<A href="Reports/#Report#">#Report#</a>
	</cfif><br><br>

<b>Agenda</b><br>
	<cfif NOT len(Trim(Agenda))>
		No Agenda Submitted
	<cfelse>
		<A href="scopeletters/#Agenda#">#Agenda#</a>
	</cfif><br><br>
</cfif>

<cfif auditedby NEQ "AS"
	AND auditedby NEQ "Finance"
	AND auditedby NEQ "QRS"
	AND auditedby NEQ "WiSE"
	AND auditedby NEQ "VS">

    <b>Report</b><br>
	<cfif len(Trim(Report))>
	    <A href="Reports/#Report#?">View Report</a><br><br>
    </cfif>
</cfif>

<cfif auditedby is "Finance">
<b>Scope Letter</b><br>
	<cfif NOT len(Trim(ScopeLetter))>
		No Scope Letter Submitted
	<cfelse>
		<A href="scopeletters/#ScopeLetter#">View Scope Letter</a>
	</cfif><br /><br />
</cfif>

<cfif auditedby is "AS" or AuditType2 is "Accred" or auditedby is "Finance">
    <b>Scope<cfif AuditedBy is "Finance">/Notes</cfif></b><br>
    #Scope#<br><br>
<cfelse>
    <b>Scope/Report</b><br>
    <b>DMS File Number:</b><br>
    #Scope#<br><br>
</cfif>

<cfif Status is "Deleted">
<b>Cancellation Notes</b><br>
#Notes#<br><br>
</cfif>

<cfif isdefined("Scheduler")>
	<cfif len(Scheduler)>
		<b>Audit Scheduled By:</b><br>
		#Scheduler#
	</cfif>
</cfif><br><br>

<cfelseif AuditedBy is "LAB"
	OR AuditedBy is "ULE" AND AuditType NEQ "Accred"
	OR AuditedBy is "VS" AND AuditType NEQ "Accred"
	OR AuditedBy is "WiSE" AND AuditType NEQ "Accred">
<!--- Laboratory Technical Audits --->
	<cfinclude template="incAuditDetails_LTA.cfm">
<cfelseif AuditedBy is "TechnicalAudit">
	<!--- Technical Audit --->
	<!---
		<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.QUERY_STRING#" addtoken="no">
	--->

<cfelse>
<!--- IQA and Regional (Quality) Audits --->

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT baseline.*, baseline.year_ AS "Year" FROM baseline
WHERE Year_ = <cfqueryparam value="#url.year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<br />

<cfif plan.auditedby is "IQA">
	<cfif baseline.baseline is 0>
		<font color="red"><b>#URL.Year# IQA Audit Schedule is tentative</b></font><br><br>
	</cfif>
</cfif>

<b>#Year#-#ID#-#AuditedBy#</b>
<br><br>

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
			AND (CBAudits_SchemeAssignment.status IS NULL
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
	</cfif>

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

	<!--- Accreditor View --->
    <!--- Check for 2011+ IQA Local Function Audits --->
    <cfif AuditedBy EQ "IQA"
        AND Plan.Year EQ 2011
        AND Plan.AuditType2 EQ "Local Function">
        <!--- Of those audits, ONLY Processes and Labs and Laboratories need to input Accreditations --->
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
            <!--- include Accreditations add/edit/output --->
            <cfinclude template="incAccreditations.cfm">
            <!--- /// --->
    <!--- /// --->
    </cfif>
    <!--- /// --->

	<cfif len(email) AND email NEQ " ">
    <b>Primary Contact</b><br>
    <cfset Dump = #replace(Email, ",", "<br>", "All")#>
    <cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
    #Dump1#
    <br><br>
    </cfif>

    <cfif len(email2) AND email2 NEQ " ">
    <b>Other Contacts</b><br>
    <cfset Dump = #replace(Email2, ",", "<br>", "All")#>
    <cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
    #Dump1#
    <br><br>
    </cfif>

<cfelse>
<!--- If Audit is TPTDP --->
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
    <cfset AuditorFix = replace(Auditor, "- None -,", "", "All")>
    <cfset AuditorDump = replace(AuditorFix, ",", ", ", "All")>
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
#DateOutput#
<br /><br />

<!--- 8/29/2007 changes made to template file below, see file --->
<cfinclude template="status_colors.cfm">
<!--- /// --->

<cfif Trim(RescheduleStatus) is "Rescheduled" AND Trim(Status) NEQ "deleted">
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

<cfif Trim(Status) eq "deleted">
<b>Audit Cancelled</b><br />
#CancelNotes#<br /><br />
</cfif>

<!--- Cancel and Reschedule File Upload --->
<cfif AuditedBy eq "IQA">
	<cfif Trim(RescheduleStatus) is "Rescheduled">
        <cfif isDefined("FileReschedule") AND len(FileReschedule)>
            <b>Audit Rescheduled</b><br>
                <a href="#IQARootDir#RescheduleFiles/#FileReschedule#" target="_blank">View</a> Attachment<br><br>
        </cfif>
    </cfif>
    <cfif Trim(status) is "deleted">
        <cfif isDefined("FileCancel") AND len(FileCancel)>
            <b>Audit Cancelled</b><br>
                <a href="#IQARootDir#CancelFiles/#FileCancel#" target="_blank">View</a> Attachment<br><br>
        </cfif>
    </cfif>
</cfif>
<!--- /// --->

<cfif RescheduleNextYear NEQ "Yes">
    <b>Scope Letter</b><br>
	<cfif NOT len(Trim(ScopeLetter))>
        No Scope Letter Submitted<br><br />
    <cfelseif len(Trim(ScopeLetter)) AND Trim(ScopeLetter) is "Entered">
        <A href="ScopeLetter_View.cfm?ID=#ID#&Year=#Year#">View</a> Scope<br />
			<cfif len(ScopeLetterDate)>
            	Sent - #dateformat(ScopeLetterDate, "mm/dd/yyyy")#
			</cfif><br><br />
    <cfelseif len(Trim(ScopeLetter)) AND Trim(ScopeLetter) NEQ "Entered">
        <A href="scopeletters/#ScopeLetter#?">#ScopeLetter#</a><br><br>
    </cfif>
</cfif>

<cfif RescheduleNextYear NEQ "Yes">
	<b>Audit Report</b><br />
	<cfif len(Trim(Report)) AND Report NEQ "1" AND Report NEQ "2" AND Report NEQ "3" AND Report NEQ "4" AND Report NEQ "5" AND Report NEQ "Entered" AND Report NEQ "Completed">
        <A href="Reports/#Report#">#Report#</a><br />
		<cfif AuditType NEQ "TPTDP">
			<cfif len(ReportDate) AND AuditedBy eq "IQA">
            	Published - #dateformat(Reportdate, "mm/dd/yyyy")#<br />
            </cfif>
		</cfif>
		<br />
    <CFELSE>
		<cfif NOT len(Trim(Report))>
            No Report Submitted<br /><br />
        <cfelseif len(Trim(Report)) AND Trim(Report) NEQ "Completed">
            No Report Submitted<br /><br />
        <cfelseif len(Trim(Report)) AND Trim(Report) is "Completed">
            <cfif AuditType is "TPTDP">
                <A href="TPReport_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
                View</a> Report<br><br>
            <cfelse>
                <A href="Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
                View</a> Report<br>
		        	<cfif AuditType NEQ "TPTDP">
						<cfif len(ReportDate) AND AuditedBy eq "IQA">
		    	        	Published - #dateformat(Reportdate, "mm/dd/yyyy")#
		        	    </cfif>
					</cfif>
                <Br /><br />
            </cfif>
        <cfelseif len(Trim(Report))
                AND Report EQ "1"
                AND Report EQ "2"
                AND Report EQ "3"
                AND Report EQ "4"
                AND Report EQ "5"
                AND Report EQ "Entered">
            No Report Submitted<br><Br />
        </cfif>
      </cfif>
</cfif>

<cfif RescheduleNextYear NEQ "Yes">
	<cfif AuditType2 is "Local Function CBTL">
	<b>CBTL Report</b><br>
		<cfif Report2 is "Completed">
			<a href="CBTL/#year#-#id#.pdf">View</a> CBTL Report
		<cfelse>
			No CBTL Report Submitted
		</cfif>
		<br><br>
	</cfif>
</cfif>

<!--- Pathnotes --->
<cfif AuditType NEQ "TPTDP" AND Year_ GTE 2010>
<b>Audit Pathnotes</b><Br>
	<cfif NOT len(PathNotesFile)>
		No File Uploaded
	<cfelse>
		<a href="#IQARootDir#Pathnotes/#PathNotesFile#?" target="_blank">View</a> Pathnotes
	</cfif><br><br>
</cfif>
<!--- /// --->

<!---
<!--- IC Form --->
<cfif AuditedBy eq "IQA" AND AuditType2 eq "Local Function" AND Year_ GTE 2010 AND Area EQ "Processes"
OR AuditedBy eq "IQA" AND AuditType2 eq "Local Function" AND Year_ GTE 2010 AND Area EQ "Processes and Labs"
OR AuditedBy eq "IQA" AND AuditType2 eq "Program" AND Year_ GTE 2010 AND OfficeName eq "UL International Demko A/S">

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ICForm">
	SELECT IC FROM IQAtblOffices
	WHERE OfficeName = '#Plan.OfficeName#'
	</cfquery>

	<cfif AuditType2 eq "Local Function" AND ICForm.IC EQ "Yes"
	OR AuditType2 eq "Program" AND OfficeName eq "UL International Demko A/S">

		<b>International Certification (IC) Form</b> <A HREF="javascript:popUp('webhelp/webhelp_ICForm.cfm')">[?]</A><br>
		<cfif NOT len(ICForm)>
			No File Uploaded
		<cfelse>
			<a href="#IQARootDir#ICForm/#ICForm#">View IC Form</a>
		</cfif><br><br>
	</cfif>
</cfif>
<!--- /// --->
--->

<!--- IC Form --->
<cfif Auditedby EQ "IQA" AND URL.Year GTE 2010>
	<cfif Len(ICForm)>
		<b>International Certification (IC) Form</b> <A HREF="javascript:popUp('webhelp/webhelp_ICForm.cfm')">[?]</A><br>
		<a href="#IQARootDir#ICForm/#ICForm#" target="_blank">View IC Form</a><br><br>
	</cfif>
</cfif>
<!--- /// --->

<!--- special condition for Audit Plan 2004-55 --->
<cfif Trim(Year) is "2004" and Trim(ID) is 55>
<b>Audit Plan</b>
<br><A href="Plans/#Plan#">#Plan#</a><br><br>
</cfif>
<!--- /// --->

<cfif Trim(AuditType) IS "TPTDP">
<b>Audit Follow-Up</b><br>
	<cfif len(Trim(FollowUp))>
		<cfif FollowUp is "Notes">
			No FollowUp - <a href="TPTDP_Notes.cfm?externallocation=#externallocation#">View</a> Client Notes
		<cfelseif FollowUp is "Entered">
			<a href="followup_view.cfm?id=#id#&year=#year#">View</a> Follow Up Letter
		<cfelse>
			<A href="FollowUps/#FollowUp#">#FollowUp#</a>
        </cfif>
	<cfelse>
    	No Follow-Up Submitted
	</cfif>
    <br /><br />
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
    <cfinclude template="incRD.cfm">
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
	#Scope#
</cfif>
<br><br>

<b>Notes</b><br>
<cfif len(Notes)>
	#Notes#
<cfelse>
	No Notes Added
</cfif><br><br>

<cfif isdefined("Scheduler")>
	<cfif len(Scheduler)>
		<b>Audit Scheduled By:</b><br>
		#Scheduler#
	</cfif>
</cfif><br><br>

</cfif>
</CFOUTPUT>

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT baseline.*, baseline.year_ AS "Year"
FROM baseline
WHERE Year_ = <cfqueryparam value="#url.year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif plan.auditedby is "IQA">
	<cfif baseline.baseline is 0>
		<cfoutput query="baseline">
        <font color="red">#year# IQA Audit Schedule is tentative.</font><br><Br />
		</cfoutput>
	</cfif>
</cfif>

<!--- check for past and future audits --->
<cfif plan.AuditedBy EQ "IQA" AND URL.Year GTE 2008>
	<cfoutput query="Plan">
		<cfinclude template="#IQARootDir#incPastAudits.cfm">
	</cfoutput>
</cfif>
<!--- /// --->

	<!--- if the audit is not approved --->
	<cfelse>
    	<cfoutput>
		<br>Audit #URL.Year#-#URL.ID# does not exist.
		</cfoutput>
    </cfif>
<cfelse>
<!--- if the audit does not exist --->
	<cfoutput>
	<br>Audit #URL.Year#-#URL.ID# does not exist.
	</cfoutput>
</cfif>

<!--- if no url items --->
<cfelse>
	No Audit Number was specified.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->