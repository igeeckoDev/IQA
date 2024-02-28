<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From ASAccreditors
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Manage Accreditors - Accreditation Services (AS) - Edit #Accred.Accreditor#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>AS Accreditors</b>
<br><br>
<CFOUTPUT query="Accred">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="ASAccred_edit_update.cfm?ID=#URL.ID#">

Edit Accreditor:<br>
<input name="Accred" type="Text" size="70" value="#Accreditor#">
<br><br>

<a href="ASaccred_delete.cfm?ID=#URL.ID#">Remove</a> #accreditor#<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->