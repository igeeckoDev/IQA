<!--- Start of Page File --->
<cfset subTitle = "Applications - Add">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit") AND isDefined("Form.AppName")>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="CheckForExistingApp" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT aID, AppName
FROM ApplicationNames
WHERE AppName = '#FORM.AppName#'
</CFQUERY>

<!--- File Not Found - Proceed with adding file to this module --->
<cfif CheckForExistingApp.RecordCount eq 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="getMaxID" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(aID)+1 as NewID
    FROM ApplicationNames
    </CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="addFile" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO	ApplicationNames(aID, AppName, Notes)
    VALUES(#getMaxID.NewID#, '#FORM.AppName#', <CFQUERYPARAM VALUE="#Form.Notes#" CFSQLTYPE="CF_SQL_CLOB">)
    </CFQUERY>
    
    <cflocation url="Applications.cfm?msg=#FORM.AppName#" addtoken="no">
<!--- File Found - alert user --->
<cfelse>
	<cfoutput>
	The Application named (#FORM.AppName#) is already listed.<br><br>
    
    <u>Options</u><br>
    :: <a href="Application_Add.cfm?">Add Application</a><br>
    :: <a href="Applications.cfm">View Applications</a>
    </cfoutput>
</cfif>

<!--- If user form is not submitted, show the original output page and output form --->
<cfelse>

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<!--- output page and output form --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationNames.aID, ApplicationNames.AppName, ApplicationNames.Notes
FROM ApplicationNames
ORDER BY AppName
</CFQUERY>

<table border="1">
<tr>
    <th align="center">Application Name</th>
	<th align="center">Application Notes</th>
    <th align="center">View Application</th>
</tr>
<cfoutput query="ViewModules">
<tr>
	<td align="left">#AppName#</td>
	<td align="left">#Notes#</td>
    <td align="center">
    	<a href="modulesView.cfm?aID=#aID#"><img src="#SiteDir#SiteImages/table_row.png" border="0" align="absmiddle" /></a>
    </td>
</tr>
</cfoutput>
</table>
<br><br>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.Query_String#">
<b>Add Application</b><Br><br />

<u>Application Name</u><br>
<cfinput name="AppName" type="text" size="40" required="yes" message="Enter the Application Name"><br><br>

<u>Application Description</u><br>
<cftextarea name="Notes" rows="4" cols="60" required="yes" message="Enter a short description of the Application"></cftextarea><br><br>

<cfinput type="Submit" name="Submit" value="Submit">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->