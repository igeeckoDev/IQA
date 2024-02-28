<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="KP">
SELECT * FROM KP
ORDER BY KP
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Add a Key Process">
<cfinclude template="SOP.cfm">

<!--- / --->

<br><b>Key Processes</b>
<br><br>
<CFOUTPUT query="KP">
- #KP# <a href="kp_edit.cfm?ID=#ID#">(edit)</a><br>
</CFOUTPUT>
<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="AddKP_update.cfm">

Add Key Process:<br>
<input name="KP" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->