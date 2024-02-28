<cfset subTitle = "Web Help - Scheduling an Audit">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Audit Schedule - Add Audit</u><br>
From the Audit Schedule page, select a type of audit to schedule listed under 'Add Audit', which is directly to the left of the status Legend.<br><br>

<u class="web-subtitle">Add Audit Methods</u><br>
Documented below are several different methods for scheduling an audit.<br><br />

<u class="web-subtitle">Finance / Internal Audit</u><br>
<ul>
<li>Year*</li>
<li>Month*</li>
<li>Location*</li>
<li>Auditor(s)*</li>
<li>Site Contact*</li>
<li>Audit Dates*</li>
<li>Scope Letter</li>
<li>Scope/Notes</li>
</ul>
<br>

<u class="web-subtitle">Accreditor Audit</u><br>
<ul>
<li>Year*</li>
<li>Month*</li>
<li>Location*</li>
<li>Accreditor Name</li>
<li>Site Contact*</li>
<li>AS Contact Person* (AS Audits only)</li>
<li>Audit Dates*</li>
<li>Agenda</li>
<li>Report</li>
<li>Scope</li>
</ul>
<br>

<u class="web-subtitle">Field Services</u><br>
<ul>
<li>Year*</li>
<li>Month*</li>
<li>Audit Dates*</li>
<li>Location*</li>
<li>Auditor(s)*</li>
<li>Primary Contact*</li>
<li>Other Contact(s)</li>
<li>Scope Letter</li>
<li>Report</li>
<li>Audit Area</li>
<li>Key Processes</li>
<li>Reference Documents</li>
<li>Scope</li>
<li>Notes</li>
</ul>
<br>

<u class="web-subtitle">IQA / Regional Internal Audit</u><br>
<ul>
<li>Year*</li>
<li>Month*</li>
<li>Audit Dates*</li>
<li>Audit Type*</li>
<li>Location*</li>
<li>Lead Auditor*</li>
<li>Auditor(s)</li>
<li>Primary Contact*</li>
<li>Other Contact(s)</li>
<li>Scope Letter*</li>
<li>Report*</li>
<li>Pathnotes*</li>
<li>IC Form*</li>
<li>Audit Area*</li>
<li>Program / Process / Site / Lab / Function Name (drop down menu)*</li>
<li>Key Processes</li>
<li>Reference Documents</li>
<li>Scope</li>
<li>Notes</li>
</ul>
<br>

* - required fields<br><br>

Once this information has been submitted, you will be taken to the audit details page to show the newly scheduled audit. From here, you can Approve the audit to be published to the schedule, or edit the audit details.<br><br>

Once this information is properly filled in, please select 'Save and Continue'.<br><br>

<u class="web-subtitle">Add Audit - Field Services, IQA, Regional Internal Audits - Additional Information</u><br>
This page allows you to add the specific audit area from a drop down list. For Field Services, it allows you to choose the specific Inspection Center based on the region you chose on the previous page. The specific audit areas are documented on the Audit Types web help previous mentioned on this page.<br><br>

You must select a Local Function, Program, Global Function/Process, or Corporate Function to proceed. Also available on this drop down list for Local Function audits is a list of available labs for this site if you are doing a lab audit.<br><br>

Once you have selected the specific audit area, submit the form.<br><br>

Once submitted, you will be taken to the audit details page to show the newly scheduled audit. From here, you can Approve the audit to be published to the schedule, or edit the audit details.<br><br>

<!---
<u class="web-subtitle">TPTDP - Adding Audits</u><br>
Only IQA staff can schedule TPTDP audits.<br><br>

Select IQA under Add Audit on the Audit Schedule page. On the following page, select TPTDP and click Save and Continue. You will be taken to the Audit Scheduling Form. The following information must be included in this form:<br>
<ul>
<li>Year*</li>
<li>Month*</li>
<li>Start Date</li>
<li>End Date</li>
<li>Lead Auditor*</li>
<li>Auditor</li>
<li>TPTDP Client*</li>
<li>Desk Audit Yes/No*</li>
<li>Scope*</li>
<li>Notes</li>
</ul>

* - required fields<br><br>

Once you have selected the specific audit area, submit the form.<br><br>

Once submitted, you will be taken to the audit details page to show the newly scheduled audit. From here, you can Approve the audit to be published to the schedule, or edit the audit details.<br><br>
--->

<u class="web-subtitle">Editing Audit Details</u><br>
From the audit details page, you can approve the audit to be published to the schedule or edit the audit details using the links on the top of this page. Edit uses the same forms as adding an audit, except some fields are not able to be edited.<br><br>

You will be unable to edit the following fields once you have approved the audit:<br>
<ul>
<li>Year</li>
<li>Month/Dates (need to use reschedule or change dates)</li>
<li>Audit Type</li>
<li>UL Site<!---/TPTPD Client---></li>
</ul>

Leaving any required fields blank (see required fields above in the scheduling an audit section) while editing will result in the same notification before you can proceed. Please make sure all data is entered correctly.

<cfinclude template="webhelp_EndOfPage.cfm">