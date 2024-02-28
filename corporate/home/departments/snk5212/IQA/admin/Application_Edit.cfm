<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="getAppName" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AppName
FROM ApplicationNames
WHERE aID = #URL.aID#
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Application - #getAppName.AppName# -  Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Submit") AND isDefined("Form.AppName")>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="addFile" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE ApplicationNames
SET
AppName = '#Form.AppName#',
Notes = '#Form.Notes#'
WHERE aID = #URL.aID#
</CFQUERY>
    
<cflocation url="Applications.cfm?msg=#FORM.AppName#" addtoken="no">

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
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewApp" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT aID, AppName, Notes
FROM ApplicationNames
WHERE aID = #URL.aID#
</CFQUERY>

<cfoutput query="ViewApp">
    <cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.Script_Name#?#CGI.Query_String#">
    <b>Edit Application</b><Br><br />
    
    <u>Application Name</u><br>
    <cfinput name="AppName" value="#AppName#" type="text" size="40" required="yes" message="Enter the Application Name"><br><br>
    
    <u>Application Description</u><br>
    <cftextarea name="Notes" value="#Notes#" rows="6" cols="60" required="yes" message="Enter a short description of the Application"></cftextarea><br><br>
    
    <cfinput type="Submit" name="Submit" value="Submit">
    </cfform>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->