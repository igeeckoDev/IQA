<!--- Start of Page File --->
<cfset subTitle = "Application Modules - View File Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationModules.ModuleName, ApplicationModules.RevNo, ApplicationModules.RevDate, ApplicationModules.RevHistory, ApplicationModules.Notes, ApplicationNames.aID, ApplicationNames.AppName
FROM
ApplicationModules, ApplicationNames
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationModules.mID = #URL.mID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewFileDetail" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM ApplicationPages
WHERE pID = #URL.pID#
</CFQUERY>

<cfoutput query="ViewModules">
<b>Application Name</b>: <a href="modulesView.cfm?aID=#aID#">#AppName#</a><br />
<b>Module Name</b>: <a href="modulesView_Details.cfm?mID=#URL.mID#">#ModuleName#</a><br />
</cfoutput>

<cfoutput query="ViewFileDetail">
<b>File Location / Name</b> #FileName#<br /><br />

<b>Description</b> [<a href="modulesView_FileView_AddNotes.cfm?pID=#pID#"><cfif len(Notes)>Edit<cfelse>Add</cfif></a>]<br>
<cfif len(Notes)>#Notes#<cfelse>None Listed</cfif><br /><br />

<b>Revision Information</b><br />
<u>Revision Number</u>: #RevNo#<br />
<u>Revision Date</u>: <cfif len(RevDate)>#dateformat(RevDate, "mm/dd/yyyy")#<cfelse>None Listed</cfif><br />
<u>Revision History</u><br>
<cfif len(RevHistory)>#RevHistory#<cfelse>None Listed</cfif>
<br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->