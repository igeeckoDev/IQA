<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Corporate Finance / Internal Audit - Auditors">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="FContact" Datasource="Corporate">
SELECT * From FContact
WHERE Status IS NULL
Order BY FContact
</CFQUERY>

<CFQUERY Name="FContactRemoved" Datasource="Corporate">
SELECT * From FContact
WHERE Status = 'Removed'
Order BY FContact
</CFQUERY>

<cfparam name="query_string" type="string" default="">
<cfif len(query_string)>
    <CFQUERY Name="Dup" Datasource="Corporate">
    SELECT * From FContact
    WHERE ID = #URL.ID#
    </CFQUERY>
	<cfif url.msg is "duplicate">
		<cfoutput query="Dup">
        Attempted to add: <b>#FContact#</b><br>
        <font color="red"><b>#FContact#</b> is already listed below.</font><br>
        </cfoutput>
	<cfelseif url.msg is "remove">
		<cfoutput>
			<font color="red">
            #url.name# had been removed from the Auditor List.<br>
            </font>
		</cfoutput>
	</cfif>
</cfif>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Accred" action="FContacts_update.cfm">

Add Corporate Finance Auditor:<br>
<input name="FContact" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form><Br /><Br />

<u>Status: Active</u><br>
<CFOUTPUT query="FContact">
- #FContact# <a href="FContacts_edit.cfm?ID=#ID#">(edit)</a><br>
</CFOUTPUT><Br>

<u>Status: Removed</u><br>
<cfoutput query="FContactRemoved">
- #FContact# <a href="FContacts_edit.cfm?ID=#ID#">(edit)</a><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->