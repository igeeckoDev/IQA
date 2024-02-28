<CFQUERY BLOCKFACTOR="100" NAME="Standards" Datasource="Corporate">
SELECT * FROM Standards_LTA
WHERE Status IS NULL
ORDER BY DocName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="StandardsRemoved" Datasource="Corporate">
SELECT * FROM Standards_LTA
WHERE Status = 'Removed'
ORDER BY DocName
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Laboratory Technical Audit - Reference Documents/Standards List">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<cfparam name="query_string" type="string" default="">
<cfif len(query_string)>
<CFQUERY Name="Dup" Datasource="Corporate">
SELECT * From Standards_LTA
WHERE ID = #URL.ID#
</CFQUERY>
<cfif url.msg is "duplicate">
<cfoutput query="Dup">
Attempted to add: <b>#DocName#</b><br>
<font color="red"><b>#DocName#</b> is already listed below.</font><br>
</cfoutput>
<cfelseif url.msg is "remove">
<cfoutput>
<font color="red"><u>#url.DocName# (#url.DocNumber#)</u> had been removed from the Standards/Document List.</font><br>
</cfoutput>
<cfelseif url.msg is "added">
<cfoutput>
<font color="red"><u>#url.DocName# (#url.DocNumber#)</u> has been added to the Reference Document/Standard List.</font>
</cfoutput>
</cfif>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="LTA_Standards_update.cfm">

Name of Reference Document/Standard:<br>
<input name="DocName" type="Text" size="75" value="">
<br><br>

Document Number (if applicable):<Br>
<input name="DocNumber" type="Text" size="75" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<u>Status: Active</u><br>
<CFOUTPUT query="Standards">
- #DocName# (#DocNumber#) <a href="">edit</a> (under construction)<br>
</CFOUTPUT><Br>

<u>Status: Removed</u><br>
<cfif StandardsRemoved.RecordCount eq 0>
None Listed
</cfif>
<cfoutput query="StandardsRemoved">
- #DocName# (#DocNumber#) </a> <a href="">edit</a> (under construction)<br>
</cfoutput>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->