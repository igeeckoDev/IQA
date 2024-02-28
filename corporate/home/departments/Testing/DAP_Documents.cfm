<!---
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP - Documents">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset dcsLink = "http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/">

<cfoutput>
<table border="1" cellspacing="0" cellpadding="0" width="1000">
    <tbody>
        <tr>
            <th width="225" colspan="2" valign="top">
                <p align="center">
                    Data Acceptance Program Documents
                </p>
            </th>
            <th width="225" colspan="2" valign="top">
                <p align="center">
                    CTF/CBTL Documents
                </p>
            </th>
            <th width="225" colspan="2" valign="top">
                <p align="center">
                    Client Facing Documents
                </p>
            </th>
            <th width="225" colspan="2" valign="top">
                <p align="center">
                    CAP
                </p>
            </th>
        </tr>
        <tr>
            <td width="75" valign="top">
                <p>
					<cfset dcsDoc = "00-IC-P0026">
                    <a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td width="150" valign="top">
                <p align="left">
                    UL Mark Data Acceptance Program
                </p>
            </td>
            <td width="75" valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-S0059">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td width="150" valign="top">
                <p align="left">
                    IECEE CB SCHEME – UL Global Qualification Requirements for CBTLS and ACTLS
                </p>
            </td>
            <td width="75" valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0025">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td width="150" valign="top">
                <p align="left">
                    Data recording, reporting and related requirements
                </p>
            </td>
            <td width="75" valign="top">
                <p>
                    <cfset dcsDoc = "00-CM-S0850">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td width="150" valign="top">
                <p align="left">
                    Certificated Agency Program
                </p>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-S0056">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    DAP Assessment Procedure
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-F0873">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    CTF Stage 3 &amp; 4 Application Form
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0032">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Calibration certificate analysis
                </p>
            </td>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-CM-F0852">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    - UL Certificated Agency Program Audit Report Form
                </p>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-S0084">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Procedure for Assessing Engineering Evaluation Competency of DAP TCP and Preferred Partner Program Participants
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-S0860">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p>
                    IECEE CB Scheme - Third Party Utilization of Customers Testing Facilities - Stage 3 &amp;4
                </p>
                <p>
                    Data Acceptance Program - Assessment Fulfillment Procedure
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0033">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Critical consumables
                </p>
            </td>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-CM-C0851">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    UL Certificated Agency Program Requirements (external)
                </p>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0031">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    DAP Assessment Tool
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-S0406">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p>
                	IECEE CB Scheme - Ongoing Maintenance and Audits of Existing UL CBTLs
				</p>
            </td>
            <td align="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0034">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Equipment accuracy
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0029">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    DAP In-house Calibration Checklist
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-F0139">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    IECEE CTF Stage 3/4 and ATEX/IECEX PWT Assessment Report Forms
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0045">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Equipment calibration intervals
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0405">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    ISO/IEC – 17025:2005 DAP Lead Auditor Oversight Form
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-S0425">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    IECEE CTF Stage 3/4 and CBTL Lead and Technical Assessor Training Requirements and Qualification Criteria
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0036">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Laboratory Power Quality
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0406">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Qualification Form For DAP and/or SMT L3 (Project Reviewer)
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-W0850">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Work Instructions IECEE/CB Scheme for Global SMT Conversion
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0037">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Acceptance of Thermocouple Wires
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0035">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    TCP Annual Review and Authorization Form
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-F0406">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Qualification Form For DAP and/or SMT L3 (Project Reviewer)
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0035">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Environment – Laboratory Ambient Conditions
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0036">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    TCP Assessment Checklist
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-F0871">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    IECEE CB SCHEME CTF Stage 3 AGREEMENT
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0401">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Authorized Signatory Responsibilities
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-F0400">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    PPP Annual Review and Authorization
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-F0867">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    IECEE SMT AND CBTL Lead And Technical Assessor Training Requirements And Qualification Criteria
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0043">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    CTDP Implementation Guide For Dap Clients
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-W0043">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    WI for DAP/MTL Oracle forms
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-S0868">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    IECEE SMT AND CBTL Lead And Technical Assessor Training Requirements And Qualification Criteria
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-J0027">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Expired Calibrations
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-W0400">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    WI for DAP use of ePro Audit Profile
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-S0049">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    IECEE CB Scheme/ECS Manufacturers’ Testing Program TMP/WMT*, customers’ testing facilities Stage 1/ Stage 2 and Special UL Subcontracting –
                    Wst Procedures
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-OP-C0038">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Equipment – In-house Calibration Requirements and use of Non-Accredited Calibration Service Providers
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-W0403">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    WI for PPP/TCP Engineering Assessment
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    <cfset dcsDoc = "00-IC-P0035">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p>
                    International Certification Program Policy
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-J0042">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    DAP Assessment Tool User's Guide
                </p>
            </td>
            <td valign="top">
				<p>
					<cfset dcsDoc = "00-IC-F0868">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
				</p>
            </td>
            <td valign="top">
				<p align="left">
					IECEE CTF Stage 3/4 and CBTL Technical Assessor Candidate Application Form
				</p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-J0027">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Expired Calibrations Job Aid
                </p>
            </td>
            <td valign="top">
				<p>
                    <cfset dcsDoc = "00-IC-S0862">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
				<p align="left">
					IECEE CB Scheme/ECS Manufacturers'' Testing Program<br>
					Customers'' Testing Facilities Stage 3 / Stage 4
				</p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-S0854">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p align="left">
                    Description of Data Acceptance Programs
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-S0055">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p>
                    Data Acceptance Program Suspension and Withdrawal Procedure
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p>
                    <cfset dcsDoc = "00-OP-S0058">
					<a href="#dcsLink##dcsDoc#/#dcsDoc#.docx">#dcsDoc#</a>
                </p>
            </td>
            <td valign="top">
                <p>
                    Standard Operating Procedure for Data Acceptance Program (DAP) - Customer Service
                </p>
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
            <td valign="top">
            </td>
        </tr>
    </tbody>
</table>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
--->