<cfparam name="URL.Year" Default="#Curyear#" type="numeric">

<cfif URL.Year lt 2007 OR URL.Year gt #curyear#>
	<cfset url.year eq #curyear#>
</cfif>

<cfset TableName = "#URL.Year#PageViews">

<CFQUERY BLOCKFACTOR="100" name="PageViews" DataSource="Corporate">
SELECT Path, Count FROM #TableName#
ORDER BY Count DESC
</cfquery>

<cfoutput>
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Page Views - #URL.Year#">
<cfinclude template="SOP.cfm">

<br>
Select Year:
<cfloop index="i" from="2007" to="#curyear#">
	<cfoutput>
		<a href="View_Stats.cfm?Year=#i#">#i#</a> <cfif i neq curyear>::</cfif>
	</cfoutput>
</cfloop><br><br>

<cfif url.year eq 2007>
	Note: Stats begin on April 5, 2007<br><br>
<cfelseif url.year eq 2009>
	Note: Stats through April 7, 2009<br><br>
</cfif>

<!--- / --->
<!-- Public Files --->
<table border="1">
<tr>
<td colspan="2" align="center" class="blog-stats"><b><u>Public Files</u></b></td>
</tr>
<tr>
<td class="blog-stats" align="center" width="400"><b>File Name</b></td>
<td class="blog-stats" align="center" width="75"><b>Count</b></td>
</tr>
<cfoutput query="PageViews">
	<cfset admin = #Left(Path, 31)#>
	<cfif admin is NOT "/departments/snk5212/IQA/admin/">
	<tr>
	<td class="blog-stats" align="left">
		<cfset Dump = #replaceNoCase(Path, "/departments/snk5212/IQA/", "", "All")#>
		#dump#
	</td>
	<td class="blog-stats" align="center">
		#Count#
	</td>
	</tr>
	</cfif>
</cfoutput>
</table><br><br>

<!--- Admin Files --->
<table border="1">
<tr>
<td colspan="2" align="center" class="blog-stats"><b><u>Admin Files</u></b></td>
</tr>
<tr>
<td class="blog-stats" align="center" width="400"><b>File Name</b></td>
<td class="blog-stats" align="center" width="75"><b>Count</b></td>
</tr>
<cfoutput query="PageViews">
	<cfset admin = #Left(Path, 31)#>
	<cfif admin is "/departments/snk5212/IQA/admin/">
	<tr>
	<td class="blog-stats" align="left">
		<cfset Dump = #replaceNoCase(Path, "/departments/snk5212/IQA/admin/", "", "All")#>
		#dump#
	</td>
	<td class="blog-stats" align="center">
		#Count#
	</td>
	</tr>
	</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->