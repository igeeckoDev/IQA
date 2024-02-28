<CFQUERY BLOCKFACTOR="100" name="Rev" Datasource="Corporate">
SELECT * FROM IQAFiles_Rev
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "IQA (Root Directory) Files Revision History">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<table border="1" width="700">
<tr>
<td class="blog-title" align="center">File Name</td>
<td class="blog-title" align="center">Rev Number</td>
<td class="blog-title" align="center">Rev Date</td>
<td class="blog-title" align="center">Description</td>
</tr>
<cfoutput query="Rev">
<tr>
<td class="blog-content">#FileName#</td>
<td class="blog-content" align="center">#RevNumber#</td>
<td class="blog-content">#DateFormat(RevDate, 'mm/dd/yyyy')#</td>
<td class="blog-content" width="325">#Description#</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->