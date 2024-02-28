<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Accreditation Services Add Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="ASContact" Datasource="Corporate">
SELECT * FROM ASContact
ORDER BY ASContact
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="ASAccreditors" Datasource="Corporate">
SELECT * FROM ASAccreditors
ORDER BY Accreditor
</cfquery>
		
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
			  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="AS_AddAudit_Submit.cfm">

<cfoutput>
	<cfset maxyear = #curyear# + 3>
</cfoutput>

Audit Year: (required)<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#maxyear#" from="#lastyear#">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT>
<br><br>

<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="AS">
<INPUT TYPE="Hidden" NAME="AuditType2" VALUE="Accred">

Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
	<option value="">Select Month
	<option value="">---
<cfloop index="i" to="12" from="1">
		<cfoutput><OPTION VALUE="#i#">#MonthAsString(i)#</cfoutput>
</cfloop>
</SELECT>
<br><br>

Type of Audit: (required)<br>
<SELECT NAME="e_AuditType" displayname="Accreditor">
	<OPTION VALUE="">Select Accreditor
	<option value="">---	
<cfoutput query="ASAccreditors">	
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

AS Contact: (required)<br>
<SELECT NAME="e_ASContact" displayname="AS Contact">
	<OPTION VALUE="">Select AS Contact
	<option value="">---	
<CFOUTPUT QUERY="ASContact">
	<OPTION VALUE="#ASContact#">#ASContact#
</CFOUTPUT>
</SELECT><br><br>

Site Contact(s): (required)<br>
<INPUT TYPE="TEXT" NAME="e_SiteContact" width="75" VALUE="" displayname="Site Contact(s)"><br><br>

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