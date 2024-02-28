<CFQUERY BLOCKFACTOR="100" name="Rev" Datasource="Corporate">
SELECT * FROM WebHelp_Current
</cfquery>

<cfset var=ArrayNew(1)>
<cfset i = 1>
<cfoutput query="Rev">
<cfset var[i] = '#FileName#'>
<cfset i = i + 1>
</cfoutput>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Web Help Revision History">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<table border="1" width="700">
<tr>
<td class="blog-title" align="center">File Name</td>
<td class="blog-title" align="center">Current Rev Number</td>
<td class="blog-title" align="center">Current Rev Date</td>
</tr>
<cfloop index="i" from="1" to="#ArrayLen(var)#">
<CFQUERY BLOCKFACTOR="100" name="Dump" Datasource="Corporate">
SELECT Filename, RevNumber, RevDate, WebHelpID
FROM WebHelp_All
WHERE FileName = '#var[i]#'
AND RevNumber = (SELECT Max(RevNumber) FROM WebHelp_All WHERE FileName = '#var[i]#')
</cfquery>
<tr>
<cfoutput query="Dump">
<td class="blog-content">#FileName#</td>
<td class="blog-content" align="center">#RevNumber# <a href="wh_rev_hist.cfm?id=#WebHelpID#"><img src="../images/ico_article.gif" border="0" title="Click to see Revision History of this file"></a></td>
<td class="blog-content" align="center">#dateformat(RevDate, 'mm/dd/yyyy')#</td>
</cfoutput>
</tr>
</cfloop>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->