<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Corporate Finance / Internal Audit - Edit Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Edit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND Finance = 'Yes'
ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="FContact" Datasource="Corporate">
SELECT * FROM FContact
ORDER BY FContact
</cfquery>
	
<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>
		
<cfoutput query="Edit">	
<b>#year#-#ID#-#AuditedBy#</b><br><br>
	  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="AS_edit_Submit.cfm?#CGI.QUERY_STRING#">

Audit Year:<br>
<INPUT TYPE="TEXT" NAME="e_Year" VALUE="#Year#" displayname="Year"><br><br>
<INPUT TYPE="Hidden" NAME="AuditedBy" VALUE="#AuditedBy#">

Month Scheduled: (#MonthAsString(Month)#)<br>
<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<OPTION VALUE="#i#" <cfif Month is i>SELECTED</cfif>>#MonthAsString(i)#
</cfloop>
</SELECT>
<br><br>

Site being Audited: (#OfficeName#)<br>
</cfoutput>
<SELECT NAME="e_OfficeName" displayname="Site Audited">		
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#"<cfif edit.officename is officename>SELECTED</cfif>>#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="Edit">
Corporate Finance Auditor: (#ASContact#)<br>
<SELECT NAME="e_ASContact" displayname="AS Contact">
</cfoutput>
<CFOUTPUT QUERY="FContact">
		<OPTION VALUE="#FContact#"<cfif edit.ASContact is FContact>SELECTED</cfif>>#FContact#
</CFOUTPUT>
</SELECT><br><br>

<cfoutput query="Edit">
Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="<cfset S = #StartDate#>#DateFormat(S, 'mm/dd/yyyy')#" onchange="return ValidateSDate()"><br><br>
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="<cfset E = #EndDate#>#DateFormat(E, 'mm/dd/yyyy')#" onchange="return ValidateEDate()"><br><br>

Scope:<br>
<cfset S1 = #ReplaceNoCase(Scope, "<br>", chr(13), "ALL")#>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Scope" Value="#Scope#">#S1#</textarea><br><br>
</cfoutput>

<INPUT TYPE="button" value="Save and Continue" onClick="javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->