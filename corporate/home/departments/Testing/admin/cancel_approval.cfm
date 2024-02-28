<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Cancel Audit Request - Approval">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>	

<CFQUERY BLOCKFACTOR="100" NAME="AuditSched" Datasource="Corporate">
	SELECT AuditSchedule.*, AuditSchedule.Year_ as Year 
    FROM AuditSchedule
	WHERE ID = #URL.ID#
	and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput query="AuditSched">
<b>Please provide notes for the Cancellation Approval:</b><Br><br>

<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">View #url.year#-#url.id# Audit Details</a><Br /><Br />

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="cancel_approval_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#"  onSubmit="return validateForm();">

Cancellation Approval Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="e_Notes" displayname="Cancellation Approval Notes" Value=""></textarea><br><br>

<b>Note</b> - After approving the cancellation of the audit, you must upload email correspondence regarding this audit (as a PDF file), which will be viewable on the Audit Details page.<br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->