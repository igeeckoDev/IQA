<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ModuleName" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationModules.ModuleName as ModuleName, aID
FROM ApplicationModules
WHERE ApplicationModules.mID = #URL.mID#
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Application Modules - Edit <b>#ModuleName.ModuleName#</b> Module">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit") AND isDefined("Form.Notes")>

<!--- if the module name is changed in the form, check to see if the new name is already in use --->
<cfif ModuleName.ModuleName NEQ #Form.ModuleName#>
	<!--- make sure the module name is not already used --->
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="CheckForExistingModule" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ModuleName
    FROM ApplicationModules
    WHERE ModuleName = '#FORM.ModuleName#'
    </CFQUERY>

	<!--- Module Name Not Found - New Name is OK - Proceed with editing this module --->
    <cfif CheckForExistingModule.RecordCount eq 0>
    
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="updateModule" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE ApplicationModules
    SET
    Notes=<CFQUERYPARAM VALUE="#FORM.Notes#" CFSQLTYPE="CF_SQL_CLOB">,
    ModuleName='#FORM.ModuleName#',
    SchemaName='#FORM.SchemaName#',
    TableName='#FORM.TableName#'
    WHERE mID = #url.mID#
    </CFQUERY>
    
    <cflocation url="modulesView_Details.cfm?mID=#URL.mID#&msg=All Changes Made&Type=Edit" addtoken="no">

	<!--- if the new module name is already in use, make the other changes, and alert the user that the module name cannot be changed --->
    <cfelseif CheckForExistingModule.RecordCount NEQ 0>
    
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="updateModule" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE ApplicationModules
    SET
    Notes=<CFQUERYPARAM VALUE="#FORM.Notes#" CFSQLTYPE="CF_SQL_CLOB">,
    SchemaName='#FORM.SchemaName#',
    TableName='#FORM.TableName#'
    WHERE mID = #url.mID#
    </CFQUERY>
    
    <cflocation url="modulesView_Details.cfm?mID=#URL.mID#&msg=New Module Name Already In Use - All other changes have been made&Type=Edit" addtoken="no">
    </cfif>
    
<!--- if the name has not changed, process the update --->
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="updateModule" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE ApplicationModules
    SET
    Notes=<CFQUERYPARAM VALUE="#FORM.Notes#" CFSQLTYPE="CF_SQL_CLOB">,
    SchemaName='#FORM.SchemaName#',
    TableName='#FORM.TableName#'
    WHERE mID = #url.mID#
    </CFQUERY>
    
    <cflocation url="modulesView_Details.cfm?mID=#URL.mID#&msg=All Changes Made&Type=Edit" addtoken="no">
</cfif>

<!--- If user form is not submitted, show the original output page and output form --->
<cfelse>

<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<!--- output page and output form --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModule" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationModules.ModuleName, ApplicationModules.Notes, ApplicationNames.aID, ApplicationNames.AppName, ApplicationModules.mID, ApplicationModules.SchemaName, ApplicationModules.TableName
FROM ApplicationModules, ApplicationNames
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationModules.mID = #URL.mID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModulePages" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT pID, FileName
FROM
ApplicationPages
WHERE mID = #URL.mID#
ORDER BY FileName
</CFQUERY>

<cfoutput query="ViewModule">
<b>Application Name</b>: <A href="modulesView.cfm?aID=#aID#">#AppName#</A><br />
<b>Module Name</b>: <a href="modulesView_Details.cfm?mID=#mID#">#ModuleName#</a><br />
<b>Schema Used</b>: #SchemaName#<br />
<b>Database Table(s) Used</b>: #TableName#<br /><br />

<b>Associated Files</b><Br>
<cfif viewModulePages.recordcount gt 0>
    <cfloop query="ViewModulePages">
    #FileName# - <a href="modulesView_FileView.cfm?pID=#pID#&mID=#URL.mID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0" align="absmiddle" alt="View File Details" /></a><br />
    </cfloop>
<cfelse>
	No Files<br />
</cfif><br />

<b>Description</b><br>
<cfif len(Notes)>#Notes#<cfelse>None Listed</cfif>
<br />

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.Query_String#">
<b>Edit This Module</b><Br>
<u>Module Name</u><br>
<cfinput name="ModuleName" type="text" size="80" value="#ModuleName#" required="yes" message="Enter the Module Name"><br><br>

<u>Schema Used</u><Br />
<cfinput name="SchemaName" type="text" size="80" value="#SchemaName#" required="yes" message="Enter the Schema Used"><br><br>

<u>Table(s) Used</u><br />
<cfinput name="TableName" type="text" size="80" value="#TableName#" required="yes" message="Enter the Table(s) Used"><br><br>

<u>Module Description</u><br>
<cftextarea name="Notes" rows="20" cols="60" value="#Notes#" required="yes" message="Enter a short description of the Module"></cftextarea><br><br>

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>

</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->