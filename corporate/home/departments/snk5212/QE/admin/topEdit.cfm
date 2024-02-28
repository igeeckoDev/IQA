<!--- DV_CORP_002 02-APR-09 --->
<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: b6ff4d29-90b0-4c58-8798-16fad5e03ffa Variable Datasource name --->
SELECT RH.ID, RH.FileName, Page_Content.ID, Page_Content.PageID FROM RH, Page_Content
WHERE RH.filename = '#url.filename#'
AND RH.ID = Page_Content.PageID
<!---TODO_DV_CORP_002_End: b6ff4d29-90b0-4c58-8798-16fad5e03ffa Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfoutput query="pageID">
	<cfset pcID = #Page_Content.ID#>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 3ba3f689-0cbf-4a2c-a6b3-0848949c802a Variable Datasource name --->
SELECT MAX(RevNo)+1 as MaxRev FROM Page_Content
WHERE filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: 3ba3f689-0cbf-4a2c-a6b3-0848949c802a Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Page Content Management">
<cfinclude template="SOP.cfm">

<!--- / --->

<Br>

<cfif isDefined("Form.RevDetails")>

<!--- add page_content stuff --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="update"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 052662f5-9a8c-438f-9bd4-cf0a3e846ba9 Variable Datasource name --->
UPDATE Page_Content
SET
content = '#form.content#'
WHERE ID = #pcID# AND PageID = #PageID.ID#
<!---TODO_DV_CORP_002_End: 052662f5-9a8c-438f-9bd4-cf0a3e846ba9 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!--- rev hist --->

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="RHmaxID"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 694a9ab3-ee81-475d-a3ca-58f4cf0c7520 Variable Datasource name --->
SELECT MAX(ID)+1 AS MAXID FROM RH
<!---TODO_DV_CORP_002_End: 694a9ab3-ee81-475d-a3ca-58f4cf0c7520 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cflock scope="Session" Timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="RHaddRow"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d729dc46-80f3-47c1-958a-6b4bc851279c Variable Datasource name --->
INSERT INTO RH(ID, filename, RevDate, RevAuthor, RevDetails, RevNo)
VALUES (#RHmaxID.MAXID#, '#PageID.filename#', '#curdate#', '#Session.Auth.Name#', '#Form.RevDetails#', #PageID2.MaxRev#)
<!---TODO_DV_CORP_002_End: d729dc46-80f3-47c1-958a-6b4bc851279c Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>
</cflock>

<cflocation url="#url.filename#" addtoken="No">

<cfelse>
<cfform name="IntroText" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<cfoutput>
<b><u>Intro Text</u></b> - #url.filename#<br><Br>

<cfset blank = "Insert Introductory Text Here">

<textarea WRAP="PHYSICAL" ROWS="25" COLS="75" NAME="content">#blank#</textarea>
<br><br>
</cfoutput>

<u>Document this revision:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="75" NAME="RevDetails" Value="" required="yes"></textarea><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->