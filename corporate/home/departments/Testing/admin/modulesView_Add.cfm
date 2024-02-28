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
<cfset subTitle = "Application Modules - Add Module to <b>#ModuleName.AppName#</b> Application">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit") AND isDefined("Form.ModuleName")>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="CheckForExistingModule" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ModuleName
FROM ApplicationModules
WHERE aID = #URL.aID#
AND ModuleName = '#FORM.ModuleName#'
</CFQUERY>

<!--- Module Not Found - Proceed with adding this module --->
<cfif CheckForExistingModule.RecordCount eq 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="getMaxID" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(mID)+1 as NewID
    FROM ApplicationModules
    </CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="addFile" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO	ApplicationModules(mID, aID, ModuleName, Notes, RevNo, RevDate, RevHistory, SchemaName, TableName)
    VALUES(#getMaxID.NewID#, #URL.aID#, '#FORM.ModuleName#', <CFQUERYPARAM VALUE="#Form.Notes#" CFSQLTYPE="CF_SQL_CLOB">, 1, #now()#, 'Module Added', '#FORM.SchemaName#', '#FORM.TableName#')
    </CFQUERY>
    
    <cflocation url="modulesView.cfm?aID=#URL.aID#&msg=#FORM.ModuleName#" addtoken="no">
<!--- Module Found - alert user --->
<cfelse>
	<cfoutput>
	Module (#FORM.ModuleName#) has already been added to this Application<br><br>
    
    <u>Options</u><br>
    :: <a href="modulesView_Add.cfm?aID=#URL.aID#">Add Module to #ModuleName.AppName# Application</a><br>
    :: <a href="modulesView.cfm?aID=#URL.aID#">View Application</a>
    </cfoutput>
</cfif>

<!--- If user form is not submitted, show the original output page and output form --->
<cfelse>

<!--- formatted textarea boxes --->
<cfinclude template="#SiteDir#SiteShared/incTextarea.cfm">

<!--- output page and output form --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApp" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationModules.ModuleName, ApplicationModules.RevNo, ApplicationModules.RevDate, ApplicationModules.RevHistory, ApplicationModules.Notes, ApplicationNames.aID, ApplicationNames.AppName
FROM ApplicationModules, ApplicationNames
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationNames.aID = #URL.aID#
ORDER BY ApplicationModules.ModuleName
</CFQUERY>

<cfoutput>
<b>Application Name</b>: #ModuleName.AppName#<br /><br />
</cfoutput>

<b>Associated Modules</b><Br>
<cfif viewApp.recordcount gt 0>
    <cfoutput query="ViewApp">
    #ModuleName#<br />
    </cfoutput>
<cfelse>
	No Modules<br />
</cfif><br />

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.Query_String#">
<b>Add Module</b><Br>
<u>Module Name</u><br>
<cfinput name="ModuleName" type="text" size="80" required="yes" message="Enter the Module Name"><br><br>

<u>Schema Used</u><Br />
<cfinput name="SchemaName" type="text" size="80" required="yes" message="Enter the Schema Used"><br><br>

<u>Table(s) Used</u><br />
<cfinput name="TableName" type="text" size="80" required="yes" message="Enter the Table(s) Used"><br><br>

<u>Module Description</u><br>
<cftextarea name="Notes" rows="20" cols="60" required="yes" message="Enter a short description of the Module"></cftextarea><br><br>

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->