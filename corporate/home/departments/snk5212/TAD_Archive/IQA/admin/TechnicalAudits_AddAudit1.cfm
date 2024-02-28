<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Add Audit (Type: #URL.Type#)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY Name="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Industry
Order BY Status DESC, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT IQAtblOffices.OfficeName, IQAtblOffices.ID, IQAtblOffices.Region, IQAtblOffices.SubRegion
FROM IQAtblOffices, IQARegion
WHERE IQARegion.TechnicalAudits_Required = 'Yes'
AND IQAtblOffices.Region = IQARegion.Region
AND IQAtblOffices.Exist = 'Yes' 
AND IQAtblOffices.SuperLocation = 'No'
ORDER BY IQAtblOffices.Region, IQAtblOffices.SubRegion, IQAtblOffices.OfficeName
</cfquery>

<cfquery Datasource="Corporate" name="getROM"> 
SELECT 
	TechnicalAudits_ROM as ROM, Region
FROM 
	IQARegion
WHERE
	TechnicalAudits_Required = 'Yes'
ORDER BY 
	Region
</CFQUERY>

<cfquery Datasource="UL06046" name="getTAMList"> 
SELECT 
	Name, Email
FROM 
	TechnicalAudits_TAMList
WHERE
	Status IS NULL
ORDER BY 
	Name
</CFQUERY>

<cfoutput>
<b>Audit Type</b>: #URL.Type#<Br /><br />
</cfoutput>

<div align="Left" class="blog-time">
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<Cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.2 Add an audit<br /><br />
</Cfoutput>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TechnicalAudits_AddAudit1_Action.cfm">

<cfoutput>
<cfinput type="hidden" name="AuditedBy" value="Technical Audit">
<cfinput type="hidden" name="AuditType" value="Technical Audit">
	<cfset maxyear = #curyear# + 3>
<cfinput type="hidden" name="AuditType2" value="#URL.Type#">

<cfif url.type eq "Full">
	<cfset maxMonthNumber = 4>
    <cfset MonthLabel = "Quarter">
<cfelseif url.type eq "In-Process">
	<cfset maxMonthNumber = 12>
    <cfset MonthLabel = "Month">
</cfif>

</cfoutput>

Audit Year (Required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
	<cfloop index="i" to="#maxyear#" from="#curyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
	</cfloop>
</SELECT>
<br><br>

<cfoutput>
#MonthLabel# Scheduled (Required)<br>
<SELECT NAME="e_Month" displayname="#MonthLabel#">
		<option value="">Select #MonthLabel# Below
		<option value="">---
        </cfoutput>
	<cfloop index="i" to="#maxMonthNumber#" from="1">
		<cfoutput>
        	<OPTION VALUE="#i#"><cfif URL.Type eq "In-Process">#MonthAsString(i)#<cfelse>Quarter #i#</cfif>
		</cfoutput>
	</cfloop>
</SELECT>
<br><br>

<cfif URL.Type eq "In-Process">
In-Process Audit Phase<br />
<SELECT NAME="e_AuditPhase" displayname="In-Process Audit Phase">
    <OPTION value="" selected>Select In-Process Audit Phase</OPTION>
    <OPTION VALUE="IA - After Prime Review">IA - After Prime Review</OPTION>
    <OPTION VALUE="PTA - Test Data Validation">PTA - Test Data Validation</OPTION>
</SELECT><Br /><br />
</cfif>

Is this an E2E audit?<Br />
<SELECT NAME="e_E2E" displayname="E2E Audit?">
    <OPTION value="" selected>Select Yes/No</OPTION>
    <OPTION VALUE="Yes">Yes</OPTION>
    <OPTION VALUE="No">No</OPTION>
</SELECT><Br /><br />

<cfset SubRegionHolder = "">

Site / Office Name (Required)<Br />
<SELECT NAME="e_OfficeName" displayname="Do no select Region/Subregion - Office Name">
    <OPTION value="" selected>Select Site</OPTION>
    <CFOUTPUT QUERY="OfficeName">
	    <cfif NOT len(SubRegionHolder) OR SubRegionHolder NEQ SubRegion>
        	<OPTION value="">---</OPTION>
    	    <OPTION>#Region# / #SubRegion#</OPTION>
        </cfif>
                    
        <OPTION VALUE="#OfficeName#"> &nbsp; #OfficeName#</OPTION>
    
    <cfset SubRegionHolder = SubRegion>
    </CFOUTPUT>
</SELECT><Br /><br />

Site SNAP Status - SNAP / NRTL / Other<br />
<SELECT NAME="e_SNAP" displayname="Site SNAP Status">
    <OPTION value="" selected>Select Site SNAP Status</OPTION>
    <OPTION VALUE="SNAP">SNAP</OPTION>
    <OPTION VALUE="NRTL">NRTL</OPTION>
    <OPTION VALUE="Other">Other</OPTION>
</SELECT><Br /><br />

Industry (Required)<br />
<Select Name="e_Industry" displayname="Industry">
   	<OPTION value="" selected>Select Industry
   	<OPTION value="">---
	<cfoutput query="Industry">
		<OPTION VALUE="#Industry#">#Industry#
	</cfoutput>
</Select>
<Br /><br />

Regional Operations Manager (Required)<br>
<SELECT NAME="e_ROM" displayname="Regional Operations Manager">
		<option value="">Select Regional Operations Manager
		<option value="">---
	<cfoutput query="getROM">
		<OPTION VALUE="#ROM#">#ROM# (#Region#)
	</cfoutput>
</SELECT>
<br><br>

Deputy Technical Audit Manager Assignment (Optional)<br>
<SELECT NAME="e_TAM" displayname="Technical Audit Manager">
		<option value="">Select Technical Audit Manager
		<option value="None">None
        <option value="">---
	<cfoutput query="getTAMList">
		<OPTION VALUE="#Email#">#Name#
	</cfoutput>
</SELECT>
<br><br>
Note: <font class="warning">Add the Technical Auditor Manager Name ONLY if a SPECIFIC person is handling this Technical Audit. Otherwise, select None.</font><br /><br />

<!---
<cfif URL.Type eq "Full">
Prelimary Review Waived?<br />
Yes <cfinput name="Waived" value="Yes" type="radio" /> No <cfinput name="Waived" value="No" type="radio" checked />
<br /><br />
</cfif>
--->

<!---
Audit Type<br />
<SELECT NAME="e_AuditType2" displayname="Audit Type">
    <OPTION value="" selected>Select Audit Type
    <OPTION value="">---
    <!---<OPTION value="End to End">End to End--->
    <OPTION value="Full">Full
    <OPTION value="In-Process">In-Process
</SELECT><br /><Br />
--->

<!---
Audit Due Date (Optional)<br>
<div style="position:relative; z-index:3">
<cfinput type="datefield" name="AuditDueDate" maxlength="10">
</div>
<Br /><br /><br />
--->

<!---
<cfinput type="Submit" name="Submit" value="Save and Continue">
--->

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfFORM>
</div>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->