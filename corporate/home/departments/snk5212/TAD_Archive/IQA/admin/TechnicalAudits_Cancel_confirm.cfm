<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Cancel Audit - Confirm">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<cfoutput>					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TechnicalAudits_cancel_submit.cfm?ID=#URL.ID#&Year=#URL.Year#">

Do you wish to cancel Audit #url.year#-#url.id# / #varAuditIdentifier#?<br><br>

<u>Cancellation Notes</u>:<br>
#form.e_Notes#<br><br>
<input type="hidden" value="#form.e_notes#" name="notes">

<INPUT TYPE="Submit" name="Resched" Value="Confirm Request">
<INPUT TYPE="Submit" name="Resched" Value="Cancel Request">

</FORM>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->