<cfoutput>
<b>#Year#-#ID#-#AuditedBy#</b><br><br>

<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "SU"
		OR SESSION.Auth.accesslevel is "Admin"
        OR SESSION.Auth.AccessLevel is "Laboratory Technical Audit" AND AuditedBy eq "LAB"
        OR SESSION.Auth.AccessLevel is "Verification Services" AND AuditedBy eq "VS"
		OR SESSION.Auth.AccessLevel is "UL Environment" AND AuditedBy eq "ULE"
		OR SESSION.Auth.AccessLevel is "WiSE" AND AuditedBy eq "WiSE">

        <u>Available Actions</u><br>
        <cfif Approved is "No">
         - <a href="audit_ok.cfm?ID=#ID#&Year=#Year#"><b>Approve</b></a> Audit for Audit Schedule.<br>
        </cfif>

        <cfif AuditedBy eq "LAB">
        	<cfset AuditedBy2 = "LTA">
        <cfelse>
        	<cfset AuditedBy2 = AuditedBy>
        </cfif>

        <CFIF Trim(Status) is "deleted">
         - <A href="#AuditedBy2#_EditAudit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">edit</a><br>
         - <A href="uncancel.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">reinstate</a><br>
         - <A href="remove.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">remove</a>
        <cfelse>
         - <A href="#AuditedBy2#_EditAudit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">edit</a><br>
         - <a href="cancel.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">cancel</a><br>
         - <a href="reschedule.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">reschedule</a><br>
         - <A href="remove.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">remove</a>
        </CFIF>
        <br><br>
    </cfif>
</cflock>

<b>Location</b><br>
#OfficeName# - #AuditArea#<br><br>

<b>Audit Type</b><br>
#AuditType#<br><br>

<b>Auditor</b><br>
#Auditor#<br><br>

<b>Month Scheduled</b>
<cfif Month is "" or Month is 0>
<br>No month scheduled
<cfelse>
<br>#MonthAsString(Month)#
</cfif>
<br><br>

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
<!--- output of incDates.cfc --->
#DateOutput#<Br />

<!--- add/edit/clear dates for those with access --->
<cflock scope="SESSION" timeout="60">
    <cfif IsDefined("SESSION.Auth.IsLoggedIn")>
        <CFIF
        SESSION.Auth.accesslevel is "SU"
		OR SESSION.Auth.accesslevel is "Admin"
		OR LeadAuditor is "#SESSION.AUTH.NAME#"
        OR SESSION.Auth.AccessLevel is "Laboratory Technical Audit" AND AuditedBy eq "LAB"
		OR SESSION.Auth.AccessLevel is "Verification Services" AND AuditedBy eq "VS"
		OR SESSION.Auth.AccessLevel is "UL Environment" AND AuditedBy eq "ULE"
		OR SESSION.Auth.AccessLevel is "WiSE" AND AuditedBy eq "WiSE">
            <a href="add_dates.cfm?ID=#ID#&Year=#Year#">Add/Change Dates</a><br />
            <a href="clear_dates.cfm?ID=#ID#&Year=#Year#">Change Month/Clear Dates</a>
        </cfif>
    </cfif>
</cflock>
<!--- // --->
<br /><br />

<cfif len(email) AND email NEQ " ">
    <b>Primary Contact</b><br>
    #EmailName# - #Email#
    <br><br>
	:: <a href="javascript:popUp('EmailVerify.cfm?ID=#URL.ID#&Year=#URL.Year#&Field=Email')">Verify</a> Primary Contact Email Address (Page will load slowly)<br /><br>
</cfif>

<cfif len(email2) AND email2 NEQ " ">
    <b>Other Contacts</b><br />
    <cfset Dump = #replace(Email2, ",", "<br>", "All")#>
    <cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
    #Dump1#
    <br><br />
    :: <a href="javascript:popUp('EmailVerify.cfm?ID=#URL.ID#&Year=#URL.Year#&Field=Email2')">Verify</a> Other Contact Email Addresses (Page will load slowly)<br />
    :: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br />
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
SELECT * FROM ReportAttach
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif reschedulenextyear is NOT "Yes">
	<cfinclude template="status_colors_LTA.cfm">
</cfif>

<cfif Trim(RescheduleStatus) is "Rescheduled">
	<cfif RescheduleNextyear is NOT "Yes">
    	<br><br>
	</cfif>
    <b>Reschedule Status</b>
    <br>
    <img src="../images/red.jpg" border="0"><br><br>
    <b>Reschedule Notes</b>
    <br>
    #RescheduleNotes#
</CFIF><br /><br />

<b>Scope Letter</b><br>
<cflock scope="SESSION" timeout="60">
	<!--- for LAB audits --->
	<cfif AuditedBy eq "LAB">
		<cfif len(Trim(ScopeLetter))>
        	<!--- view scope --->
            <A href="LTA_ScopeLetter_View.cfm?ID=#ID#&Year=#Year#">View Scope Letter</a><br>
            Sent - #dateformat(ScopeLetterDate, "mm/dd/yyyy")#
        <cfelse>
            No Scope Letter Submitted<br>
			<!--- add scope if correct access --->
			<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
                <CFIF
                SESSION.Auth.accesslevel is "SU"
                OR SESSION.Auth.accesslevel is "Admin"
                OR LeadAuditor is "#SESSION.AUTH.NAME#"
                OR SESSION.Auth.AccessLevel is "Laboratory Technical Audit" AND AuditedBy eq "LAB">
            		<A href="LTA_ScopeLetter_Send.cfm?ID=#ID#&Year=#Year#">Add Scope Letter</a>
        		</cfif>
			</cfif>
        </cfif>
    <cfelseif AuditedBy eq "WiSE" OR AuditedBy eq "VS"  OR AuditedBy eq "ULE">
    <!--- for Wise and VS audits, and ULE audits --->
        <cfif len(Trim(ScopeLetter))>
        <!--- view scope --->
            <A href="../scopeletters/#ScopeLetter#">View Scope Letter</a><Br />
            Sent - #dateformat(ScopeLetterDate, "mm/dd/yyyy")#
		<cfelse>
	    <!--- upload scope if correct access --->
            No Scope Letter Submitted<br>
            <a href="addscopeletter.cfm?#CGI.Query_String#">Upload Scope Letter</a>
        </cfif>
	</cfif><br><br>
</cflock>
</cfoutput>

<b>Report</b><br>
<cfif AttachCheck.recordcount eq 0>
No Report Uploaded<br />
<cfelse>
   	<cfoutput query="AttachCheck">
		<cfif len(filelabel)>
			#fileLabel# - <a href="#IQARootDir#Reports/#filename#">View</a>
		<cfelse>
        	#filename# - <a href="#IQARootDir#Reports/#filename#">View</a>
		</cfif><br>
	</cfoutput><br />
</cfif>

<cfoutput>
<a href="Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">Upload Report Files(s)</a><br>
<a href="Report1.cfm?#CGI.Query_String#&AuditedBy=#AuditedBy#">Add Report</a> (Using IQA Report Form)<Br /><br />

<b>Notes</b><br>
<cfif len(Notes)>
	#Notes#
<cfelse>
	No Notes Listed
</cfif><br><br>

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
<br><br>
</cfoutput>