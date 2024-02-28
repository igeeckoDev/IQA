<cfoutput>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
SELECT * FROM ReportAttach
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<b>#Year#-#ID#-#AuditedBy#</b><br><br>

<b>Location/Lab</b><br>
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
#DateOutput#<Br /><br />

<cfif email is "" or email is " ">
<cfelse>
<b>Primary Contact</b><br>
#EmailName# - #Email#
<br><br>
</cfif>

<cfif email2 is "" or email2 is " ">
<cfelse>
<b>Other Contacts</b><br />
<cfset Dump = #replace(Email2, ",", "<br>", "All")#>
<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
#Dump1#
<br><br>
</cfif>

<cfif reschedulenextyear is NOT "Yes">
	<cfinclude template="status_colors_LTA.cfm">
</cfif>

<cfif Trim(RescheduleStatus) is "Rescheduled">
	<cfif RescheduleNextYear is NOT "Yes"><br><br></cfif>
<b>Reschedule Status</b>
<br>
<img src="images/red.jpg" border="0"><br><br>
<b>Reschedule Notes</b>
<br>
#RescheduleNotes#
<CFELSE>
</CFIF>
<br><br />

<b>Scope Letter</b><br />
<cfif AuditedBy eq "LAB">
	<cfif len(Trim(ScopeLetter))>
        <A href="LTA_ScopeLetter_View.cfm?ID=#ID#&Year=#Year#">View Scope Letter</a><br>
        Sent - #dateformat(ScopeLetterDate, "mm/dd/yyyy")#
    <cfelse>
        No Scope Letter Submitted
    </cfif>
<cfelseif AuditedBy eq "WiSE" OR AuditedBy eq "VS" OR AuditedBy eq "ULE">
    <cfif len(Trim(ScopeLetter))>
    <!--- view scope --->
		<A href="scopeletters/#ScopeLetter#">View Scope Letter</a><br />
        Sent - #dateformat(ScopeLetterDate, "mm/dd/yyyy")#
    <cfelse>
    	No Scope Letter Submitted
    </cfif>
</cfif><Br /><Br />
</cfoutput>

<b>Report</b><br>
<cfif AttachCheck.recordcount eq 0>
No Report Uploaded<br /><br />
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
<b>Notes</b><br>
<cfif len(Notes)>
	#Notes#
<cfelse>
	No Notes Listed
</cfif><br><br>

<cfif isdefined("Scheduler")>
	<cfif len(Scheduler)>
        <b>Audit Scheduled By:</b><br>
        #Scheduler#<br><br>
    </cfif>
</cfif>

<cfif Status is "Deleted">
	<b>Cancellation Notes</b><br>
	#Notes#
</cfif>
</cfoutput>