<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="IQA Audit Dashboard">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="session" timeout="5">
<Cfoutput>

    <CFQUERY BLOCKFACTOR="100" NAME="ID" Datasource="Corporate">
    SELECT * FROM AuditorList
    WHERE Auditor = '#SESSION.Auth.Name#'
    </cfquery>

<!--- get current month to set audit assignments variable "Half" for link below --->
<cfif curMonth LTE 6>
	<cfset Half = 1>
<cfelseif curMonth GTE 7>
	<cfset Half = 2>
</cfif>

<table border="0">
<tr valign="top">
<td class="blog-content">
<b>My Audits</b><br>
:: <a href="schedule.cfm?Year=#CurYear#&Auditor=#SESSION.AUTH.Name#&AuditedBy=IQA">Schedule</a><Br>
:: <a href="calendar.cfm?type=auditor&type2=#SESSION.AUTH.Name#">Calendar</a><Br>
:: <a href="Audit_List2.cfm?Month=#curmonth#&Year=#curyear#&type=auditor&type2=#SESSION.AUTH.Name#">Year List</a><br><br />

<b>Auditor Profiles</b><br />
:: <a href="AProfiles_detail.cfm?ID=#ID.ID#">My Auditor Profile</a><Br>
:: <a href="AProfiles.cfm?view=all">View All</a><br><br />

<b>Calibration Meetings</b><br />
:: <a href="Calibration_ActionItems.cfm?View=Open">Open Action Items</a><br>
:: <a href="calibration_index.cfm">Meeting Index</a><br><br />

<b>Audits Awaiting Approval</b><br />
<cfinclude template="approval.cfm">
<Br />

</td>
<td class="blog-content">

<b>Audit Status</b><br />
:: <a href="viewStatusPages.cfm">Audit Status Pages</a><br /><br />

<b>DAP 1/2 Audit Assignments</b><br />
:: <a href="DAP_SNAP_Audits.cfm?Year=#curYear#&Half=#Half#">View</a><br /><br />

<b>SR's Generated from IQA Audits</b><br />
:: <a href="SRMenu.cfm">View</a><Br /><br />

<b>Program List</b><br />
:: <a href="_prog.cfm?list=IQA">UL Programs Master List - Programs Audited by IQA</a><br /><br />

<b>Accreditor Checklist</b><br />
:: <a href="AccreditorChecklists.cfm">View</a><br /><br />

</td>
</tr>
</table>

</Cfoutput>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->