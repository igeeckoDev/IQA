<cfset subTitle = "Web Help - Audit Types">
<cfinclude template="webhelp_StartOfPage.cfm">

<u class="web-subtitle">Adding an Audit - Audit Types</u><br>
Below are lists of audit types available. When scheduling an audit with the IQA Tool, you must first specify the type of audit and the specific audit area in order to determine what information is needed for scheduling.<br><br>

<u class="web-subtitle">List of IQA Audit Types</u><br>
<ul>
<li><u>Corporate</u> - Audit of a corporate function and corporate process owner</li>
<li><u>Field Services</u> - Audit of the Field Service organization</li>
<li><u>Global Function/Process</u> - Audit conducted globally (all regions) of a specific function/process</li>
<li><u>Local Functio</u>n - Site Audit of processes and/or Labs, may include CBTL and/or Field Service activities</li>
<li><u>Program</u> - Audit of a specific program such as UL Mark - Listing / Classification / Recognition</li>
<li><u>Technical Assessment</u> - Audit (technical) normally of project files</li>
<li><u>OSHA SNAP</u> - DAP Project Audits of UL SNAP Locations</li>
</ul>
<br />

<u class="web-subtitle">List of Regional Audit Types</u><br>
* Not including Field Services (see next heading)<br>
<ul>
<li><u>Accreditation Audit</u> - Audits by accreditors that the Accreditation Services group does not handle (See AS below)</li>
<li><u>Local Function</u> - Site Audit of processes and/or Labs, may include CBTL and/or Field Service activities</li>
<li><u>Technical Assessment</u> - Audit (technical) normally of project files</li>
</ul>
<br />

<u class="web-subtitle">Other Audit Types</u><br>
<ul>
<li><u>Accreditation Services (AS)</u></li><br>
<cfquery Datasource="Corporate" name="Accred"> 
SELECT * from ASAccreditors
Order By Accreditor
</CFQUERY>

<CFOUTPUT Query="Accred">
&nbsp;&nbsp; - #Accreditor#<br>
</CFOUTPUT>

<li><u>Corporate Finance</u> - Risk Assessment</li>
<li><u>Field Services</u> - Global Field Operation Internal Technical Audits</li>
<!---<li>QRS</li><br>
&nbsp;&nbsp; - Accreditation<br>
&nbsp;&nbsp; - EMS<br>
&nbsp;&nbsp; - QMS<br>
--->
<li><u>Verification Services</u></li>
<li><u>WiSE<</u>/li>
<li><u>Laboratory Technical Audit</u> - Audit of a UL Lab's Scope of Capability by Global Test and Laboratory Compliance</li>
</ul>
<br />

<u class="web-subtitle">Audits No Longer Stored IQA</u><br>
<ul>
<li><u>QRS</u> - Internal QRS audit (2005-2007 only)</li>
<li><u>TPTDP</u> - Third Party Test Data Participant - GALO audits only (2004-2007 only)</li>
</ul>
<br />

<u class="web-subtitle">Specific Audit Areas - Local Function</u><br>
These Audit Areas are selected for each audit. After you have submitted the first page of audit details, a drop down box will supply you with the options below.<br><br>

<CFQUERY Name="LF" Datasource="Corporate">
SELECT * From LocalFunctions
Order BY Function
</CFQUERY>

<ul>
<CFOUTPUT query="LF">
<li>#Function#</li>
</CFOUTPUT>
</ul>
<br />

<u class="web-subtitle">Specific Audit Areas - Corporate Function</u><br>
These Audit Areas are selected for each audit. After you have submitted the first page of audit details, a drop down box will supply you with the options below.<br><br>

<CFQUERY Name="CF" Datasource="Corporate">
SELECT * From CorporateFunctions
WHERE Function <> '_test'
Order BY Function
</CFQUERY>

<ul>
<CFOUTPUT query="CF">
<li>#Function#</li>
</CFOUTPUT>
</ul>
<br />

<u class="web-subtitle">Specific Audit Areas - Global Function/Process</u><br>
<CFQUERY Name="GF" Datasource="Corporate">
SELECT * From GlobalFunctions
WHERE Status IS NULL
Order BY Function
</CFQUERY>

<ul>
<CFOUTPUT query="GF">
<li>#Function#</li>
</CFOUTPUT>
</ul>
<br />

<Cfoutput>
<u class="web-subtitle">Specific Audit Areas - Program</u><br>
See <a href="#IQADir#_prog.cfm?list=IQA&order=" target="_blank">Programs Audited by IQA</a><br><br>
</Cfoutput>

<u class="web-subtitle">Specific Audit Areas - Accreditors</u><br>
Note - These audits are not handled by Accreditation Services (AS), rather by Local Quality Staff<br /><br />
<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From Accreditors
WHERE Status IS NULL
Order BY Accreditor
</CFQUERY>

<ul>
<CFOUTPUT query="Accred">
<li>#Accreditor#</li> 
</cfoutput>
</ul>

<cfinclude template="webhelp_EndOfPage.cfm">