<cfquery name="FAQ13" datasource="Corporate" blockfactor="100"> 
SELECT * FROM CAR_FAQ13
ORDER BY ID
</cfquery>

<table border="1" width="666">
<tr>
<td class="blog-title" align="center">CAR Category</td>
<td class="blog-title" align="center">Description</td>
</tr>
<tr>
<cfoutput query="FAQ13">
<tr>
<td class="Blog-content">#CARCategory#</td>
<td class="Blog-content">#Description#</td>
</tr>
</cfoutput>
</table>