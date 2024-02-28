<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Schedule - Confirm Cancel Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

Audit Cancel Help - <A HREF="javascript:popUp('../webhelp/webhelp_cancel.cfm')">[?]</A><br><br />

<cfoutput>					  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="cancel_submit.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">

Do you wish to cancel Audit #url.year#-#url.id#-#url.auditedby#?<br><br>

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