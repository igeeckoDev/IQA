<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Completion Notes">
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

<table border="0" width="100%">
<tr>
	<Td class="blog-content">
		<cfoutput query="AuditSched">
			<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Form" ACTION="Status_CompletionNotes_Submit.cfm?year=#url.year#&id=#url.id#&page=status2">

			Audit Scope and Report Completion Notes for #year#-#id#:<br>
			<textarea WRAP="PHYSICAL" ROWS="16" COLS="50" NAME="e_Notes" displayname="Notes" Value="#CompletionNotes#">#CompletionNotes#</textarea><br><br>

			<INPUT TYPE="Submit" value="Submit Notes">
			</FORM>
		</cfoutput>
	</TD>
</tr>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->