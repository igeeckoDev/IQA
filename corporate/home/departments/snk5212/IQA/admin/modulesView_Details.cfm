<!--- Start of Page File --->
<cfset subTitle = "Application Modules - View Module Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM ApplicationModules, ApplicationNames
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationModules.mID = #URL.mID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModulePages" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT pID, FileName
FROM
ApplicationPages
WHERE mID = #URL.mID#
ORDER BY UPPER(FileName)
</CFQUERY>

<cfoutput query="ViewModules">
<b>Application Name</b>: <a href="modulesView.cfm?aID=#aID#">#AppName#</a><br />
<b>Module Name</b>: #ModuleName# [<a href="modulesView_Edit.cfm?mID=#URL.mID#">Edit</a>]<br />
<b>Schema Used</b>: #SchemaName#<br />
<b>Database Table(s) Used</b>: #TableName#<br /><br />

<cfif isDefined("URL.msg") AND isDefined("URL.Type")>
	<cfif URL.Type eq "File">
		<cfoutput>
            <span class="warning"><b>File Added to Module:</b></span><br />
            #url.msg#<br /><br />
        </cfoutput>
	<cfelseif URL.Type eq "Edit">
    	<Cfoutput>
        	<span class="warning"><b>Module Edit:</b></span><br />
            #url.msg#<br /><br />
        </Cfoutput>
    </cfif>
</cfif>

<b>Associated Files</b> [<a href="modulesView_AddFiles.cfm?mID=#URL.mID#">Add Files</a>]<Br>
<cfif viewModulePages.recordcount gt 0>
    <cfloop query="ViewModulePages">
    #FileName# - <a href="modulesView_FileView.cfm?pID=#pID#&mID=#URL.mID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0" align="absmiddle" alt="View File Details" /></a><br />
    </cfloop>
<cfelse>
	No Files<br />
</cfif><br />

<b>Description</b><br>
<cfif len(Notes)>#Notes#<cfelse>None Listed</cfif><br /><br />

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApprovals" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT COUNT(*) as Count 
FROM ApplicationApprovals
WHERE mID = #mID#
</CFQUERY>

<b>Approvals</b> [<a href="moduleApproval_upload.cfm?mID=#URL.mID#">Add</a>]<br />
<cfif ViewApprovals.Count GT 0>
    
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApprovals" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * 
    FROM ApplicationApprovals
    WHERE mID = #url.mID#
    ORDER BY ApprovalNumber
    </CFQUERY>
    
    <cfloop query="ViewApprovals">
    #ApprovalNumber#: #ApprovalName# (#dateformat(ApprovalDate, "mm/dd/yyyy")#) #ApprovalPerson# [<a href="#SiteDir#SiteShared/ApprovalFiles/#ApprovalFile#">View</a>]<br />
    </cfloop>
<cfelse>
None Listed<br />
</cfif><br>

<b>Current Revision Information</b><br />
<u>Revision Number</u>: #RevNo#<br />
<u>Revision Date</u>: <cfif len(RevDate)>#dateformat(RevDate, "mm/dd/yyyy")#<cfelse>None Listed</cfif><br />
<u>Revision History</u><br>
<cfif len(RevHistory)>#RevHistory#<cfelse>None Listed</cfif>
<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->