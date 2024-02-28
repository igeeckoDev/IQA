<CFQUERY Name="Accred1" Datasource="Corporate">
SELECT Accreditor 
From Accreditors
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit Accreditor - #Accred1.Accreditor#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Accred2" Datasource="Corporate">
SELECT * From Accreditors
WHERE ID = #URL.ID#
</CFQUERY>

<CFOUTPUT query="Accred2">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="Accred_edit_update.cfm?ID=#URL.ID#">

Edit Accreditor:<br>
<input name="Accred" type="Text" size="70" value="#Accreditor#">
<br><br>

<cflock scope="SESSION" timeout="60">
	<cfif SESSION.AUTH.AccessLevel is "admin" or SESSION.Auth.AccessLevel is "SU">
		<a href="accred_delete.cfm?ID=#URL.ID#">delete</a> #accreditor#<br><br>
	</cfif>
</cflock>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>					  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->