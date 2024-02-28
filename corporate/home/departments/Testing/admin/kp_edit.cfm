<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="KP">
SELECT * FROM KP
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit Key Process">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFOUTPUT query="KP">
<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="editKP_update.cfm?ID=#ID#">

Edit Key Process:<br>
<input name="KP" type="Text" size="70" value="#KP#">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</cfoutput>
						  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->