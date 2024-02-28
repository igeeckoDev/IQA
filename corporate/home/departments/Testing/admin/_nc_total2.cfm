<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "IQA Audit Findings by Key Process">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery Datasource="Corporate" name="Q"> 
SELECT * FROM IQAFindingsSTATIC
ORDER BY ID
</cfquery>

<br /><br />
<table border="1">
	<tr>
		<th class="blog-title" width="300">Key Processes</th>
		<th class="blog-title">2006</th>
		<th class="blog-title">2007</th>
		<th class="blog-title">2008</th>
	</tr>
<cfoutput query="Q">
	<tr>
		<td class="blog-content">#KP#</td>
		<td class="blog-content">#A#</td>
		<td class="blog-content">#B#</td>
		<td class="blog-content">#C#</td>
	</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->