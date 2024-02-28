<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Add Primary Contact - Audit #URL.Year#-#URL.ID#">
<cfinclude template="SOP.cfm">

<!--- / --->

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddContacts" action="Audit_Contacts_Update.cfm">
Primary Contact ('To' field of Scope Letter: external email address - ONE person)<br>
- Audit notification and Scope Letter will be sent to this person<br>
<INPUT TYPE="Text" NAME="Email" size="125" VALUE="" displayname="Primary Contact"><br>
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>

Other Contacts ('CC' field of Scope Letter: external email addresses)<br>
- Audit notification and Scope Letter will be sent to this person or persons (commas between the addresses)<br>
<INPUT TYPE="Text" NAME="Email2" size="125" VALUE="" displayname="Other Contacts"><br>
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>

<input name="submit" type="submit" value="Submit"> 
</form>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->
