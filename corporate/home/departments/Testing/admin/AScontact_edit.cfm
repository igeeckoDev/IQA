<CFQUERY Name="ASContact" Datasource="Corporate">
SELECT * From ASContact
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "AS Contacts">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>AS Contacts</b>
<br><br>
<CFOUTPUT query="ASContact">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="ASContact_edit_update.cfm?ID=#URL.ID#">

Edit AS Contact:<br>
<input name="ASContact" type="Text" size="70" value="#ASContact#">
<br><br>

<cfif Status eq "Inactive">
	<a href="ASContact_Status.cfm?ID=#URL.ID#&status=Active">change status</a> to <b>Active</b> for #ASContact#
<cfelse>
	<a href="ASContact_Status.cfm?ID=#URL.ID#&status=Inactive">change status</a> to <b>Inactive</b> for #ASContact#
</cfif><br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->