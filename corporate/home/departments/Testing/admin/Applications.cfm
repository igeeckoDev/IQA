<!--- Start of Page File --->
<cfset subTitle = "Application Index">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationNames.aID, ApplicationNames.AppName, ApplicationNames.Notes
FROM ApplicationNames
ORDER BY AppName
</CFQUERY>

<cfif isDefined("URL.msg")>
	<cfoutput>
		<span class="warning"><b>Application Added:</b></span><br />
        #url.msg#<br /><br />
	</cfoutput>
</cfif>

<a href="Application_Add.cfm">Add Application</a><br><br>

<a href="Approvals_ViewAll.cfm">View All Approvals</a><br /><br />

<table border="1">
<tr>
    <th align="center">Application Name</th>
	<th align="center">Application Notes</th>
    <th align="center">View Details</th>
    <th align="center">Edit</th>
</tr>
<cfoutput query="ViewModules">
<tr>
	<td align="left" valign="top">#AppName#</td>
	<td align="left" valign="top">
		<cfset Dump = #replace(Notes, "<p>", "", "All")#>
        <cfset Dump1 = #replace(Dump, "</p>", "<br /><br />", "All")#>
		#Dump1#
    </td>
    <td align="center">
    	<a href="modulesView.cfm?aID=#aID#"><img src="#SiteDir#SiteImages/table_row.png" border="0" align="absmiddle" /></a>
    </td>
    <td align="center">
    	<a href="Application_Edit.cfm?aID=#aID#"><img src="#SiteDir#SiteImages/bullet_edit.png" border="0" align="absmiddle" /></a>
    </td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->