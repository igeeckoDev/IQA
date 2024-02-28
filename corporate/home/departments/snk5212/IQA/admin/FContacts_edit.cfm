<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Corporate Finance / Internal Audit - Edit Auditors">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="FContact" Datasource="Corporate">
SELECT * From FContact
WHERE ID = #URL.ID#
</CFQUERY>

<b>Corporate Finance Auditors</b>
<br><br>
<CFOUTPUT query="FContact">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="FContacts_edit_update.cfm?ID=#URL.ID#">

Edit Corporate Finance Auditor:<br>
<input name="FContact" type="Text" size="70" value="#FContact#">
<br><br>

<cfif status is "removed">
<a href="FContacts_status.cfm?ID=#URL.ID#&name=#FContact#&status=Active">Reinstate</a> #FContact# to Auditor List
<cfelse>
<a href="FContacts_status.cfm?ID=#URL.ID#&name=#FContact#&status=remove">Remove</a> #FContact# from Auditor List
</cfif><br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->