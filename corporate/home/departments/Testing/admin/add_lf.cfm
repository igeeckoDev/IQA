<CFQUERY Name="LF" Datasource="Corporate">
SELECT * From LocalFunctions
Order BY Function
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Local Functions">
<cfinclude template="SOP.cfm">

<!--- / --->

<br><b>Local Functions</b>
<br><br>
<CFOUTPUT query="LF">
- #Function#<br>
</CFOUTPUT>
<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="AddLF_update.cfm">

Add Corporate Function:<br>
<input name="LF" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->