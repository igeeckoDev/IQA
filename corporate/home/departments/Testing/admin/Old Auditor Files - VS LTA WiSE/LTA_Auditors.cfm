<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Auditor List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="LabAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status IS NULL
AND Type = 'LTA'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="LabAuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM Auditors
WHERE Status = 'Removed'
AND Type = 'LTA'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<cfparam name="query_string" type="string" default="">
<cfif len(query_string)>
	<CFQUERY Name="Dup" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * From Auditors
	WHERE ID = #URL.ID#
	</CFQUERY>
<cfif isDefined("url.msg")>
	<cfif url.msg is "duplicate">
		<cfoutput query="Dup">
		Attempted to add: <b>#Auditor#</b><br>
		<font color="red"><b>#Auditor#</b> is already listed.</font><br>
		</cfoutput>
	<cfelseif url.msg is "remove">
		<cfoutput>
		<font color="red">#url.name# had been removed from the Auditor List.</font><br>
		</cfoutput>
	<cfelseif url.msg is "added">
		<cfoutput>
		<font color="red">#url.Auditor# has been added to the Auditor List.</font><br>
		</cfoutput>
	</cfif>
	<br>
</cfif>
</cfif>

<a href="LTA_Auditors2.cfm">Add an Auditor</a><br><br>

<table border="1" cellpadding="1">
<tr>
<td class="sched-title" width="250">Auditor Name</td>
<td class="sched-title" width="200">Location</td>
<td class="sched-title" width="75">Status</td>
</tr>
<tr>
<td class="blog-title" colspan="3">Status - Active</td>
</tr>
<cfif LabAuditor.RecordCount eq 0>
<tr>
<td class="blog-content" colspan="3">There are no Auditors with Status - Active</td>
</tr>
</cfif>
<cfoutput query="LabAuditor">
<tr>
<td class="blog-content">#Auditor#</td>
<td class="blog-content">#Location#</td>
<td class="blog-content"><a href="LTA_Auditors_edit.cfm?ID=#ID#">Edit Status</a></td>
</tr>
</cfoutput>
<tr>
<td class="sched-title" colspan="3">Status - Removed</td>
</tr>
<cfif LabAuditorRemoved.RecordCount eq 0>
<tr>
<td class="blog-content" colspan="3">There are no Auditors with Status - Removed</td>
</tr>
</cfif>
<cfoutput query="LabAuditorRemoved">
<tr>
<td class="blog-content">#Auditor#</td>
<td class="blog-content">#Location#</td>
<td class="blog-content"><a href="LTA_Auditors_edit.cfm?ID=#ID#">Edit Status</a></td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->