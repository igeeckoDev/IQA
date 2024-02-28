<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From Accreditors
WHERE Status IS NULL
AND Accreditor <> '_test'
Order BY Accreditor
</CFQUERY>

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

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="AddAccred_update.cfm">

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
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->