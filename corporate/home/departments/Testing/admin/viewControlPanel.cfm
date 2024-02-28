<!--- Start of Page File --->
<cfset subTitle = "Superuser Control Panel - Database Controls">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

Select an item below. You can Add, Edit, or Remove items from these pages.<br><br>

<!---:: <a href="cf.cfm">Corporate Functions</a><br />--->
:: <a href="gf.cfm">Global Function/Processs</a><br />
In order to add a 'Global Function/Process' audit, an item needs to be added to this page.<br><br>

:: <a href="SME.cfm">Subject Matter Expert (SME) List</a><br />
In order to add an SME to an audit, add them here first.<br><br>

<!---:: <a href="lf.cfm">Local Function Types</a><br />--->

:: <a href="ASAccred.cfm">Accreditation Services Accreditors</a><br />
CJN Note - Do not modify this list.<br><br>

:: <a href="Accred.cfm">All Accreditors List</a><br />
Local/Regional Quality use this list to add accreditors who are conducting audits of UL.<br><br>

:: <a href="CertificationBodies_Schemes.cfm">View Certification Bodies and Associated Schemes</a><br><br>

:: <a href="CertificationBodies.cfm">Certification Bodies</a><br>
Certification Bodies and their associated schemes need to be added before scheduling an audit!<br><br>

:: <a href="_prog.cfm?list=IQA">Programs/Schemes Audited by IQA</a><br>
Programs/Schemes need to be added here before an audit can be scheduled! Select "Add Program" on linked page above.<br /><br>

:: <a href="select_office.cfm">View Locations List Profiles</a><br />
View information about a UL Location<br><br>

:: <a href="UL_Locations_Add.cfm">Add UL Location</a><br />
Add a UL Location - a site must be added before an audit can be added!<br><br>

:: <a href="fus2.cfm">UL Inspection Center Locations</a><br>
Used for "Field Services" audits conducted by John Carlin's group.<br /><br>

:: <a href="SNAP.cfm">UL Sites - OSHA SNAP Matrix</a><br />
Toggle a UL Location's SNAP Status here.<br><br>

:: <a href="IC.cfm">International Certification Form Control</a><br>
Change the status of sites to indicate if an IC Form is required<br /><br>

:: <a href="FAQ.cfm">IQA FAQ</a> - View/Add/Edit<br /><Br /><br>

<!---
<u>Auditor Lists</u><br />
:: <a href="Auditors.cfm?Type=LTA">Laboratory Technical Audit</a><br />
:: <a href="Auditors.cfm?Type=VS">Verification Services</a><br />
:: <a href="Auditors.cfm?Type=ULE">UL Environment</a><br />
:: <a href="Auditors.cfm?Type=WiSE">WiSE</a><br />
:: <a href="Aprofiles.cfm?View=All">Internal Quality Auditors</a> (IQA, Global Quality, Field Services)<br /><br />
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->