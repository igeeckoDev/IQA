<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Cancellations and Reschedules - View Requests">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<u>Currently Viewing</u>: <b>#url.year#</b><Br>
View Year: <cfloop index=i from=2013 to=#curYear#> <a href="ViewCancelRequests.cfm?Year=#i#">#i#</a><cfif i NEQ curYear> :: </cfif></cfloop><br>
</cfoutput><br>

<CFQUERY BLOCKFACTOR="100" NAME="ViewCancelRequests" Datasource="Corporate">
	SELECT CancelRequest, Area, OfficeName, ID, Year_, AuditArea, Area, AuditType2, CancelRequestDate, CancelRequestFile, AuditedBy, Status
    FROM AuditSchedule
    WHERE CancelRequest = 'Yes'
	AND AuditedBY = 'IQA'
	AND Year_ = #url.Year#
	ORDER BY Year_ DESC, ID
</cfquery>

<b>Cancel Audit Requests</b><br />
<table border="1">
<tr>
    <th>Audit Number</th>
    <th>Office Name</th>
    <th>Audit Type</th>
    <th>Audit Area</th>
    <th>Audit Label</th>
    <th>Cancel Request Date</th>
    <th>Approval</th>
</tr>
<cfoutput query="ViewCancelRequests">
<tr>
	<td><a href="auditdetails.cfm?id=#id#&year=#year_#">#year_#-#ID#-#AuditedBy#</a></td>
    <td>#OfficeName#</td>
    <td>#AuditType2#</td>
    <td>#Area#</td>
    <td>#AuditArea#</td>
    <td>#dateformat(CancelRequestDate, "mm/dd/yyyy")#</td>
    <td nowrap>
    	<cfif NOT len(Status)>
	    	<a href="cancel_approval.cfm?id=#id#&year=#year_#">Approve Request</a>
        <cfelseif Status eq "deleted">
        	Cancel Request Approved
		<cfelseif Status eq "Removed">
			Audit Removed from Schedule - Cancelled in planning
		</cfif>
	</td>
</tr>
</cfoutput>
</table><br /><br />

<CFQUERY BLOCKFACTOR="100" NAME="ViewRescheduleRequests" Datasource="Corporate">
	SELECT CancelRequest, Area, OfficeName, ID, Year_, AuditArea, Area, AuditType2, RescheduleRequestDate, AuditedBy, Status, StartDate, EndDate, RescheduleRequestStartDate, RescheduleRequestEndDate, RescheduleRequestNextYear, RescheduleStatus
    FROM AuditSchedule
    WHERE RescheduleRequest = 'Yes'
	AND AuditedBY = 'IQA'
	AND Year_ = #url.Year#
	ORDER BY Year_ DESC, ID
</cfquery>

<b>Reschedule Audit Requests</b><br />
<table border="1">
<tr>
    <th>Audit Number</th>
    <th>Current Audit Dates</th>
    <th>Office Name</th>
    <th>Audit Type</th>
    <th>Audit Area</th>
    <th>Audit Label</th>
    <th>Reschedule Request Date</th>
    <th>Reschedule For Next Year?</th>
    <th>Proposed Reschedule Dates/Month</th>
    <th>Approval</th>
</tr>
<cfoutput query="ViewRescheduleRequests">
<tr>
	<td><a href="auditdetails.cfm?id=#id#&year=#year_#">#year_#-#ID#-#AuditedBy#</a></td>
    <td>#dateformat(startdate, "mm/dd/yyyy")#-#dateformat(enddate, "mm/dd/yyyy")#</td>
    <td>#OfficeName#</td>
    <td>#AuditType2#</td>
    <td>#Area#</td>
    <td>#AuditArea#</td>
    <td>#dateformat(RescheduleRequestDate, "mm/dd/yyyy")#</td>
    <td>#RescheduleRequestNextYear#</td>
    <td>#dateformat(reschedulerequeststartdate, "mm/dd/yyyy")#-#dateformat(reschedulerequestenddate, "mm/dd/yyyy")#
    <td>
    	<cfif NOT len(RescheduleStatus)>
	    	<a href="Reschedule_approval.cfm?id=#id#&year=#year_#">Approve Request</a>
        <cfelseif RescheduleStatus eq "Rescheduled">
        	Reschedule Request Approved
		</cfif>
	</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->