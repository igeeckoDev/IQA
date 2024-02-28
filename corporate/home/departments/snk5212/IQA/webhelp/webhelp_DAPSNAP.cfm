<cfset subTitle = "Web Help - OSHA SNAP Audit Data Recording (IQA Auditors)">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Audit Requirements</u><br>
During Local Function audits of each UL Site, a OSHA SNAP audit must be performed. In addition, each site must be audited as part of the DAP 1 (Jan-June) or DAP 2 (July-Dec) Global Function audit each year. For instance, if a site has a Local Function audit in May, the site must also be included in the DAP 2 audit for July-December.<br /><br />

<u class="web-subtitle">Data Being Captured</u><br>
<b>Function 1 - Qualification</b><br>
Programs - WTDP, TCP, PPP<br>
Program Compliance (WTDP), Qualification (TCP)<br>
Projects Reviewed<br>
Compliance to 00-LC-S0258 (WTDP), 00-OP-C0025 (TCP)<br>
L2 Competency<br>
L2 Employee Number<br>
L2 - Current Employee<br>
Records Compliance<br>
CARs<br>
Notes<br><br>

<b>Function 2 - Data Acceptance</b><br>
Programs - TPTDP, WTDP, CTDP, TCP, CB Scheme, PPP<br>
Program Compliance <br>
Projects Reviewed<br>
Compliance to 00-LC-S0258 (WTDP), 00-OP-C0025 (Others)<br>
L2 Competency<br>
L2 Employee Number<br>
L2 - Current Employee<br>
Signatory Signature<br>
DAP Asessment/Scope<br>
Records Compliance<br>
CARs<br>
Notes<br><br>

<u class="web-subtitle">Accessing OSHA SNAP Form</u><br>
SNAP Data is available on the bottom of the Audit Details page for applicable audits.<br><br>

<img src="../images/SNAPDataLink.jpg" border="0">
<br><br>

<u class="web-subtitle">OSHA SNAP Coverage</u><br>
IQA Auditors can access the "OSHA SNAP Coverage" table on the Admin Menu, which shows the state of each OSHA SNAP audit for each location.<br /><br />

<u class="web-subtitle">Requirements / Validation</u><br>
Once you have added all data for all programs, you must complete the process by clicking the <strong>Complete</strong> link on the top of the <u>SNAP Data (Review) page</u>.<br><br>

The complete status functionality is similar to publishing the audit report. The Data must be listed Complete in order to appear on Alan's OSHA SNAP completion report. A notification will be sent if the OSHA SNAP Data is not completed within 30 days of the end of the audit.<br><br>

When you attempt to <strong>Complete</strong> the data, the following validations take place:<br>
1. If Program Compliance is <strong>NA</strong>, <font color=red>Notes are required</font>. Also, L2 Employee Number will automatically change to 00000. All other fields remain <strong>NA</strong>.<br>
2. If Program Compliance is <strong>Yes or No</strong>, <font color=red>the Projects Reviewed and L2 Employee Number must be added. L2 Employee Numbers are verified</font>.<br>
3. If Program Compliance is <strong>No</strong>, <font color=red>CARs must be added</font>.<br>
4. If an Employee is no longer at UL - you must select <strong>No</strong> in the appropriate field in order to pass validation.<br><br>

If there are any issues during Validation, you are returned to the Review page and alerted to the first error found and how to correct it. Please review your work carefully!<br><br>

If there are no errors found, the records are marked 'Complete' and they will no longer be editable. (Please contact Alan Purvey or Chris Nicastro to make changes if necessary)<br><br>

<u class="web-subtitle">L2 - Current Employee</u><br>
If the L2 is no longer at UL, please indicate this by selecting <strong>No</strong>. (default is <strong>Yes</strong>) When you try to <strong>Complete</strong> the data, Employee Numbers are validated. Selecting <strong>No</strong> skips this validation, as the auditor has indicated that the employee is no longer with the company.<br><br>

<u class="web-subtitle">Empty Fields</u><br>
Usually empty fields are an issue on forms on the IQA website. In this case, if you have no information to add to a field (Notes, CARs, Projects Reviewed, Employee Number, etc), please leave the fields blank. Default values will be added where necessary.<br><br>

<cfinclude template="webhelp_EndOfPage.cfm">