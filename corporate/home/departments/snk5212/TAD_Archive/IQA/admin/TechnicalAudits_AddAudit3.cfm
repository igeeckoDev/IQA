<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Add Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- formatted textarea boxes --->
<!---
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">
--->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	*
FROM
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<div align="Left" class="blog-time">
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.2 Add an audit<br /><br />
</cfoutput>
</div>

<b>Audit Details</b><br />
<cfoutput query="Audit">
<u>Audit Number</u>: #URL.Year#-#URL.ID#-#AuditedBy#<br />
<u>Industry</u>: #Industry#<br />
<u>Office Name</u>: #OfficeName#<br />
<cfif len(SNAP)>SNAP Site Status: [#SNAP#]</cfif><Br />
<u>Regional Operations Manager</u>: #ROM#<br />
<cfif len(TAM)>
<u>Technical Audit Manager/Deputy</u>: #TAM#<br />
</cfif>
<u>Audit Type</u>: #AuditType2# <cfif AuditType2 eq "In-Process">(Phase: #AuditPhase#)</cfif><br />
<u>E2E Audit?</u>: <cfif NOT len(E2E)>Not Selected<cfelse>#E2E#</cfif><br />
<cfif AuditType2 eq "Full">
	<u>Quarter Scheduled</u>: Quarter #Month#
<cfelseif AuditType2 eq "In-Process">
	<u>Month Scheduled</u>: #MonthAsString(Month)#
</cfif><br />
<u>Audit Due Date</u>: <cfif len(AuditDueDate)>#dateformat(AuditDueDate, "mm/dd/yyyy")#<cfelse>None Specified</cfif><br />
<cfif AuditType2 eq "In-Process">
	<u>Project Handler</u>: #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept#<br />
	<u>Project Handler's Manager</u>: #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept#<br />
<cfelseif AuditType2 eq "Full">
	<u>Project Evaluator</u>: #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept#<br>
	<u>Project Evaluator's Manager</u>: #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept#<br>
	<u>Test Data Validator</u>: #TDV# / #TDVOffice# / #TDVDept#<br />
	<u>Test Data Validator's Manager</u>: #TDVManager# / #TDVManagerOffice# / #TDVManagerDept#<br />
</cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Program" Datasource="Corporate">
SELECT Program, ID, Type
FROM ProgDev
WHERE (Status IS NULL OR Status = 'Under Review')
ORDER BY Program
</CFQUERY>

<CFQUERY Name="CCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
From TechnicalAudits_CCN
WHERE Status IS NULL
Order BY CCN
</CFQUERY>

<CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
From TechnicalAudits_Standard
WHERE Status IS NULL
Order BY StandardName, RevisionNumber DESC
</CFQUERY>

<br>
<div align="Left" class="blog-time">
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TechnicalAudits_AddAudit3_Action.cfm?ID=#URL.ID#&Year=#URL.YEAR#">

Project Number<br />
<cfinput type="text" name="e_ProjectNumber" size="25" displayname="Project Number">
<Br /><br />

<font class="warning">Note:</font> Any decimals in the project number will be converted to underscores.<br><br>

Project Number Link<br />
<cfinput type="text" name="ProjectLink" size="75" displayname="Project Link">
<Br /><br />

File Number<br />
<cfinput type="text" name="FileNumber" size="25" displayname="File Number">
<Br /><br />

Project Request Type:<br />
<SELECT NAME="e_RequestType" displayname="Project Request Type">
    <OPTION value="" selected>Select Project Request Type
    <OPTION value="">---
    <OPTION value="No Test">No Test
    <OPTION value="Test">Test
</SELECT><br /><br />

Primary Standard<br />
<Select Name="Standard" displayname="Primary Standard">
   	<OPTION value="" selected>Select Standard
   	<OPTION value="">---
    <OPTION Value="">None
	<cfoutput query="Standard">
    	<cfset standardValue = "#StandardName# (#RevisionNumber# - #dateformat(RevisionDate, "mm/dd/yyyy")#)">
		<OPTION VALUE="#standardValue#">#standardValue#
	</cfoutput>
</Select><Br /><br />

Other Standards<br />
<Select Name="Standard2" displayname="Other Standards" multiple="multiple" size="5">
   	<OPTION value="" selected>None
   	<OPTION value="">---
	<cfoutput query="Standard">
    	<cfset standardValue = "#StandardName# (#RevisionNumber# - #dateformat(RevisionDate, "mm/dd/yyyy")#)">
		<OPTION VALUE="#standardValue#">#standardValue#
	</cfoutput>
</Select><Br /><br />

Primary CCN<br />
<cfinput type="text" name="e_CCN" size="25" displayname="Primary CCN" maxlength="5">
<Br /><br />

Other CCNs<br />
Separate CCNs with a comma<br />
<cfinput type="text" name="CCN2" size="75" displayname="Other CCNs">
<Br /><br />

Program<br />
<SELECT NAME="e_Program" displayname="Program">
    <OPTION value="" selected>Select Program
    <OPTION value="">---
    <CFOUTPUT QUERY="Program">
        <OPTION VALUE="#Program#">#Program# (#Type#)
    </CFOUTPUT>
</SELECT>
<br /><br />

Notes:<br>
<br />Note: Max 3200 Characters<br />
	<cfoutput query="Audit">
        <textarea maxlength=3200
          onchange="testLength(this)"
          onkeyup="testLength(this)"
          onpaste="testLength(this)"
          Name="Notes"
          wrap="Physical"
          ROWS="10"
          COLS="60">#replace(Notes, "!", "'", "All")#</textarea>
            <script>
            var maxLength = 3200;
            function testLength(ta) {
              if(ta.value.length > maxLength) {
                ta.value = ta.value.substring(0, maxLength);
              }
            }
            </script>
    </cfoutput>

<br /><br />
<b><Font class="warning">Note</Font></b>: If you wish to add a carriage return and start a new paragraph, add the characters <b>&lt;br&gt;</b><br />
This will add one carriage return. (Add this tag twice for two carriage returns, etc)<br /><br />

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfFORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->