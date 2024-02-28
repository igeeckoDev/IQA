<cfset subTitle = "Web Help - Scope Letter Form">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Scope Letter Details</u><br>
All scope letters sent by IQA use the same form letter. The specific details can be found in the Attachment A file included in the Scope Letter, and available as a link when viewing a scope letter on the IQA Website. The scope letter is different for several types of audits: Desk Audits, MMS, and IQA Field Services. The basic scope letter is shown below.<br><br>

<u class="web-subtitle">Quality System Scope</u><br>
Quality System Scope Letter Template - <a href="../IQAScope_Webhelp.cfm">View</a><br><Br>

<u>Required Fields</u><br>
<ul>
<li>Date Sent (Current Date will be automatically used)</li>
<li>Contact Name</li>
<li>Title</li>
<li>Email (External UL Email Address, taken from Audit Details page)</li>
<li>Start Date (From audit details)</li>
<li>End Date (From audit details)</li>
<li>Auditor Email (auto fill from auditor profile)</li>
<li>Additional Recipients (cc) (External UL Email Addresses, taken from Audit Details page)</li>
<!---<li>Auditor Phone Number (auto fill from auditor profile)</li>--->
</ul><br><Br>

<!---There are several Scope Letter formats.<br>
<ul>
<li>IQA Field Services</li>
<li>Program</li>
<li>Quality System</li>
<li>TPTDP</li>
</ul>

Each format has specific information that is necessary, which is documented below.
<br><br>

<u class="web-subtitle">IQA Field Services Scope</u><br>
IQA Field Service Scope Letter Template - <a href="FSTemplate.cfm" target="_blank">View</a><br><br>

<u>Required Fields</u><br>
<ul>
<li>Date Sent (Current Date will be automatically used)</li>
<li>Contact Name</li>
<li>Title</li>
<li>Email (External UL Email Address)</li>
<li>Start Time</li>
<li>Start Date (From audit details - can be changed here)</li>
<li>End Date (From audit details - can be changed here)</li>
<li>Auditor Email (auto fill from auditor profile)</li>
<li>Additional Recipients (cc) (External UL Email Addresses)</li>
<li>Auditor Phone Number (auto fill from auditor profile)</li>
</ul>

<u class="web-subtitle">Program Scope</u><br>
Program Scope Letter Template - <a href="ProgTemplate.cfm" target="_blank">View</a><br><br>

<u>Required Fields</u><br>
<ul>
<li>Date Sent (Current Date will be automatically used)</li>
<li>Contact Name</li>
<li>Title</li>
<li>Email (External UL Email Address)</li>
<li>Start Date (From audit details - can be changed here)</li>
<li>End Date (From audit details - can be changed here)</li>
<li>Auditor Email (auto fill from auditor profile)</li>
<li>Additional Recipients (cc) (External UL Email Addresses)</li>
<li>Auditor Phone Number (auto fill from auditor profile)</li>
</ul>

<u class="web-subtitle">Quality System Scope</u><br>
Quality System Scope Letter Template - <a href="QSTemplate.cfm" target="_blank">View</a><br><br>

* - This Template is used for Corporate, Global, and Local Function audit types (including 'Local Function and CBTL' and 'Local Function and Field Service')<br><br>

<u>Required Fields</u><br>
<ul>
<li>Date Sent (Current Date will be automatically used)</li>
<li>Contact Name</li>
<li>Title</li>
<li>Email (External UL Email Address)</li>
<li>Start Date (From audit details - can be changed here)</li>
<li>End Date (From audit details - can be changed here)</li>
<li>Auditor Email (auto fill from auditor profile)</li>
<li>Additional Recipients (cc) (External UL Email Addresses)</li>
<li>Auditor Phone Number (auto fill from auditor profile)</li>
</ul>

<u class="web-subtitle">TPTDP Scope</u><br>
TPTDP Letter Template - <a href="TPTDPTemplate.cfm" target="_blank">View</a><br><br>

<u>Required Fields</u><br>
<ul>
<li>Date Sent (Current Date will be automatically used)</li>
<li>Contact Name <sup>1</sup></li>
<li>Email <sup>4</sup></li>
<li>Client Address <sup>1</sup></li>
<li>File Number <sup>1</sup></li>
<li>Start Date <sup>2</sup></li>
<li>End Date <sup>2</sup></li>
<li>Auditor Email <sup>3</sup></li>
<li>Additional Recipients (cc)</li>
<li>Auditor Phone Number <sup>3</sup></li>
</ul>

<sup>1</sup> - Auto fill from TPTDP Client Info<br>
<sup>2</sup> - From Audit Details - can be changed here<br>
<sup>3</sup> - Auto fill from auditor profile<br>
<sup>4</sup> - External UL Email Addresses<br><br>
--->

<u class="web-subtitle">Sending Scope Letters</u><br>
Once this information is filled out, please click 'Submit Scope Letter'. You will be taken to a page that fills in the blanks on the Scope Letter Template. Please check to make sure everything is correct. If not, press the 'back' button on your browser and make the necessary changes. On the bottom of this page, an Attachment A file is necessary to continue. This file should be a PDF format file. Once you have uploaded this file, please click 'Send Scope Letter'. At this point the scope letter is sent to all recipients and you are taken to view the scope letter.<br><br>

All other pertinent information is pulled from the audit details, such as Office, Audit Area, Lead Auditor, and Auditor. These fields are not able to be edited.<br><br>

<font color="red"><u>Important</u></font>: If the email addresses area improperly entered, the scope letter will not be sent. Please use the <a href="/phonelist/" target="_blank">Global Employee Directory</a> to verify the email addresses are correct. The preferred method would be to copy/paste the email addresses to prevent unintentional typographical errors.<br><br>

<cfinclude template="webhelp_EndOfPage.cfm">