<CFQUERY Name="CF" Datasource="Corporate">
SELECT * From CorporateFunctions
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Corporate Functions - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<CFOUTPUT query="CF">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="CF_edit_update.cfm?ID=#URL.ID#">

Edit Corporate Function:<br>
<input name="CF" type="Text" size="70" value="#Function#">
<br><br>

Owner Email: (external UL email address)<br>
<input name="Owner" type="Text" size="70" value="#Owner#">
<br><br>

:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br />
<cfif Status eq "Removed">
:: <a href="cf_delete.cfm?ID=#URL.ID#&Action=Reinstate">Reinstate</a> #Function#<br><br>
<cfelse>
:: <a href="cf_delete.cfm?ID=#URL.ID#&Action=Remove">Remove</a> #Function#<br><br>
</cfif>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>					  

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->