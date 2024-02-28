<CFQUERY Name="CF" Datasource="Corporate">
SELECT * From CorporateFunctions
Order BY Function
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle#">
<cfinclude template="SOP.cfm">

<!--- / --->

<br><b>Corporate Functions</b>
<br><br>
<CFOUTPUT query="CF">
- #Function#<br>
</CFOUTPUT>
<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="AddCF_update.cfm">

Add Corporate Function:<br>
<input name="CF" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->