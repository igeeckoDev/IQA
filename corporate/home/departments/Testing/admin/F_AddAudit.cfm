<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Corporate Finance / Internal Audit - Edit Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Finance = 'Yes'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="FContact" Datasource="Corporate">
SELECT * FROM FContact
WHERE STATUS IS NULL
ORDER BY FContact
</cfquery>
		
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="AS_AddAudit_Submit.cfm">
<cfoutput>
<cfset maxyear = #curyear# + 3>
</cfoutput>

<br>
Audit Year: (required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#maxyear#" from="#curyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<INPUT TYPE="Hidden" NAME="e_AuditType" VALUE="Finance">
<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="Finance">
<INPUT TYPE="Hidden" NAME="AuditType2" VALUE="Finance">

Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
	<option value="">Select Month
	<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Site being Audited: (required)<br>
<SELECT NAME="e_OfficeName" displayname="Site Audited">
	<OPTION VALUE="">Select Site
	<option value="">---		
<CFOUTPUT QUERY="OfficeName">
	<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

Name of Auditor:<br>
<SELECT NAME="e_FContact" multiple="multiple" displayname="Corporate Finance Auditor">
	<OPTION VALUE="">Select Auditor
	<option value="">---	
<CFOUTPUT QUERY="FContact">
	<OPTION VALUE="#FContact#">#FContact#
</CFOUTPUT>
</SELECT><br><br>

Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="" onchange="return ValidateSDate()"><br><br>
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="" onchange="return ValidateEDate()"><br><br>

Scope/Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Scope" Value=""></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->