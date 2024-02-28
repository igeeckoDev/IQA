<cfset subTitle = "Web Help - Audit Schedule">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">View Audit Schedules</u><br>
The 'Audit Schedule' page allows you to view all Audit Schedules, Audit Details, and the ability to add an audit for your area.<br><br>

<u class="web-subtitle">Select Schedule</u><br>
Under the main page title 'Audit Schedule', you can select the year and/or month you wish to view. Below this, you can select the type of audit schedule you wish to view. The choices are:<br><br />

<ul>
<li>Accreditation Services (AS)</li>
<li>All Accreditation (including AS)</li>
<li>Internal Audit / Corporate Finance</li>
<li>IQA</li>
<li>Laboratory Technical Audit</li>
<!---<li>QRS</li>--->
<li>Verification Services (VS)</li>
<li>WiSE</li>
<li>UL Environment (ULE)</li>
<li>Regional Schedules*</li>
</ul><Br />

* Note - The Regional Views require you to select a region (including Field Services), and contain External Accreditation audits as well as Regional Quality audits conducted by Local Quality staff. Field Service Audits are found in the Regional view, and IQA Field Service audits can also be viewed by selecting the IQA Audit Schedule. Accreditation Services handles Certification related audits of ANSI, OSHA, and SCC.

<!--- edited 11/09/2009 above, below is original
* Note - The Regional Views contain External Accreditation audits for that particular region. Field Service Audits are considered regional audits, IQA Field Service audits can be view by selecting the IQA Audit Schedule.--->
<br><br>

<u class="web-subtitle">Add Audit</u><br>
Adding an audit can be accomplished by following the link on the Admin Menu named "Add Audit". An add audit link is not provided on this page any longer.
<br><br>

<u class="web-subtitle">Viewing Audit Details</u><br>
Once you are looking at a particular month, you will be able to see some details of each audit, including location, audit type, audit dates, lead auditor (or accreditor), and a color status. (see Status below) Below this basic audit information, you will see a link listed as 'Audit Details'. This will all you to view all information contained in the IQA Audit Scheduling Tool about this particular audit.<br><br>

<u class="web-subtitle">Edit/Cancel/Reschedule/Remove*</u><br>
These links below the 'Audit Details' link will allow you to change the current Audit Details, if you have the proper access. You can edit this information, cancel the audit, reschedule, or remove (delete) the audit from the system. More information about these functions is available once you have selected edit, cancel, reschedule, or remove. It is preferable to go to the audit details page first and select these options under "Avaialable Actions".<br><br>

* Note - The above options <u>vary</u> for Accreditation Services, External Accreditation, Field Services, Corporate Finance, Laboratory Technical Audit, and QRS. Please see the Audit Details page for available options.

<!--- edited 11/09/2009 above, below is original
* Note - <u>Not applicable</u> for Accreditation Services, Regional External Accreditation, Field Services, Finance, or QRS. Please see the Audit Details page for this information.--->
<br><br>

<u class="web-subtitle">Status</u><br>
An Explanation of the Audit Status can be found listed under 'Legend' as well as on the bottom of the Audit Schedule page. This indicates the state of the audit at the current time.<br><br>

The Legend will vary depending on your access level and your audit's characteristics. Some audit types do not allow for reports to be included in this system. These types of audits will show <font color="green"><u>Green</u></font> status once the audit dates have passed. Others that do require audit reports will become <font color="blue"><u>Blue</u></font> status after the audit dates have passed, until the audit report is completed and published, only then will the status change to <font color="green"><u>Green</u></font>.<br><br>

<cfinclude template="webhelp_EndOfPage.cfm">