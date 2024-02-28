<CFQUERY BLOCKFACTOR="100" NAME="output" DataSource="Corporate">
SELECT * FROM CAR_ERROR
ORDER BY ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Error Reporting">
<cfinclude template="SOP.cfm">

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
	<cfif SESSION.Auth.AccessLevel eq "SU">
		<a href="error_list_delete.cfm?id=#id#">delete</a>
	</cfif>
</cflock>--->
</td>
<td><cfif Response eq "Sent">Completed<cfelseif Response eq "Entered">Entered<cfelse>Open</cfif></td>
</tr>
</cfoutput>
</table>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->