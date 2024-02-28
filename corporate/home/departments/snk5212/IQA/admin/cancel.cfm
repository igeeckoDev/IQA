<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Cancel Audit">
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

Audit Cancel Help - <A HREF="javascript:popUp('../webhelp/webhelp_cancel.cfm')">[?]</A><br><br />

<cfoutput query="AuditSched">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="cancel_fileupload.cfm?ID=#URL.ID#&Year=#URL.Year#"  onSubmit="return validateForm();">

Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="e_Notes" displayname="Cancellation Notes" Value=""></textarea><br><br>

<b>Note</b> - After requesting to cancel the audit, please send correspondence with the auditees and stakeholers to support the audit cancellation to Kai Huang. Once Kai has approved the cancellation, the audit will be canceled in the system and notifications will be sent.<br><br>

<input type="hidden" name="Cancel" value="N/A" />

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->