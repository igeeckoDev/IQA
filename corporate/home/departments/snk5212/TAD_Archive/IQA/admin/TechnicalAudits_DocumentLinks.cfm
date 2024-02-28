<CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Links
Order By Label
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Audit Report - Document Names/Links">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>View/Edit Audit Report Document Names/Links</b><br><br>

<cfoutput>
<cfif isDefined("URL.var")>
	<font color="red"> 
	<cfif URL.var eq "Edit">
		<b>#URL.Value#</b><br /><br />has been changed from:<Br /><br /><b>#URL.origValue#</b>.
    <cfelseif URL.var eq "NoEditChange">
		<b>#URL.Value#</b><br /><br />No change was made. No fields were changed.
    <cfelseif URL.var eq "Blank">
    	The form was submitted without all required values. No action taken.
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<Table border="1">
<tr>
    <th width="50">Audit Type</th>
    <th width="200">Document Name and Document Number</th>
    <th width="200">Link</th>
    <th width="50">Edit</th>
</tr>
<CFOUTPUT query="Standard">
<tr>
    <td valign="top">#Label#</td>
    <td valign="top">#HTTPLinkName#</td>
    <td valign="top"><a href="#HTTPLink#">#HTTPLink#</a></td>
    <td valign="top" align="center"><a href="TechnicalAudits_DocumentLinks_Edit.cfm?Label=#Label#">Edit</a></td>
</tr>
</CFOUTPUT>
</TABLE>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->