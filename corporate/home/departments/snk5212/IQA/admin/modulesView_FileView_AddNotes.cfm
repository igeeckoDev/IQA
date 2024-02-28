<!--- Start of Page File --->
<cfset subTitle = "Application Modules - View File - Add Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationModules.ModuleName, ApplicationModules.RevNo, ApplicationModules.RevDate, ApplicationModules.RevHistory, ApplicationModules.Notes, ApplicationNames.aID, ApplicationNames.AppName, ApplicationPages.FileName, ApplicationModules.mID
FROM
ApplicationModules, ApplicationNames, ApplicationPages
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationModules.mID = ApplicationPages.mID
AND ApplicationPages.pID = #URL.pID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewFileDetail" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM ApplicationPages
WHERE pID = #URL.pID#
</CFQUERY>

<cfif isDefined("Form.Submit") AND isDefined("Form.Notes")>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="addFileNotes" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE ApplicationPages
SET
Notes = <CFQUERYPARAM VALUE="#Form.Notes#" CFSQLTYPE="CF_SQL_CLOB">
WHERE pID = #URL.pID#
</CFQUERY>

<cflocation url="modulesView_FileView.cfm?mID=#ViewModules.mID#&pID=#URL.pID#&msg=Notes Added" addtoken="no">

<cfelse>

<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<cfoutput query="ViewModules">
<b>Application Name</b>: <a href="modulesView.cfm?aID=#aID#">#AppName#</a><br />
<b>Module Name</b>: <a href="modulesView_Details.cfm?mID=#mID#">#ModuleName#</a><br />
<b>File Name / Location</b>: #FileName#<br /><br>
</cfoutput>

<cfoutput query="ViewFileDetail">
<b>Description</b><br>
<cfif len(Notes)>#Notes#<cfelse>None Listed</cfif><br /><br />

<b>Revision Information</b><br />
<u>Revision Number</u>: #RevNo#<br />
<u>Revision Date</u>: <cfif len(RevDate)>#dateformat(RevDate, "mm/dd/yyyy")#<cfelse>None Listed</cfif><br />
<u>Revision History</u><br>
<cfif len(RevHistory)>#RevHistory#<cfelse>None Listed</cfif>
<br /><br />
</cfoutput>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.Query_String#">
<b>Add Notes</b><Br>
<cftextarea name="Notes" value="#ViewFileDetail.Notes#" rows="12" cols="60" required="yes" message="Enter a short description of the file"></cftextarea><br><br>

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->