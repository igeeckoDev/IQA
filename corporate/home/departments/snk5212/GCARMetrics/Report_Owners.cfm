<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Functional Group Owners">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="Owners" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField, SortField, Owner, CC, ID
FROM GCAR_METRICS_QREPORTS
WHERE ReportType = 'QE'
ORDER BY Function
</cfquery>

<table border="1">
<tr align="center">
    <th>Function</th>
    <th>Function Owner</th>
    <th>Edit<br />Owner</th>
    <th>FYI (cc)</th>
    <th>Edit<br />FYI (cc)</th>
    <th>Email Owner/<br />FYI Contacts</th>
</tr>
<cfoutput query="Owners">
<tr>
    <cfinclude template="shared/incVariables_Report.cfm">
	<td valign="top">#Function#</td>
    <td valign="top"><cfif len(Owner)>#replace(Owner, ",", "<br />", "All")#<cfelse>--</cfif></td>
    <td align="center">
    	<a href="Report_ChangeOwner.cfm?ID=#ID#">
        	<img align="absmiddle" src="#SiteDir#SiteImages/bullet_edit.png" border="0" alt="Edit Owner" />
        </a>
    </td>
    <td valign="top"><cfif len(CC)>#replace(CC, ",", "<br />", "All")#<cfelse>--</cfif></td>
    <td align="center">
    	<a href="Report_ChangeFYI.cfm?ID=#ID#">
        	<img align="absmiddle" src="#SiteDir#SiteImages/bullet_edit.png" border="0" alt="Edit FYI" />
        </a>
    </td>
    <td align="center"><a href="Report_EmailOwner.cfm?ID=#ID#"><img align="absmiddle" src="#SiteDir#SiteImages/email_magnify.png" border="0" alt="Email Owner(s)" /></a></td>
</tr>
</cfoutput>
</table>
<br /><br />

<cfoutput>
	<u>Options</u><br />
    <!--- Email All --->
	<img align="absmiddle" src="#SiteDir#SiteImages/email_magnify.png" border="0" alt="Email Owner(s)" /> <a href="Report_EmailOwner.cfm?ID=All">Send</a> Email to <b>All</b> Functions<br />
    <!--- Email Some --->
    <img align="absmiddle" src="#SiteDir#SiteImages/email_magnify.png" border="0" alt="Email Owner(s)" /> <a href="Report_EmailOwner_Select.cfm">Send</a> Email to <b>Some</b> Functions<br />
    <!--- Email History --->
    <img align="absmiddle" src="#SiteDir#SiteImages/email_magnify.png" border="0" alt="Email Owner(s)" /> <a href="Report_EmailOwner_History.cfm">View</a> Email History<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->