<!--- Start of Page File --->
<cfset subTitle = "Application Modules - Add Files to Module">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit") AND isDefined("Form.Filename")>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="CheckForExistingFile" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT pID, FileName
FROM
ApplicationPages
WHERE mID = #URL.mID#
AND FileName = '#FORM.FileDirectory##FORM.FileName#'
</CFQUERY>

<!--- File Not Found - Proceed with adding file to this module --->
<cfif CheckForExistingFile.RecordCount eq 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="getMaxID" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(pID)+1 as NewID
    FROM ApplicationPages
    </CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="addFile" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO	ApplicationPages(pID, mID, FileName)
    VALUES(#getMaxID.NewID#, #URL.mID#, '#FORM.FileDirectory##FORM.FileName#')
    </CFQUERY>
    
    <cflocation url="modulesView_Details.cfm?mID=#URL.mID#&msg=#FORM.FileDirectory##FORM.FileName#&type=File" addtoken="no">
<!--- File Found - alert user --->
<cfelse>
	<cfoutput>
	File (#FORM.FileDirectory##FORM.FileName#) has already been added to this Module.<br><br>
    
    <u>Options</u><br>
    :: <a href="modulesView_AddFiles.cfm?mID=#URL.mID#">Add File to Module</a><br>
    :: <a href="modulesView_Details.cfm?mID=#URL.mID#">View Module</a>
    </cfoutput>
</cfif>

<!--- If user form is not submitted, show the original output page and output form --->
<cfelse>

<!--- output page and output form --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationModules.ModuleName, ApplicationModules.RevNo, ApplicationModules.RevDate, ApplicationModules.RevHistory, ApplicationModules.Notes, ApplicationNames.aID, ApplicationNames.AppName
FROM
ApplicationModules, ApplicationNames
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
<b>Module Name</b>: <a href="modulesView_Details.cfm?mID=#URL.mID#">#ModuleName#</a><br /><br />

<b>Associated Files</b><Br>
<cfif viewModulePages.recordcount gt 0>
    <cfloop query="ViewModulePages">
    #FileName#<br />
    </cfloop>
<cfelse>
	No Files<br />
</cfif><br />
</cfoutput>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.Query_String#">
<b>Add File</b><Br>
<u>Base Directory</u><br>
<cfinput name="FileDirectory" type="hidden" value="/departments/snk5212/">
/departments/snk5212/<br><br>

<u>File Name and Location</u><br>
(example for this page: IQA/Admin/ModulesView_AddFiles.cfm)<br>
<cfinput name="FileName" type="text" size="80" required="yes" message="Enter the File Name and Location (example: IQA/Admin/ModulesView_AddFiles.cfm"><br><br>

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->