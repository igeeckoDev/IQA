<CFQUERY Name="GF" Datasource="Corporate">
SELECT * From GlobalFunctions
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Global Functions / Processes - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="GF">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="GF_edit_update.cfm?ID=#URL.ID#">

Global Function/Process Name:<br>
<b>#Function#</b>
<input name="GF" type="Hidden" value="#Function#">
<br><br>

Owner Email: (external UL email address)<br>
<input name="Owner" type="Text" size="70" value="#Owner#">
<br><br>

:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br />
<cfif NOT len(status)>
	:: <a href="GF_delete.cfm?ID=#URL.ID#">Delete</a> #function#<br><br>
<cfelseif status eq "Removed">
	:: <a href="GF_Reinstate.cfm?ID=#URL.ID#">Reinstate</a> #function# (currently Removed)<br><br>
</cfif>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>
				  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->