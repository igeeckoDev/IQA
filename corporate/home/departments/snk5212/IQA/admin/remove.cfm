<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Remove Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

Remove Audit Help - <A HREF="javascript:popUp('../webhelp/webhelp_remove.cfm')">[?]</A><br /><br />

<cfoutput query="AuditSched">					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="remove_confirm.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" onSubmit="return validateForm();">

Please add notes to explain the removal of this audit:<br><br>

Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="e_Notes" displayname="Removal Notes" Value=""></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->