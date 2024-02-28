<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Accreditor">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Accred" Datasource="Corporate">
SELECT * From Accreditors
WHERE Status IS NULL
Order BY Accreditor
</CFQUERY>

<cfparam name="query_string" type="string" default="">

<cfif len(query_string)>
    <CFQUERY Name="Dup" Datasource="Corporate">
    SELECT * From Accreditors
    WHERE ID = #URL.ID#
    </CFQUERY>

	<cfif url.msg is "duplicate">
		<cfoutput query="Dup">
        Attempted to add: <b>#Accreditor#</b><br>
        <font color="red"><b>#Accreditor#</b> is already listed below.</font><br>
        </cfoutput>
	<cfelseif url.msg is "remove">
		<cfoutput query="Dup">
        <font color="red">#Accreditor# had been removed.</font><br>
        </cfoutput>
	</cfif>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="Accred_update.cfm">

Add Accreditor:<br>
<input name="Accreditor" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<br><b>UL Accreditors</b><br><br>

<CFOUTPUT query="Accred">
- #Accreditor# <a href="accred_edit.cfm?ID=#ID#">(edit)</a><br>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->