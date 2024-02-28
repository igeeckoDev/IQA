<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Accreditor Audit - #URL.AuditedBy#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
<cfif URL.AuditedBy EQ "VS">
AND VS = 'Yes'
<cfelseif URL.AuditedBy eq "WiSE">
AND WiSE = 'Yes'
<cfelse>
	<cfif URL.AuditedBy neq "IQA" AND URL.AuditedBy neq "WiSE" AND URL.AuditedBy neq "Medical">
    AND (SubRegion = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar"> 
    OR Region = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">)
    </cfif>
</cfif>
ORDER BY OfficeName 
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Accred" Datasource="Corporate">
SELECT * From Accreditors
WHERE Status IS NULL
Order BY Accreditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>
                             
<cfoutput query="ScheduleEdit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Accred_Audit_Edit_Submit.cfm?id=#id#&year=#year#&auditedby=#auditedby#">

Audit Year: #Year#<br><br>
<INPUT TYPE="hidden" NAME="e_Year" VALUE="#Year#" displayname="Year">
<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="#auditedby#">

Month Scheduled: (#MonthAsString(Month)#)<br>
<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month
		<option value="">---
<cfloop index="i" to="12" from="1">
		<OPTION VALUE="#i#"<cfif Month is i>SELECTED</cfif>>#MonthAsString(i)#
</cfloop>
</SELECT>
<br><br>

Accreditor: (#AuditType#)<br>
<SELECT NAME="e_AuditType" displayname="Accreditor">
	<OPTION VALUE="NoChanges">#AuditType#
	<option value="">---
</cfoutput>
<cfoutput query="Accred">
	<OPTION VALUE="#Accreditor#">#Accreditor#
</cfoutput>
</SELECT>
<br><br>

<cfoutput query="ScheduleEdit">
Site being Audited: (#OfficeName#)<br>
<SELECT NAME="e_OfficeName" displayname="Site Audited">
	<OPTION VALUE="NoChanges">#OfficeName#
	<option value="">---
</cfoutput>	
<CFOUTPUT QUERY="OfficeName">
	<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="ScheduleEdit">
Site Contact(s): (#SiteContact#)<br>
<INPUT TYPE="TEXT" NAME="e_SiteContact" size="75" VALUE="#sitecontact#" displayname="Site Contact(s)"><br><br>

<script>
$(function() {
	$( "##StartDate" ).datepicker({
	changeMonth: true,
	changeYear: true
	});
});

$(function() {
	$( "##EndDate" ).datepicker({
	changeMonth: true,
	changeYear: true
	});
});
</script>

<div id="datepicker">
Start Date<br>
<INPUT ID="StartDate" TYPE="Text" NAME="StartDate" VALUE="#DateFormat(StartDate, 'mm/dd/yyyy')#"><br><br>

End Date<br>
<INPUT ID="EndDate" TYPE="Text" NAME="EndDate" VALUE="#DateFormat(EndDate, 'mm/dd/yyyy')#"><br><br>

Scope:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Scope" Value="">#Scope#</textarea><br><br>
</div>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->