<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "AS Contacts">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="ASContact" Datasource="Corporate">
SELECT * From ASContact
Order BY ASContact
</CFQUERY>

<cfparam name="query_string" type="string" default="">
<cfif len(query_string)>
    <CFQUERY Name="Dup" Datasource="Corporate">
    SELECT * From ASContact
    WHERE ID = #URL.ID#
    </CFQUERY>

	<cfif url.msg is "duplicate">
		<cfoutput query="Dup">
        Attempted to add: <b>#ASContact#</b><br>
        <font color="red"><b>#ASContact#</b> is already listed below.</font><br>
        </cfoutput>
	<cfelseif url.msg is "Inactive" OR url.msg is "Active">
		<cfoutput>
        <font color="red">The status of <b>#Dup.ASContact#</b> has been changed to <b>#url.msg#</b>.</font><br><br />
        </cfoutput>
	</cfif>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="ASContact_update.cfm">

Add AS Contact:<br>
<input name="ASContact" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<br><b>AS Contacts</b>
<br><br>
<CFOUTPUT query="ASContact">
- #ASContact# <a href="ascontact_edit.cfm?ID=#ID#">(edit)</a> <cfif Status eq "Inactive"><b>Inactive</b></cfif><br>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->