<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='Aprofiles.cfm?View=All'>Auditor Profiles</a> - #AuditorType# - Technical Audits Database - Auditor List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif URL.Type eq "TechnicalAudit">
	<cfset colspan = 4>
<cfelse>
	<cfset colspan = 3>
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM Auditors
WHERE Status IS NULL
AND Type = '#URL.Type#'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<cfif url.Type eq "TechnicalAudit">
    <CFQUERY BLOCKFACTOR="100" NAME="Requested" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT *
    FROM Auditors
    WHERE Status = 'Requested'
    AND Type = '#URL.Type#'
    ORDER BY Auditor
    </cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="AuditorRemoved" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM Auditors
WHERE Status = 'Removed'
AND Type = '#URL.Type#'
AND ID <> 0
ORDER BY Auditor
</cfquery>

<cfif isDefined("url.id")>
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

<cfoutput>
<a href="Auditors2.cfm?Type=#URL.Type#">Add an Auditor</a><br><br>
</cfoutput>

<table border="1" cellpadding="1">
<tr>
<td class="sched-title" width="250">Auditor Name</td>
<td class="sched-title" width="100">Location</td>
<Cfif URL.Type eq "TechnicalAudit">
<td class="sched-title" width="100">Department</td>
</Cfif>
<td class="sched-title" width="75" align="center">View</td>
</tr>
<tr>
<!--- ACTIVE --->
<cfoutput>
<td class="blog-title" colspan="#colspan#">Status - Active</td>
</cfoutput>
</tr>
<cfif Auditor.RecordCount eq 0>
<tr>
<cfoutput>
<td class="blog-content" colspan="#colspan#">There are no Auditors with Status - Active</td>
</cfoutput>
</tr>
</cfif>
<cfoutput query="Auditor">
<tr>
<td class="blog-content">#Auditor#</td>
<td class="blog-content">#Location#</td>
<Cfif URL.Type eq "TechnicalAudit">
<td class="blog-content">#Dept#</td>
</Cfif>
<td class="blog-content" align="center"><a href="Auditors_Details.cfm?ID=#ID#&Type=#URL.Type#">View</a></td>
</tr>
</cfoutput>
<!---///--->
<cfif url.Type eq "TechnicalAudit">
	<!--- Requested --->
    <cfoutput>
    <td class="blog-title" colspan="#colspan#">Status - Requested</td>
    </cfoutput>
    </tr>
    <cfif Requested.RecordCount eq 0>
    <tr>
    <cfoutput>
    <td class="blog-content" colspan="#colspan#">There are no Auditors with Status - Requested</td>
    </cfoutput>
    </tr>
    </cfif>
    <cfoutput query="Requested">
    <tr>
    <td class="blog-content">#Auditor#</td>
    <td class="blog-content">#Location#</td>
    <Cfif URL.Type eq "TechnicalAudit">
    <td class="blog-content">#Dept#</td>
    </Cfif>
    <td class="blog-content" align="center"><a href="Auditors_Details.cfm?ID=#ID#&Type=#URL.Type#">View</a></td>
    </tr>
    </cfoutput>
    <!---///--->
</cfif>
<!--- Removed/Inactive --->
<tr>
<cfoutput>
<td class="sched-title" colspan="#colspan#">Status - Removed</td>
</cfoutput>
</tr>
<cfif AuditorRemoved.RecordCount eq 0>
<tr>
<cfoutput>
<td class="blog-content" colspan="#colspan#">There are no Auditors with Status - Removed</td>
</cfoutput>
</tr>
</cfif>
<cfoutput query="AuditorRemoved">
<tr>
<td class="blog-content">#Auditor#</td>
<td class="blog-content">#Location#</td>
<Cfif URL.Type eq "TechnicalAudit">
<td class="blog-content">#Dept#</td>
</Cfif>
<td class="blog-content" align="center"><a href="Auditors_Details.cfm?ID=#ID#&Type=#URL.Type#">View</a></td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->