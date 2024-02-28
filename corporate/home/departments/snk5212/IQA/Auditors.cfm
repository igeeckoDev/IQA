<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelseif url.Type eq "LTA">
	<cfset AuditorType = "Laboratory Technical Audit (OSHA SNAP)">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='Aprofiles.cfm?View=All'>Auditor Profiles</a> - #AuditorType# - Auditor List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND Type = '#URL.Type#'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status = 'Removed'
AND Type = '#URL.Type#'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<table border="1" cellpadding="1">
<tr>
    <td class="sched-title" width="250">Auditor Name</td>
    <td class="sched-title" width="200">Location</td>
</tr>
<tr>
    <td class="blog-title" colspan="3">Status - Active</td>
</tr>
<cfif Auditor.RecordCount eq 0>
<tr>
    <td class="blog-content" colspan="3">There are no Auditors with Status - Active</td>
</tr>
</cfif>
<cfoutput query="Auditor">
<tr>
    <td class="blog-content">#Auditor#</td>
    <td class="blog-content">#Location#</td>
</tr>
</cfoutput>
<tr>
    <td class="sched-title" colspan="3">Status - Removed</td>
</tr>
<cfif AuditorRemoved.RecordCount eq 0>
<tr>
    <td class="blog-content" colspan="3">There are no Auditors with Status - Removed</td>
</tr>
</cfif>
<cfoutput query="AuditorRemoved">
<tr>
    <td class="blog-content">#Auditor#</td>
    <td class="blog-content">#Location#</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->