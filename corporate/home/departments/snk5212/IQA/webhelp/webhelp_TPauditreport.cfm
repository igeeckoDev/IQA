<cfset subTitle = "Web Help - TPTDP Audit Reporting">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Add TPTDP Report</u><br>
On the audit details page, select 'Add Report' under the Audit Report heading.<br><br>

<u class="web-subtitle">Audit Report Page 1 - General Information</u><br>
Data included from Audit Details:<br>
<ul>
<li>Audit Report Number</li>
<li>Location</li>
<li>Audit Dates</li>
<li>Auditors</li>
<li>Audit Type</li>
<li>Key Contact</li>
<li>Contact Email</li>
<li>Contact Phone Number</li>
</ul>

Data required:<br>
<ul>
<li>Other Laboratory Certifications/Accreditations</li>
<li>Other Laboratory Certifications/Accreditations Comments</li>
<li>Number of Projects Submitted since previous GALO</li>
<li>Number of People in Facility</li>
<li>Audit Report date</li>
<li>Scope</li>
<li>Audit Summary</li>
<li>Nonconformances - Number of Findings, Observations, and Associated CAR Numbers*</li>
<li>Positive Observations</li>
</ul>

* - Nonconformances are separated into a list of ISO 17025 clauses. Please enter the Noncompliance and Preventive actions into the appropriate clause row.<br><br>

CAP AA Audits - If this audit includes CAP AA, there will be additional list items to store nonconformances.<br><br>

Once this information has been entered, please submit the form by selecting 'Save and Continue'. Please be sure to use <u>numbers only</u> for the number of findings and number of observations fields. Separate CAR numbers with commas in the CAR/Audit Finding Number(s) field.<br><br>

Once you have pressed 'Save and Continue' on this page of the Audit Report, the audit report process has begun. The audit report will not be published (not publicly accessible) until you have completed all pages of the report and have selected 'Publish Report'. You can continue to enter information at this point until all pages are saved, then review the report and either edit or publish.<br><br>

Should you need to stop your work after the first page and continue entering the report later, you will have to click 'edit report' on the audit details page.<br><br>

<u class="web-subtitle">Audit Report Page 2 - Verified CARs</u><br>
Data required:<br>
<ul>
<li>CAR/Audit Finding Number</li>
<li>Effective Implementation Yes/No</li>
<li>Verification Comments</li>
</ul>

<u class="web-subtitle">Audit Report Page 3 - Repeat CARs</u><br>
Data required:<br>
<ul>
<li>Old CAR/Audit Finding Number</li>
<li>New CAR/Audit Finding Number</li>
<li>Verification Comments</li>
</ul>

<u class="web-subtitle">Audit Report Page 4 - Effectiveness</u><br>
Data required:<br>
<ul>
<li>Program Effectiveness Yes/No/NA</li>
<li>Comments</li>
</ul>

This information is neccessary for the following topics:<br>
<ul>
<li>Document Control Implementation Effectiveness</li>
<li>Management Review Implementation Effectiveness</li>
<li>Corrective Action Implementation Effectiveness</li>
<li>Records Implementation Effectiveness</li>
<li>Internal Audits Implementation Effectiveness</li>
<li>Overall Quality System Implementation Effectiveness</li>
</ul>

The effectiveness criteria is available in the report by clicking on the '[view effectiveness criteria]' links for each category.<br><br>

<u class="web-subtitle">Audit Report Page  5 - Audit Coverage</u><br>
Audit Coverage is gathered for the audit on this page. For the five categories mentioned on the previous page, your answer on page 3 about their effectiveness is used on this page. A 'Yes' or 'No' answer on the previous pages indicates that the category was covered, while 'N/A' indicates it was not covered. If you made a mistake and wish to change the 'Yes/No/NA' answers on the previous page, press the back button on your browser, make changes, and resubmit the page.<br><br>

The Coverage categories are the same as the Nonconformances table on page one of the audit report, ISO 17025 Clauses.<br><br>

For the other categories not already selected, please answer 'Yes' or 'No' to identify if this category was covered during the audit. Once completed, select 'Save and Continue'.<br><br>

<u class="web-subtitle">Audit Report Page 6 - CAP AA Coverage</u><br>
Note - Only applicable for audits including CAP AA.<br><br>

An additional Audit Coverage table. Please answer 'Yes' or 'No' to identify if this category was covered during the audit. Once Completed, select 'Save and Continue'.<br><br>

<u class="web-subtitle">Audit Report - Review Report</u><br>
At this point you have entered all necessary data for the Audit Report. You can now edit the report, print it, or publish it to allow it to be publicly accessible. Edit works exactly the same as 'add' except you select 'edit report' on the audit details page.

<cfinclude template="webhelp_EndOfPage.cfm">