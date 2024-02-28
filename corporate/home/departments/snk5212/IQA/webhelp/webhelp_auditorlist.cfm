<cfset subTitle = "Web Help - Auditor List/Adding an Auditor">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Auditor List</u><br>
The auditor list shows the name, location, qualifications, and status of internal auditors. It is not possible to schedule an auditor to conduct an audit with this tool unless they are listed on the auditor list and have the proper qualifications listed.<br><br>

*Note - Only applicable to IQA and Regional auditors, including Field Services. For Accreditation Services, QRS, Laboratory Technical Audit, and Finance, see below.
<br><br>

<u class="web-subtitle">Auditor Profile</u><br>
On the Auditor List page, select an auditor's profile by clicking 'View Profile' listed next to their name. This view will show you the following information about the auditor:<br>
<ul>
<li>Auditor Name</li>
<li>Location and Region</li>
<li>Status</li>
<li>Email Address</li>
<li>Auditor Qualifications (Types of audits they can perform)</li>
<li>Expertise</li>
<li>Training</li>
<li>Comments</li>
<li>Auditor Qualification Files (Training, Certificates, etc)</li>
</ul>

The auditor list and details are maintained by the Regional and Local Quality Managers, as well as IQA staff for IQA Auditors.<br><br>

<u class="web-subtitle">Auditor Qualifications</u><br>
An auditor must have certain qualifications listed in their auditor profile in order to be scheduled for an audit. The types of qualifications are:<br>
<ul>
<li>CBTL</li>
<li>Field Services</li>
<!--- added 11/09/2009 --->
<!---<li>EHS (Environmental Health and Safety) ***</li>--->
<li>MMS - Medical Management Systems</li>
<!--- /// --->
<!--- added date range --->
<li>QRS (2005-2007)</li>
<!--- /// --->
<li>Quality System *</li>
<!--- added date ranges --->
<li>SMT - Quality (2004-2007) **</li>
<li>SMT - Technical (2004-2007) **</li>
<!--- /// --->
<li>Technical Assessment</li>
<li>TPTDP (2004-2007)</li>
</ul><Br>

* - Includes Corporate, Global, Local Function, Local Function and CBTL, Local Function and Field Services, Scheme, Program, and Certification Body audits.<br><br>

** - SMT type audits are not scheduled in this tool, however if an auditor is qualified SMT, it is tracked in their profile. Applicable for 2004-2007 - no longer tracked.<br>
<!---
*** - Effective January 2010<br>
--->
<br>


<u class="web-subtitle">Adding/Editing Auditors - IQA, Regional, IQA and Regional Field Services</u><br>
On the Auditor List main page, select 'Add a new Auditor'.<br><br>

The Add Auditor page will require the following information:<br>
<ul>
<li>Auditor Name</li>
<li>Email (external UL email address)</li>
<li>Status (Active, Inactive)</li>
<li>Types of Audits Qualified to Conduct</li>
<li>Location</li>
<li>Expertise</li>
<li>Training</li>
<li>Comments</li>
<li>Confirm Auditor Last Name</li>
</ul>

Additionally, auditor qualification files can be uploaded to show evidence of documents, training, certifications and any other item listed in the 'Expertise' and 'Training' Fields.<br><br>

Once an auditor profile has been added, you can edit some information contained in the profile. On the Auditor Details page, select 'edit'. The page will resemble the add audit page. Once you have changed the information on this page, select 'Save and Continue'.<br><br>

For both add and edit: If any required fields are left blank, you will receive a notification that the form cannot be submitted until these fields are completed.<br><br>

<u class="web-subtitle">Adding/Editing Auditors - Accreditation Services, Finance, Laboratory Technical Audit</u><br>
These areas maintain separate auditor lists. There are no qualifications. Depending on your access, the auditor lists are listed as:<br><br>

<ul>
<!--- listed edited 11/09/2009 - LTA added, QRS Removed --->
<li>Corporate Finance Auditor List (Finance)</li>
<!--- <li>Auditor List (QRS)</li>--->
<li>LTA Auditor List (Laboratory Technical Audit)</li>
<!--- VS and Wise Added August 2012 --->
<li>Verification Services (VS) Auditor List</li>
<li>WiSE Auditor List</li>
<!--- ULE Auditor List Added Jan 2014 --->
<li>UL Environment (ULE) Auditor List</li>
<li>Manage Accreditation Services Contacts</li>
</ul><br>

In order to add an auditor, simply add the auditor name and press 'submit' on the page listed above. If the auditor already exists on the list, you will recieve a notification. If you wish to edit a name, select '(edit)' listed next to the auditor's name. This allows you to change the name of the auditor, or to delete the auditor. All auditors listed on these lists are able to be scheduled for an audit within their area (Accreditation Services, Finance, Laboratory Technical Audit).<br><br>

<u class="web-subtitle">Access</u><br>
 - IQA staff have access to add/edit all Auditor Profiles.<br>
 - RQMs/LQMs have access to add/edit their Region's Auditor Profiles.<br>
 - Field Services Staff have access to add/edit Field Service Auditor Profiles.<Br>
 <!--- added August 2012--->
 - Other Entities, such as VS/WiSE/ULE, have access to add/edit their owner Auditor List.<br />
 <!--- /// --->
 - Finance and Laboratory Technical Audit have access to add/edit their own Auditors only.<br><br>
 
 A full list of audits on the 'View Audits' page reveals all areas that have access to add/manage audits on the site.<br>

<cfinclude template="webhelp_EndOfPage.cfm">