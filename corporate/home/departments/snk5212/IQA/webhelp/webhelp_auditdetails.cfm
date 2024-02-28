<cfset subTitle = "Web Help - Audit Details">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Audit Details Page</u><br>
The audit details page format is slightly different depending on the type of audit. For all types of audits, there are options to edit, cancel, reschedule, and remove on the details page. Some of these options are also available on the Audit Schedule page, but it is advisable to use the Audit Details page to take all actions (Edit, Cancel, Remove, Reschedule). The page contains links (if applicable, depending on the type of audit) to the Audit Scope, Report, any reschedule or cancellation notes, IC Form, OSHA SNAP Audits conducted as part of the audit, and pathnotes.

<!--- edited 11/09/2009, above is new, below is old
The audit details page format is slightly different depending on the type of audit. Included on all audit details pages is the ability to select 'edit'. For Field Services, IQA, and Regional Internal audits, there are options to edit, cancel, reschedule, and remove on the audit schedule page. For all other types of audits (QRS, Regional Accreditation, Accreditation Services, and Corporate Finance), the edit, cancel, reschedule, and remove functions are listed on the top of the audit details page.
--->
<br><br>

<cfoutput>
<u class="web-subtitle">Audit Status Legend</u><br />
<img src="#IQADir#images/red.jpg" border="0"> - Audit Rescheduled<br>
<img src="#IQADir#images/orange.jpg" border="0"> - Audit Completed, No Close Out Letter *<br />
<img src="#IQADir#images/yellow.jpg" border="0"> - Audit Scheduled<br>
<img src="#IQADir#images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="#IQADir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
<img src="#IQADir#images/black.jpg" border="0"> - Audit Cancelled<br><br />
* Third Party Audits Only - performed by IQA 2004-2007<br /><br />
</cfoutput>

<!---
<u class="web-subtitle">IQA and Regional Internal Audit Details</u><br>
<ul class="arrow2">
<li class="arrow2">Year</li>
<li class="arrow2">Month</li>
<li class="arrow2">Start Date</li>
<li class="arrow2">End Date</li>
<li class="arrow2">Audit Type</li>
<li class="arrow2">Specific Audit Area <sup>2</sup></li>
<li class="arrow2">Lead Auditor</li>
<li class="arrow2">Auditor(s)</li>
<li class="arrow2">Audit Area</li>
<li class="arrow2">Status (automatically generated)</li>
<li class="arrow2">Audit Scope</li>
<li class="arrow2">Audit Report</li>
<li class="arrow2">CBTL Report <sup>3</sup></li>
<li class="arrow2">Primary Contact(s) (External UL email address)</li>
<li class="arrow2">Other Contact(s) (External UL email addresses)</li>
<li class="arrow2">UL Site <sup>2</sup></li>
<li class="arrow2">Key Processes</li>
<li class="arrow2">Reference Documents</li>
<li class="arrow2">Scope</li>
<li class="arrow2">Notes</li>
<!--- removed 11/09/2009 
<li class="arrow2">Field Service Region <sup>2</sup></li>
--->
<li class="arrow2">Field Service IC Location <sup>1</sup></li>
</ul><br />

<!--- 11/09/2009 minor edits --->
IQA Audits require use of the Scope and Reporting Forms included in the tool. For Regional Internal audits, they are optional. The ability to upload scope and report files as PDF documents is allowed, and a notification will be sent to the audit's primary/other contacts as well as the site contacts (automatically generated). The new scope and report form options are listed as 'Add Report' and 'Add Scope Letter', while the old upload file methods are listed as 'Upload Scope Letter File' and 'Upload Report'.<br><br>

<sup>1</sup> - For IQA Field Service Audit Type, in place of UL Site and Specific Audit Area.<br>
<sup>2</sup> - For IQA and Regional Internal Audits.<br>
<sup>3</sup> - For 'Local Function and CBTL' Audit Type.<br><br>

<u class="web-subtitle">Regional Field Services Audit Details</u><br>
The only exception to what is listed above for Regional Field Services audits is that only uploaded scopes and reports are allowed. There is no option for using the new reporting and scope formats.<br><br>

<u class="web-subtitle">QRS Audit Details</u> - No longer used<br>
<ul class="arrow2">
<li class="arrow2">Year</li>
<li class="arrow2">Month</li>
<li class="arrow2">Start Date</li>
<li class="arrow2">End Date</li>
<li class="arrow2">Audit Type</li>
<li class="arrow2">UL Site</li>
<li class="arrow2">Status</li>
<li class="arrow2">Auditor</li>
<li class="arrow2">Primary Contacts</li>
<li class="arrow2">Scope/Report (DMS File Number)</li>
</ul><br />

<u class="web-subtitle">Accreditation Services Audit Details</u><br>
<ul class="arrow2">
<li class="arrow2">Year</li>
<li class="arrow2">Month</li>
<li class="arrow2">Start Date</li>
<li class="arrow2">End Date</li>
<li class="arrow2">Audit Type/Accreditor</li>
<li class="arrow2">UL Site</li>
<li class="arrow2">Status</li>
<li class="arrow2">Site Contact</li>
<li class="arrow2">Accreditation Services Contact</li>
<li class="arrow2">Report (optional)</li>
<li class="arrow2">Agenda File (optional)</li>
<li class="arrow2">Scope</li>
</ul><br />

<u class="web-subtitle">Regional Accreditation Audit Details</u><br>
<ul class="arrow2">
<li class="arrow2">Year</li>
<li class="arrow2">Month</li>
<li class="arrow2">Start Date</li>
<li class="arrow2">End Date</li>
<li class="arrow2">Audit Type/Accreditor</li>
<li class="arrow2">UL Site</li>
<li class="arrow2">Status</li>
<li class="arrow2">Site Contact</li>
<li class="arrow2">Scope</li>
</ul><br />

<u class="web-subtitle">Corporate Finance Audit Details</u><br>
<ul class="arrow2">
<li class="arrow2">Year</li>
<li class="arrow2">Month</li>
<li class="arrow2">Start Date</li>
<li class="arrow2">End Date</li>
<li class="arrow2">UL Site</li>
<li class="arrow2">Status</li>
<li class="arrow2">Auditors</li>
<li class="arrow2">Audit Type</li>
<li class="arrow2">Scope Letter File (Optional)</li>
<li class="arrow2">Scope</li>
</ul><br />

<!--- added 11/09/2009 --->
<u class="web-subtitle">Laboratory Technical Audit Details</u><br>
<ul class="arrow2">
<li class="arrow2">Year</li>
<li class="arrow2">Month</li>
<li class="arrow2">Start Date</li>
<li class="arrow2">End Date</li>
<li class="arrow2">Auditor</li>
<li class="arrow2">UL Site</li>
<li class="arrow2">Laboratory Name</li>
<li class="arrow2">Status</li>
<li class="arrow2">Primary Contact (Email)</li>
<li class="arrow2">Primary Contact Name</li>
<li class="arrow2">Other Contact(s) (Email)</li>
<li class="arrow2">Scope Letter (web form)</li>
<li class="arrow2">Report (upload)</li>
<li class="arrow2">Notes</li>
</ul>
--->

<cfinclude template="webhelp_EndOfPage.cfm">