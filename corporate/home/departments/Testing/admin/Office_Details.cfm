<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=select_office.cfm>UL Locations</a> - Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("URL.msg")>
	<font class="warning"><b>Message:</b> <cfoutput>#url.msg#</cfoutput></font><br /><br />
</cfif>

<cfquery Datasource="Corporate" name="Details">
SELECT *
FROM IQAtblOffices
WHERE ID = #URL.ID#
</CFQUERY>

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfif curyear gte 2006 AND curyear lte 2008>
	<cfset StartYear = 2006>
<cfelseif curyear gte 2009 AND curyear lte 2011>
	<cfset StartYear = 2009>
<cfelseif curyear gte 2012 AND curyear lte 2014>
	<cfset StartYear = 2012>
<cfelseif curyear gte 2015 AND curyear lte 2017>
	<cfset StartYear = 2015>
<cfelseif curyear gte 2018 AND curyear lte 2020>
	<cfset StartYear = 2018>
<cfelseif curyear gte 2021 AND curyear lte 2023>
	<cfset StartYear = 2021>
</cfif>

<cfoutput>
    <cflock scope="SESSION" timeout="60">
        <CFIF SESSION.Auth.AccessLevel is "SU"
            OR SESSION.Auth.AccessLevel is "Admin"
            OR SESSION.Auth.AccessLevel is "IQAAuditor">
            <cfset AuditedBy = "IQA">
        <cfelse>
            <cfset AuditedBy = #SESSION.Auth.SubRegion#>
        </cfif>
    </cflock>
</cfoutput>

<b>Details</b><br />
<cfoutput query="Details">
<u>Office Name</u>: #OfficeName#<Br>
<u>Region</u>: #Region#<br>
<u>SubRegion</u>: #SubRegion#<br><Br />

<b>Office Status</b><br>
<cfif Exist eq "Yes">
	Active [<A href="Office_Details_Status.cfm?ID=#URL.ID#">Edit</a>]
<cfelseif Exist eq "No">
	Inactive - Audits cannot be added for inactive sites [<A href="Office_Details_Status.cfm?ID=#URL.ID#">Edit</a>]
</cfif>
<br><br>

<b>Additional Information</b> [<a href="Office_Details_Edit.cfm?ID=#ID#">Edit</a>]<br />
<u>Verification Services Internal Audit Site</u>: <cfif VS eq "Yes">#VS#<cfelse>No</cfif><br />
<u>WiSE Internal Audit Site</u>: <cfif Wise eq "Yes">#WiSE#<cfelse>No</cfif><br />
<u>Life and Health Sciences Internal Audit Site</u>: <cfif LHS eq "Yes">#LHS#<cfelse>No</cfif><br />
<u>UL Environment (ULE) Audit Site</u>: <cfif ULE eq "Yes">#ULE#<cfelse>No</cfif><br />
<u>Lab Scope Review Required</u>: <cfif LabScope eq "Yes">#LabScope#<cfelse>No</cfif><br /><br />

<b>Activity Log</b> (as of 10/5/2012)<br />
<a href="Office_Details_Log.cfm?ID=#ID#">View Activity Log</a><br /><Br />

<b>OSHA SNAP Sites and IC Form Requirement</b><br />
<u>OSHA SNAP Site</u>: <cfif SNAPSite eq "yes">#SNAPSite#<cfelse>No</cfif> [<a href="SNAP_Details.cfm?ID=#ID#">View Details / Edit</a>]<br />
<u>IC Form Required</u>: <cfif IC eq "Yes">#IC#<cfelse>No</cfif> [<a href="IC_Edit.cfm?ID=#ID#">View Details / Edit</a>]<br /><br />

<b>Audit Contacts</b> [<a href="editcontacts.cfm?ID=#ID#">Edit</a>]<br />
<u>IQA Audits - Contacts</u><Br />
<cfif NOT Len(RQM) AND NOT LEN(QM) AND NOT LEN(GM) AND NOT LEN(LES) AND NOT LEN(Other) AND NOT LEN(Other2)>
	None Listed<br /><br />
<cfelse>
	<cfif len(RQM)>#replace(RQM, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(QM)>#replace(QM, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(GM)>#replace(GM, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(LES)>#replace(LES, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(Other)>#replace(Other, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(Other2)>#replace(Other2, ", ", "<br />", "All")#<br /></cfif>
    <br />
</cfif>

<u>Regional Audits - Contacts</u><br />
<cfif NOT len(Regional1) AND NOT len(Regional2) AND NOT len(Regional3)>
	None Listed<br /><br />
<cfelse>
	<cfif len(Regional1)>#replace(Regional1, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(Regional2)>#replace(Regional2, ", ", "<br />", "All")#<br /></cfif>
    <cfif len(Regional3)>#replace(Regional3, ", ", "<br />", "All")#<br /></cfif>
	<br />
</cfif>

<u>IQA Audits - Contacts</u>: Recieve notifications of Corporate Internal Quality Audits.<br /><br />

<u>Regional Audits - Contacts</u>: Recieve notifications of Local/Regional Quality Audits.<br /><br />

<cflock scope="Session" timeout="5">
	<cfif Session.Auth.AccessLevel eq "SU">
        <cfquery Datasource="Corporate" name="Labs">
        SELECT * from IQAOffices_Areas
        WHERE ID = #URL.ID#
        AND IQA = 1
        ORDER BY LAB
        </CFQUERY>

        <B>Labs</B>
            [<a href="labs.cfm?OfficeName=#ID#">Edit</a>] - Removed from View
        <br />
        <cfloop query="Labs">
        #Lab#<br />
        </cfloop><br />
	</cfif>
</cflock>

<b>Audit Coverage</b><br />
:: <a href="audit_coverage.cfm?OfficeName=#OfficeName#&Year=#StartYear#&AuditedBy=#AuditedBy#">View</a><br /><br />

<cflock scope="Session" timeout="5">
	<cfif Session.Auth.AccessLevel eq "SU">
        <b>Audit Plan</b> - Removed from View<br />
        :: <a href="Audit_Plan.cfm?OfficeName=#OfficeName#&Start=#StartYear#&AuditedBy=#AuditedBy#">View</a><br /><br />
	</cfif>
</cflock>
</cfoutput>

<cfif Details.SuperLocation eq "No">
    <b>Lab Coverage</b><br />
    <cfquery Datasource="UL06046" name="LabCoverage" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT *
    FROM LabCoverage
    WHERE OfficeID = #URL.ID#
    </cfquery>

    <cfif LabCoverage.recordCount GT 0>
        <cfoutput query="LabCoverage">
            <a href="#IQARootDir#LabCoverage/#FileName#"><b>View</b></a> Lab Coverage File<br />
            <a href="LabCoverage.cfm?ID=#URL.ID#&Exist=Yes">Upload</a> Lab Coverage File*<br />
            <a href="#IQARootDir#LabCoverage/Template/LabCoverageTemplate.xlsx">View</a> Lab Coverage Template<br /><br />

            <u>Note</u> - Uploading a new Lab Coverage file will overwrite the old file.<Br /><br />

            <cfif len(Notes)>
            <u>Notes</u><br />
            #Notes#
            </cfif>
        </cfoutput>
    <cfelse>
        <cfoutput>
            Lab Coverage File not found.<br /><br />
            <a href="LabCoverage.cfm?ID=#URL.ID#&Exist=No">Upload</a> Lab Coverage File<br />
            <a href="#IQARootDir#LabCoverage/Template/LabCoverageTemplate.xlsx">View</a> Lab Coverage Template
        </cfoutput>
    </cfif>
<cfelse>
	<b>Lab Coverage</b><br />
    <u>Note</u> - Lab Coverage Files are not available for Super-Locations.
</cfif><br /><br />

<cfoutput>
<b>Audits</b><Br />
<A href="#IQARootDIr#audit_list2.cfm?type=location&type2=#Details.OfficeName#&Year=#curYear#">View</A> All Audits of #Details.OfficeName#
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->