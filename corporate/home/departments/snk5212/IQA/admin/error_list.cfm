<CFQUERY BLOCKFACTOR="100" NAME="output" DataSource="Corporate">
SELECT ID, Logged, Name, Email, Response FROM ERROR_IQA
WHERE ID <> 1 and ID <> 2
ORDER BY ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Error List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<table width="650" border="1">
<tr class="blog-title">
<td>ID</td>
<td>Date</td>
<td>From</td>
<td>Status</td>
</tr>
<CFOUTPUT query="output">
<tr class="blog-content">
<td><a href="error_view.cfm?id=#id#">#ID#</a></td>
<td>#Logged#&nbsp;</td>
<td>#Name# (#Email#)&nbsp;
<!---<cflock scope="session" timeout="5">
	<cfif SESSION.Auth.Username eq "Chris">
		<a href="error_list_delete.cfm?id=#id#">delete</a>
	</cfif>
</cflock>--->
</td>
<td><cfif Response eq "Sent">Completed<cfelseif Response eq "Entered">Entered<cfelse>Open</cfif></td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->