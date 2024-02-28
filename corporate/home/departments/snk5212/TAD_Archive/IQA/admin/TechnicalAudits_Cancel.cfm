<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Cancel Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>	

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID# AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="Audit">				
Do you wish to cancel Audit #url.year#-#url.id# / #varAuditIdentifier#?<br><br>
	  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TechnicalAudits_cancel_confirm.cfm?ID=#URL.ID#&Year=#URL.Year#"  onSubmit="return validateForm();">

Cancel Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="e_Notes" displayname="Cancellation Notes" Value=""></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->