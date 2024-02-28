<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From Accreditors
Order BY Accreditor
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Add Accreditor">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<cfparam name="query_string" type="string" default="">
<cfif len(query_string)>
<CFQUERY Name="Dup" Datasource="Corporate">
SELECT * From Accreditors
WHERE ID = #URL.ID#
</CFQUERY>
<cfoutput query="Dup">
Attempted to add: <b>#Accreditor#</b><br>
</cfoutput>
<font color="red">This Accreditor is already listed below.</font><br>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="AddAccred.cfm">

Add Accreditor:<br>
<input name="Accreditor" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<br><b>UL Accreditors</b>
<br><br>
<CFOUTPUT query="Accred">
- #Accreditor#<br>
</CFOUTPUT>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->