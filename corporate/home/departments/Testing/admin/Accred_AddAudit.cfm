<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Accreditor Audit - #URL.AuditedBy#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE
SuperLocation = 'No'
AND
<cfif URL.AuditedBy EQ "VS">
	(Exist = 'Yes'
	AND Finance = 'Yes'
	AND Physical = 'Yes')
	AND VS = 'Yes'
<cfelseif URL.AuditedBy EQ "ULE">
	(Exist = 'Yes'
	AND Finance = 'Yes'
	AND Physical = 'Yes')
	AND ULE = 'Yes'
<cfelseif URL.AuditedBy EQ "WiSE">
	(Exist = 'Yes'
	AND Finance = 'Yes'
	AND Physical = 'Yes')
OR WiSE = 'Yes'
<cfelse>
	Exist <> 'No' 
	<cfif URL.AuditedBy neq "IQA" AND URL.AuditedBy neq "Medical" AND URL.AuditedBy neq "UL Environment">
		AND (SubRegion = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
		OR Region = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">)
    </cfif>
</cfif>
ORDER BY
<cfif URL.AuditedBy EQ "VS">
	VS, OfficeName
<cfelseif URL.AuditedBy EQ "ULE">
	ULE, OfficeName
<cfelseif URL.AuditedBy EQ "WiSE">
	WiSE DESC, OfficeName
<cfelse>
	OfficeName
</cfif>
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Accred" Datasource="Corporate">
SELECT * FROM Accreditors
WHERE Status IS NULL
ORDER BY Accreditor
</cfquery>

<cfset maxyear = curyear + 3>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Accred_AddAudit_Submit.cfm">

Audit Year: (required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#maxyear#" from="#lastyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<cfoutput>
<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="#url.auditedby#">
<INPUT TYPE="Hidden" NAME="AuditType2" VALUE="Accred">
</cfoutput>

Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month
		<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Accreditor: (required)<br>
<SELECT NAME="e_AuditType" displayname="Accreditor">
	<OPTION VALUE="">Select Accreditor
	<option value="">---
<cfoutput query="Accred">
	<OPTION VALUE="#Accreditor#">#Accreditor#
</cfoutput>
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

Site Contact(s): (required)<br>
<INPUT TYPE="TEXT" NAME="e_SiteContact" size="75" displayname="Site Contact(s)"><br><br>

<script>
$(function() {
	$( "#StartDate" ).datepicker({
	changeMonth: true,
	changeYear: true
	});
});

$(function() {
	$( "#EndDate" ).datepicker({
	changeMonth: true,
	changeYear: true
	});
});
</script>

<div id="datepicker">
Start Date<br>
<INPUT ID="StartDate" TYPE="Text" NAME="StartDate"><br><br>

End Date<br>
<INPUT ID="EndDate" TYPE="Text" NAME="EndDate"><br><br>
</div>

Scope:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Scope" Value=""></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->