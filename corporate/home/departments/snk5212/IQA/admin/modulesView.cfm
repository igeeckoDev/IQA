<cfif isDefined("url.aID")>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ModuleName" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ApplicationNames.AppName as AppName
    FROM ApplicationNames
    WHERE ApplicationNames.aID = #URL.aID#
    </CFQUERY>
<cfelse>
	<cfset ModuleName.AppName = "All">
</cfif>

<!--- Start of Page File --->
<cfset subTitle = "View Application Modules (#ModuleName.AppName#)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
Currently Viewing all Modules for: 
	<b><cfif ModuleName.AppName eq "All">All Applications<cfelse>#ModuleName.Appname# Application</cfif></b><br /><br />

 :: <a href="applications.cfm">View All Applications</a><br />
 :: <a href="modulesView_Add.cfm?aID=#URL.aID#">Add Module</a><br /><br />
</cfoutput>


<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	ApplicationModules.mID, ApplicationModules.ModuleName, ApplicationModules.RevNo, ApplicationModules.RevDate, ApplicationNames.aID, ApplicationNames.AppName
FROM
	ApplicationModules, ApplicationNames
WHERE 
	ApplicationModules.aID = ApplicationNames.aID
<cfif isDefined("url.aID")>
	AND ApplicationNames.aID = #url.aID#
</cfif>

ORDER BY
	ApplicationModules.ModuleName
</CFQUERY>

<cfif ViewModules.recordCount gt 0>

    <table border="1">
    <tr>
    	<cfif ModuleName.AppName eq "All">
        	<th align="center">Application Name</th>
        </cfif>
        <th align="center">Module Name</th>
        <th align="center">Revision<br />Number</th>
        <th align="center">Revision<br />Date</th>
        <th align="center">View<br />Module</th>
        <!---<th align="center">Approvals</th>--->
    </tr>
    <cfoutput query="ViewModules">
    <tr>
        <cfif ModuleName.AppName eq "All">
	        <td>#AppName#</td>
        </cfif>
        <td>#ModuleName#</td>
        <td align="center">#RevNo#</td>
        <td align="center"><cfif len(RevDate)>#dateformat(RevDate, "mm/dd/yyyy")#<cfelse>None Listed</cfif></td>
        <td align="center"><a href="modulesView_Details.cfm?mID=#mID#"><img src="#SiteDir#SiteImages/table_row.png" border="0" align="absmiddle" /></a></td>
        
<!---
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApprovals" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT COUNT(*) as Count 
        FROM ApplicationApprovals
        WHERE mID = #mID#
        </CFQUERY>
        
        <td align="center"><cfif ViewApprovals.Count GT 0><a href="approvalView.cfm?mID=#mID#">View</a><cfelse>NA</cfif></td>
--->
    </tr>
    </cfoutput>
    </table>
<cfelse>
	<cfoutput>
	No modules found for <b>#ModuleName.Appname# Application</b>.<br /><br />
    
    <a href="modulesView_Add.cfm?aID=#URL.aID#">Add Module</a>
    </cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->