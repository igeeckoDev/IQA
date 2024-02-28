<CFQUERY BLOCKFACTOR="100" name="Rev" Datasource="Corporate">
SELECT * FROM IQAFiles_Rev
ORDER BY FileName, RevNumber
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "IQA (Root Directory) Files Revision History">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<table border="1" width="700">
<tr>
<td class="blog-title" align="center">File Name</td>
<td class="blog-title" align="center">Current Rev Number</td>
<td class="blog-title" align="center">Current Rev Date</td>
<td class="blog-title" align="center">Description</td>
</tr>
<cfoutput query="Rev">
<tr>
<td class="blog-content">#FileName#</td>
<td class="blog-content" align="center">#RevNumber# <a href="IQAroot_rev_hist.cfm?id=#ID#"><img src="../images/ico_article.gif" border="0" title="Click to see Revision History of this file"></a></td>
<td class="blog-content">#DateFormat(RevDate, 'mm/dd/yyyy')#</td>
<td class="blog-content" width="325">#Description#&nbsp;</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->