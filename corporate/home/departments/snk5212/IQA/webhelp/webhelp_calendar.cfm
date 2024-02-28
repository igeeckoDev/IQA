<cfset subTitle = "Web Help - Audit Calendar">
<cfinclude template="webhelp_StartOfPage.cfm">

<cfoutput>
<u class="web-subtitle">Calendar Search Views</u><br>
There are many different search options for the Audit Calendar. The list of available views can be found on this page: <a href="#IQADir#viewAudits.cfm">View Audits</a>
</cfoutput>
<br><br>

<u class="web-subtitle">Audit List</u><br>
Once you have selected a view from the above page, the default view is the current month in calendar format. There are two other available views: monthly audit list, and yearly audit list. Both of these lists show a summary of the audits for the month and year based on your original search criteria. The monthly view shows audits grouped by their Audit Type, the yearly view shows audits listed by audit number.<br><br>

<u class="web-subtitle">Search Criteria</u><br>
In order to change the search criteria, click the link 'Select New Search Criteria'.
<br><br>

<u class="web-subtitle">Navigation</u><br>
In the Calendar View, directly above 'Sunday' and 'Saturday' are forward (>>) and backward (<<) links to allow you to move one month forward and back.<br><br>

To move through the years and months, two drop downs are provided for 'Jump to Year' and 'Jump to Month'. Selecting from these drop down will move you to the month or year specified. Note: The Yearly Audit List View only has a year drop down.<br><br>

<u class="web-subtitle">Calendar View - Audit Details</u><br>
If you wish to go to the audit details page of this audit, click on the audit number.<br><br>

In the event that the audit in the current month view is cancelled, has no dates yet, or has been rescheduled for the following year, the audit will be listed below the monthly calendar with the appropriate heading. In the monthly and yearly audit list views, cancelled and rescheduled for next year audits will not show up, however, audits with no dates as of yet will show up in the month they were originally scheduled.<br><br>

<cfinclude template="webhelp_EndOfPage.cfm">