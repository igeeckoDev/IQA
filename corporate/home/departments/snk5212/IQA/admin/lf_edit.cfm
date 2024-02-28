<CFQUERY Name="LF" Datasource="Corporate">
SELECT * From LocalFunctions
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Local Functions - Edit">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<CFOUTPUT query="LF">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="lf_edit_update.cfm?ID=#URL.ID#">

Edit Local Function:<br>
<input name="LF" type="Text" size="70" value="#Function#">
<br><br>

<a href="lf_delete.cfm?ID=#URL.ID#">delete</a> #function#<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>					  
						  				  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->