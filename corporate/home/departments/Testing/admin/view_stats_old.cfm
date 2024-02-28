<CFQUERY BLOCKFACTOR="100" name="Log" DataSource="Corporate">
SELECT * FROM PathCount
WHERE Path IS NOT NULL
ORDER BY CountOfID DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log2" DataSource="Corporate">
SELECT * FROM PathCount2
WHERE Path IS NOT NULL
ORDER BY CountOfID DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log3" DataSource="Corporate">
SELECT * FROM PathCount3
WHERE Path IS NOT NULL
ORDER BY CountOfID DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log4" DataSource="Corporate">
SELECT * FROM PathCount4
WHERE Path IS NOT NULL
ORDER BY CountOfID DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Log5" DataSource="Corporate">
SELECT * FROM PathCount5
WHERE Path IS NOT NULL
ORDER BY CountOfID DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="IP" DataSource="Corporate">
SELECT * FROM IP
WHERE IP IS NOT NULL
ORDER BY CountofIP DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="IP2" DataSource="Corporate">
SELECT * FROM IP2
WHERE IP IS NOT NULL
ORDER BY CountofIP DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="IP3" DataSource="Corporate">
SELECT * FROM IP3
WHERE IP IS NOT NULL
ORDER BY CountofIP DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="IP4" DataSource="Corporate">
SELECT * FROM IP4
WHERE IP <strong></strong>
ORDER BY CountofIP DESC
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="IP5" DataSource="Corporate">
SELECT * FROM IP5
WHERE IP <strong></strong>
ORDER BY CountofIP DESC
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Page Views">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Page Views by IP</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>IP</b></td>
<td align="center" class="blog-stats"><b>Page Views</b></td>
</tr>
<cfoutput query="IP">
<tr>
<td class="blog-stats" width="250">
#IP#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfIP#
</td>
</tr>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Public Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log">
<cfset admin = #Left(Path, 31)#>
<cfif admin is NOT "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Admin Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log">
<cfset admin = #Left(Path, 31)#>
<cfif admin is "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Page Views by IP</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>IP</b></td>
<td align="center" class="blog-stats"><b>Page Views</b></td>
</tr>
<cfoutput query="IP2">
<tr>
<td class="blog-stats" width="250">
#IP#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfIP#
</td>
</tr>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Public Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log2">
<cfset admin = #Left(Path, 31)#>
<cfif admin is NOT "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Admin Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log2">
<cfset admin = #Left(Path, 31)#>
<cfif admin is "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Page Views by IP</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>IP</b></td>
<td align="center" class="blog-stats"><b>Page Views</b></td>
</tr>
<cfoutput query="IP3">
<tr>
<td class="blog-stats" width="250">
#IP#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfIP#
</td>
</tr>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Public Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log3">
<cfset admin = #Left(Path, 31)#>
<cfif admin is NOT "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Admin Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log3">
<cfset admin = #Left(Path, 31)#>
<cfif admin is "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Page Views by IP</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>IP</b></td>
<td align="center" class="blog-stats"><b>Page Views</b></td>
</tr>
<cfoutput query="IP4">
<tr>
<td class="blog-stats" width="250">
#IP#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfIP#
</td>
</tr>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Public Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log4">
<cfset admin = #Left(Path, 31)#>
<cfif admin is NOT "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Admin Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log4">
<cfset admin = #Left(Path, 31)#>
<cfif admin is "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Page Views by IP</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>IP</b></td>
<td align="center" class="blog-stats"><b>Page Views</b></td>
</tr>
<cfoutput query="IP5">
<tr>
<td class="blog-stats" width="250">
#IP#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfIP#
</td>
</tr>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Public Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log5">
<cfset admin = #Left(Path, 31)#>
<cfif admin is NOT "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<br><br>

<table border="1">
<tr>
<td colspan="2" class="blog-stats"><b><u>Admin Files</u></b></td>
</tr>
<tr>
<td align="center" class="blog-stats"><b>Page</b></td>
<td align="center" class="blog-stats"><b>Views</b></td>
</tr>
<cfoutput query="Log5">
<cfset admin = #Left(Path, 31)#>
<cfif admin is "/departments/snk5212/IQA/admin/">
<tr>
<td class="blog-stats" width="250">
<cfset Dump = #replace(path, "/departments/snk5212/IQA/", "", "All")#>
#dump#
</td>
<td class="blog-stats" width="50" align="center">
#CountOfID#
</td>
</tr>
</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->