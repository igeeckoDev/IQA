<!--- Start of Page File --->
<cfset subTitle = "Application Modules - View All Module Approvals">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	ApplicationModules.mID, ApplicationModules.ModuleName, ApplicationModules.RevNo, ApplicationModules.RevDate, ApplicationNames.aID, ApplicationNames.AppName
FROM
	ApplicationModules, ApplicationNames
WHERE 
	ApplicationModules.aID = ApplicationNames.aID
ORDER BY
	ApplicationNames.AppName, ApplicationModules.ModuleName
</CFQUERY>

<a href="Applications.cfm">View All Applications</a>

<cfset AppNameHolder = "">
<table border="1">
<tr>
	<th>Application/Module Name</th>
    <th>Approval Details<br>and View Approvals</th>
    <th>View<br>App/Mod</th>
</tr>

<cfoutput query="ViewModules">
<cfif AppNameHolder IS NOT AppName> 
<cfIf AppNameHolder is NOT ""><br></cfif>
<tr>
<td colspan="2">
<b>#AppName#</b>
</td>
<td align="center">
<a href="modulesView.cfm?aID=#aID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0"></a>
</td>
</tr>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApprovals" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT COUNT(*) as Count 
FROM ApplicationApprovals
WHERE mID = #mID#
</CFQUERY>

<tr>
    <td>
        #ModuleName#
    </td>
<cfif ViewApprovals.Count GT 0>  
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApprovals" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    FROM ApplicationApprovals
    WHERE mID = #mID#
    ORDER BY ApprovalNumber
    </CFQUERY>
    
    <td>
        <cfloop query="ViewApprovals">
        #dateformat(ApprovalDate, "mm/dd/yyyy")# [<a href="#SiteDir#SiteShared/ApprovalFiles/#ApprovalFile#">View</a>]<br />
        </cfloop>
    </td>
<cfelse>
    <td align="center">
    --
    </td>
</cfif>
    <td align="center">
        <a href="modulesView_Details.cfm?mID=#mID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0"></a>
    </td>
</tr>
<cfset AppNameHolder = AppName>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->