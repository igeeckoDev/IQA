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
<!---TODO_DV_CORP_002_Start: 04561991-973b-4f1a-b792-b14d579999a8 Variable Datasource name --->
SELECT RH.ID, RH.FileName, Page_Content.ID, Page_Content.PageID 
FROM RH, Page_Content
WHERE RH.filename = '#url.filename#'
AND RH.ID = Page_Content.PageID
<!---TODO_DV_CORP_002_End: 04561991-973b-4f1a-b792-b14d579999a8 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!---Should show all Revs of particular file name<br>
<cfdump var="#PageID#">--->

<cfif PageID.RecordCount eq 0>
	<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 414a4f2b-6308-4efe-b510-19bbf9cc49dd Variable Datasource name --->
SELECT * FROM RH 
	WHERE RH.filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: 414a4f2b-6308-4efe-b510-19bbf9cc49dd Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	<cfset pID = #PageID.ID#>
	<cfset PageID2.MaxRev = 1>
<cfelse>
	<cfset pID = #PageID.PageID#>
	<!--- this is for the new rev number --->
	<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 999b18a5-8cc7-4390-b753-582060c29eac Variable Datasource name --->
SELECT MAX(RevNo)+1 as MaxRev FROM Page_Content
	WHERE pageID = #pID#
<!---TODO_DV_CORP_002_End: 999b18a5-8cc7-4390-b753-582060c29eac Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
</cfif>

<!---Should show maxRev using PageID2.MaxRev and pID
<cfdump var="#PageID2#">

<cfoutput>
Page ID - #pID#<br>
New Max Rev +1 = #PageID2.MaxRev#
</cfoutput>--->

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: a50d9335-db4d-4ddd-b6ba-34aecac848e5 Variable Datasource name --->
SELECT * FROM page_content
WHERE PageID = #pID#
AND Title = 'Intro Text'
AND RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #pID#)
<!---TODO_DV_CORP_002_End: a50d9335-db4d-4ddd-b6ba-34aecac848e5 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!---Should show only Max Rev details... Rev = 6
<cfdump var="#introText#">--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Page Content Management">
<cfinclude template="SOP.cfm">

<!--- / --->

<Br>

<cfif isDefined("Form.RevDetails")>

<!--- add new row --->
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxID"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 7b3daebc-5760-481b-afd2-6b03c3a29b37 Variable Datasource name --->
SELECT MAX(ID)+1 AS MAXID FROM Page_Content
<!---TODO_DV_CORP_002_End: 7b3daebc-5760-481b-afd2-6b03c3a29b37 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="addRow"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: a6ec56ce-3fe2-4750-b373-f2e7bc17959b Variable Datasource name --->
INSERT INTO Page_Content(ID, pageID, title)
VALUES(#maxID.MAXID#, #pID#, 'Intro Text')
<!---TODO_DV_CORP_002_End: a6ec56ce-3fe2-4750-b373-f2e7bc17959b Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cflock scope="Session" Timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="update"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 24ba7c8e-a3de-4133-bb17-a3254de5c203 Variable Datasource name --->
UPDATE Page_Content
SET
<!--- content --->
content = '#form.content#',
<!--- rev hist --->
RevDate = '#curdate#',
RevAuthor = '#SESSION.Auth.Name#',
RevDetails = '#Form.RevDetails#',
RevNo = #PageID2.MaxRev#

WHERE ID = #maxID.MAXID# AND PageID = #pID#
<!---TODO_DV_CORP_002_End: 24ba7c8e-a3de-4133-bb17-a3254de5c203 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
</cflock>

<cflocation url="#url.filename#" addtoken="No">

<cfelse>
<cfform name="IntroText" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<cfoutput>
<b><u>Intro Text</u></b> - #url.filename#<br><Br>
</cfoutput>

<cfoutput query="introText">
Previous Intro Text:
#content#
</cfoutput><br>

<cfset blank = "Enter New Text Here">

<textarea WRAP="PHYSICAL" ROWS="25" COLS="75" NAME="content"><cfoutput>#blank#</cfoutput></textarea>
<br><br>

<u>Document this revision:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="75" NAME="RevDetails">Initial Release</textarea><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->